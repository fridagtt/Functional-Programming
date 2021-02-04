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

:- use_module(library(bounds)).

% === travelTime ===

travelTime(Time):-
    A is 4,
    C is A -1,
    B is 4 * C,
    Time is 2 * B.

% === cellGames ===

before(X, Y, Solution) :-
    nth1(X1, Solution, X),
    nth1(Y1, Solution, Y),
    X1 < Y1.

after(X, Y, Solution) :-
    before(Y, X, Solution).

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
    Y is 39/3, % after algebra clearance
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
    CA - A =:= 2 * (R - T). % comparing value not giving

% === zebra ===

right(X, Y, L) :- append(_, [X, Y|_], L).
next(X, Y, L):- right(X, Y, L) ; right(Y, X, L).

zebra(Solution) :-
    length(Solution,5), % [owner,animal,cigarette,drink,color]
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
