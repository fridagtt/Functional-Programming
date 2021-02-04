% ====================
% Complete the following programs and submit your file to Canvas.
% ====================
% Do not change the names of the programs.
% Do not change the number of elements in the clauses.
% If your file cannot be loaded by the Prolog interpreter, your submission may be cancelled.
% Then, submit only code that works.
% ====================
% Grading instructions:
% There is a series of test cases for each program. In order to state that your program
% "works as described", your output must be similar to the expected one in each case.

:- use_module(library(clpfd)).

before(X, Y, Solution) :-
    nth1(X1, Solution, X),
    nth1(Y1, Solution, Y),
    X1 < Y1.

after(X, Y, Solution) :-
    before(Y, X, Solution).

right(X, Y, L) :- append(_, [X, Y|_], L).
next(X, Y, L):- right(X, Y, L) ; right(Y, X, L).

chess(Solution) :-
   length(Solution,4),
   member(erick,Solution),
   member(charles,Solution),
   member(logan,Solution),
   member(scott,Solution),
   nth1(Erick,Solution,erick),
   nth1(Charles,Solution,charles),
   nth1(Logan,Solution,logan),
   nth1(Scott,Solution,scott),
   Logan < Erick,
   Logan < Charles,
   Scott > Erick,
   Scott < Charles.

classes(Solution) :-
    length(Solution,3),
    member([monday,_,_],Solution),
    member([wednesday,_,_],Solution),
    member([friday,_,_],Solution),
    member([_,_,steve],Solution),
    member([_,math,_],Solution),
    member([_,programming,_],Solution),
    after([_,_,mary],[_,logic,_],Solution),
    \+member([monday,_,robert], Solution),
    \+member([monday,logic,_], Solution), !.

bags(Solution) :-
    length(Solution,3),
    member([pink,_],Solution),
    member([red,_],Solution),
    member([_,corn],Solution),
    member([_,wheat],Solution),
    member([white,sorghum],Solution),
    \+member([pink,wheat],Solution), !.

tmnt(Solution) :-
    length(Solution,4),
    member(raphael,Solution),
    member(leonardo,Solution),
    member(michelangelo,Solution),
    member(donatello,Solution),
    after(raphael,leonardo,Solution),
    after(michelangelo,donatello,Solution),
    before(michelangelo,leonardo,Solution), !.

edge(a,d,10).
edge(b,c,3).
edge(c,e,4).
edge(e,h,1).
edge(f,g,3).
edge(g,h,7).
edge(d,f,4).
edge(d,g,11).
edge(d,e,12).
edge(d,b,5).

escape(X,Y,P,Time) :- edge(X,Y,Time), append([X],[Y],P).
escape(X,Y,P,Time) :- edge(X,Z,EdgeTime), escape(Z,Y,RestPath,RestTime), append([X],RestPath,P), Time is EdgeTime + RestTime, Time < 25.
    
pert(T1,T2,T3,T4):-
    T1 = [0,ET1],
    ET1 is 3,
    T2 = [ET1,ET2],
    ET2 is ET1 + 8,
    T3 = [ET1,ET3],
    ET3 is ET1 + 5,
    T4 = [ST4,ET4],
    ST4 is max(ET2,ET3),
    ET4 is ST4 + 4.

swimmer(Solution):-
    length(Solution,4),
    member(isabel,Solution),
    member(julia,Solution),
    member(felicitas,Solution),
    member(elena,Solution),
    after(julia,isabel,Solution),
    before(julia,felicitas,Solution),
    after(isabel,elena,Solution).

letters(Solution):-
   length(Solution,4),
   member(a,Solution),
   member(b,Solution),
   member(c,Solution),
   member(d,Solution),
   after(a,b,Solution),
   before(d,c,Solution),
   after(d,b,Solution).

race(Solution):-
    length(Solution,8),
    member(lino,Solution),
    member(rubi,Solution),
    member(sam,Solution),
    member(mac,Solution),
    member(lulo,Solution),
    member(chato,Solution),
    member(toto,Solution),
    member(curcho,Solution),
    nth1(XLino,Solution,lino),
    nth1(XRubi,Solution,rubi),
    XLino is XRubi + 3,
    nth1(XSam,Solution,sam),
    XLino is XSam - 1,
    before(mac,chato,Solution),
    after(mac,rubi,Solution),
    nth1(XLulo,Solution,lulo),
    nth1(XChato,Solution,chato),
    XLulo is XChato - 3,
    nth1(XCurcho,Solution,curcho),
    XCurcho > 5,
    after(toto,sam,Solution), !.

