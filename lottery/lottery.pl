
read_input(File, N, K, Q, C) :-
    open(File, read, Stream),
    read_line(Stream, [K, N, Q]),
    read_file(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).


read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, Line),
    maplist(plus(-48), Line, Y),
    reverse(X,Y),
    read_file(Stream,L).
split(C,N,Q,Lot,Win):-
    length(Lot,N),
    length(Win,Q),
    append(Lot,Win,C).
sum([],0).
sum([X|Tail],Sum):-
        sum(Tail,Temp),
        Sum is Temp+X.


lottary_help(_,[],_,_,_):-false.
lottary_help(Lot,XWin,K,Same,Ev):-
    nth0(Same,XWin,X),
    length(Ev,K),
    member(Ev,Lot),
    nth0(Same,Ev,X).
sector(L,K,Sols1,Sols2):-
    length(L,K),
    member(L,Sols1),\+ member(L,Sols2).

lottary_help_money(_,_,K,S,[],_):-S>=K.
lottary_help_money([],_,_,_,_,_):-false.

lottary_help_money(Sols1,XWin,K,Same,[An|X],ModNum):-
    Same<K,
    S is Same+1,
    findall(Ev,lottary_help(Sols1,XWin,K,S,Ev),Sols2),
    findall(L,sector(L,K,Sols1,Sols2),Star),
    length(Star,Num),
    An is Num*(2**S -1) mod ModNum ,
    lottary_help_money(Sols2,XWin,K,S,X, ModNum) .

solve_money(Lot,XWin,K,An2,ModNum):-
    findall(Ev,lottary_help(Lot,XWin,K,0,Ev),Sols),
    lottary_help_money(Sols,XWin,K,0,An,ModNum),
    sum(An, An2).







lottary_solver(_,[],_,_,[],_).
lottary_solver(Lot,[XWin|Rest],K,Q,[An|Next],ModNum):-
    findall(Ev,lottary_help(Lot,XWin,K,0,Ev),Sols),
    length(Sols,An1),
    solve_money(Lot,XWin,K,An2,ModNum),
    An=[An1,An2],
    lottary_solver(Lot,Rest,K,Q,Next,ModNum) .





lottery(File,Ans):-
    read_input(File,N,K,Q,C),
    split(C,N,Q,Lot,Win),
    ModNum is 10**9 +7,
    once(lottary_solver(Lot,Win,K,Q,Ans,ModNum)).




