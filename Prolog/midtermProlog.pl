:- use_module(library(clpfd)).

before(X, Y, Solution) :-
    nth1(X1, Solution, X),
    nth1(Y1, Solution, Y),
    X1 < Y1.

after(X, Y, Solution) :-
    before(Y, X, Solution).

right(X, Y, L) :- append(_, [X, Y|_], L).
next(X, Y, L):- right(X, Y, L) ; right(Y, X, L).

cows(Solution) :-
    length(Solution,2),
    member([Black,black],Solution),
    member([Brown,brown],Solution),
    between(22,32,Black),
    between(22,32,Brown),
    (4*Black + 2*Brown) * 5 =:= (3*Black + 5*Brown) * 4, !.

ages(Tom,Howard,Jack) :-
    between(35,50,Tom),
    between(35,50,Howard),
    between(35,50,Jack),
    all_different([Tom, Howard, Jack]),
    HY is Howard + 12,
    Tom is HY - 5,
    Howard is Jack - 3,
    mod(Howard,7) =:= 0, !.
    
% XY
% BAT
% MAN
% ----
% BANE

sum(B,A,T,M,N,E) :-
    between(0,9,M),
    between(0,9,A),
    between(0,9,T),
    between(0,1,B),
    between(0,9,N),
    between(0,9,E),
    between(0,1,X),
    between(0,1,Y),
    E is (T + N) mod 10,
    Y is (T + N) div 10,
    N is (A + A + Y) mod 10,
    X is (A + A + Y) div 10,
    A is (B + M + X) mod 10,
    B is (B + M + X) div 10,
    all_different([B,A,T,M,N,E]).


edge(a,c,black).
edge(c,b,red).
edge(c,e,red).
edge(c,d,black).
edge(b,e,black).
edge(d,e,black).
edge(d,f,red).
edge(e,g,black).
edge(e,h,red).
edge(f,b,black).
edge(g,h,black).

path(X,Y,P,Colors) :- edge(X,Y,Colors), append([X],[Y],P).
path(X,Y,P,Colors) :- edge(X,Z,EdgeColors), path(Z,Y,RestPath,RestColors), append([X],RestPath,P), append([EdgeColors],RestColors,Colors). %faltó verificar que en la lista solo aparezca el atomo red una vez

masters(Q1,Q2,Q3,Q4):-
    L=[
        [h,e,m,a,n],
        [h,o,r,d,a,k],
        [k,e,l,d,o,r],
        [s,h,e,r,a]
      ],
    member(Q1,L),
    member(Q2,L),
    member(Q3,L),
    member(Q4,L),
    Q1 = [_,_,_,r,a],
    Q2 = [h,_,_,_,_],
    member(e,Q3),
    \+member(m,Q3),
    Q4 = [_,_,r,_,a,_],!.