solveCrossword(A1,A2,D1,D2,D3):-
    L=[
        [h,a,s,k,e,l,l],
        [r,a,c,k,e,t],
        [p,r,o,l,o,g],
        [e,r,l,a,n,g],
        [a,w,e,s,o,m,e]
      ],
    member(A1,L),
    member(A2,L),
    member(D1,L),
    member(D2,L),
    member(D3,L),
    A1 = [_,X1,_,_,X2,_],
    A2 = [_,X3,_,_,_,X4,_],
    D1 = [X1,_,_,_,_,_,_],
    D2 = [X2,_,_,X3,_,_],
    D3 = [_,_,_,X4,_,_], !.

csp(X1,X2,X3,X4,X5):-
    L1 = [1,3,4],
    L2 = [1,2,3],
    member(X1,L1),
    member(X3,L1),
    member(X2,L2),
    member(X4,L2),
    member(X5,L2),
    X1 > X2,
    X1 is X3,
    X3 > X2,
    X5 =< X2,
    X2 < X4, !.
% === travelTime ===

travelTime(Time):-
    A is 4,
    C is A -1,
    B is 4 * C,
    Time is 2 * B.

% === cellGames ===

cellGame(Solution) :-
    length(Solution,3),
    member(goku,Solution),
    member(vegeta,Solution),
    member(gohan,Solution),
    after(vegeta,gohan,Solution),
    before(goku,gohan,Solution).

% === ages ===

ages(J, L, F, Y) :-
    between(13,20, J),
    between(13,20, L),
    between(13,20, F),
    all_different([J, L, F]),
    46 is J+L+F,
    Y is 39/3,
    F+Y =:= J*2.

% === gardeningContest ===

gardeningContest(Solution) :-
    length(Solution,3),
    after([brooke,_],[_,vanity],Solution),
    after([brooke,_],[_,gold_blush],Solution),
    Solution = [_,_,[_,quietness]],
    member([virginia,vanity],Solution),
    member([tricia,gold_blush],Solution),
    Solution = [_,[tricia,_],_].

% === tournament ===

tournament(CA, A, T, R, C) :-
    CA is 28,
    C is CA - 5,
    T is 20,
       between(21, 27, A),
    between(21, 27, R),
    C > R,
    C > T,
    C < A,
    CA - A =:= 2 * (R - T). %comparing value not giving

% === zebra ===

zebra(Solution) :-
    length(Solution,5), %[owner,animal,cigarette,drink,color]
    member([english,_,_,_,red],Solution),
    member([spanish,dog,_,_,_],Solution),
    member([_,_,_,coffee,green],Solution),
    member([ukrainian,_,_,tea,_],Solution),
    next([_,_,_,_,green],[_,_,_,_,white],Solution),
    member([_,serpent,winston,_,_],Solution),
    member([_,_,kool,_,yellow],Solution),
    Solution = [_,_,[_,_,_,milk,_],_,_],
       Solution = [[norwegian,_,_,_,_],_,_,_,_],
    next([_,_,chesterfield,_,_], [_,fox,_,_,_],Solution),
    next([_,horse,_,_,_],[_,_,kool,_,_],Solution),
    member([_,_,lucky,juice,_],Solution),
    member([japonese,_,kent,_,_],Solution),
    next([norwegian,_,_,_,_],[_,_,_,_,blue],Solution),
    member([_,zebra,_,_,_],Solution),
    member([_,_,_,water,_],Solution).

start :-
    write("% === travelTime ==="), nl,
    travelTime(Time), % 24
    write(Time), nl,
    write("% === cellGames ==="), nl,
    cellGame(Order), % [goku,gohan,vegeta]
    write(Order), nl,
    write("% === ages ==="), nl,
    ages(J, L, F, Y), % [14,17,15,13]
    Names = [J, L, F, Y],
    write(Names), nl,
    write("% === gardeningContest ==="), nl,
    gardeningContest(Results),
    write(Results), nl,
    write("% === tournament ==="), nl,
    tournament(CruzAzul, America, Tigres, Rayados, Chivas), % [28,24,20,22,23]
    Teams = [CruzAzul, America, Tigres, Rayados, Chivas],
    write(Teams), nl,
    write("% === zebra ==="), nl, % [[norwegian,fox,kool,water,yellow],[ukrainian,horse,chesterfield,tea,blue],[english,snake,winston,milk,red],[japonese,zebra,kent,coffee,green],[spanish,dog,lucky,juice,white]]
    zebra(Solution),
    write(Solution), nl, !.
