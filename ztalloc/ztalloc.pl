
read_input(File, Q, C) :-
    open(File, read, Stream),
    read_Num(Stream, Q),
    read_file(Stream, C).

read_Num(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).


read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line(Stream,X),
    read_file(Stream,L).



ztalL([],In,In).
ztalL([],In,Out):-
    Out=<In.
ztalL(['h'],In,Out):-
    Out =< div(In,2).

ztalL(['t'],In,Out):-
    Out =< 3*In +1 .

ztalL(['h'|R],In,Out):-
    Tem is div(In,2),
    ztalL(R,Tem,Out).

ztalL(['t'|R],In,Out):-
    Tem is 3*In +1 ,
    Tem <1000000,
    ztalL(R,Tem,Out).

ztalR([],In,In).
ztalR([],In,Out):-
    Out>=In.
ztalR(['h'],In,Out):-
    Out >= div(In,2).

ztalR(['t'],In,Out):-
    Out >= 3*In +1 .

ztalR(['h'|R],In,Out):-
    Tem is div(In,2),
    ztalR(R,Tem,Out).

ztalR(['t'|R],In,Out):-
    Tem is 3*In +1 ,
        Tem <1000000,
    ztalR(R,Tem,Out).

sol([Lin,Rin,Lout,Rout],['E','M','P','T','Y']):-
    ztalL([],Lin,Lout),
    ztalR([],Rin,Rout).


sol([Lin,Rin,Lout,Rout],Ans):-
    length(Ans,N),
    N < 20,
    ztalL(Ans,Lin,Lout),
    ztalR(Ans,Rin,Rout).
sol(_,['I','M']).

solve([],[]).


solve([X|Xrest],[Ystr|Yrest]):-
    sol(X,Y),
    atom_chars(Ystr, Y),
    solve(Xrest,Yrest).

ztalloc(File,Ans):-
    read_input(File,_,C),
    once(solve(C,Ans)).
