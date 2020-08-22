/*
 * A predicate that reads the input from File and returns it in
 * the last three arguments: N, K and C.
 * Example:
 *
 * ?- read_input('c1.txt', N, K, C).
 * N = 10,
 * K = 3,
 * C = [1, 3, 1, 3, 1, 3, 3, 2, 2|...].
 */

read_input(File, N, K, C) :-
    open(File, read, Stream),
    read_line(Stream, [N, K]),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).


colorsSamble(S,K,Samble):-
    S=<K -> member(S,Samble),L is S+1, colorsSamble(L,K,Samble);
    true.

append([],[],L,L).
append([],[H|T],L,[H|R]) :- append([],T,L,R).
append([H|T],L0,L1,[H|R]) :- append(T,L0,L1,R).

eq([],[]).
eq([HX|RX],[HY|RY]):-
    HX=HY,
    eq(RX,RY).

subseq(_,[]):-false.
subseq([],[]):-false.
subseq([],_).

subseq(X,Y):-
    append(_,X,_,Y).





checkColors(_,[],_):-false.
checkColors(K,C,End):-
    length(M,End),
    append(M,_,C),
    colorsSamble(1,K,M).

min(A,B,Ans):-
    A>B->
        Ans=B;
        Ans=A.

colorsDelete(K,[F|L],EndIn,Ans,Min):-
    T is EndIn-1,
    checkColors(K,L,T)->(
        min(Min,T,An),
        colorsDelete(K,L,T,Ans1,An),
        min(Ans1,An,Ans));
    colorsHelp(K,[F|L],EndIn,Ans,Min).


colorsHelp(K,[F|L],EndIn,Ans,Min):-
    T is EndIn-1,
    K=<EndIn,
    (checkColors(K,[F|L],EndIn)->
        (min(Min,T,An),
        colorsDelete(K,L,T,Ans1,An),
        min(Ans1,An,Ans));
        (EndNew is EndIn+1,
        colorsHelp(K,[F|L],EndNew,Ans,Min))
    ).


  




colors(File,Ans):-
    read_input(File,N,K,C),
    once(colorsHelp(K,C,K,Ans,N)).
colors(File,0):-
    read_input(File,_,K,C),
    \+ colorsHelp(K,C,K,_,_).