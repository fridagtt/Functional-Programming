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

% === duplicate ===

duplicate([],[]).
duplicate([Head|Tail], X) :- append([Head],[Head],Y), duplicate(Tail,RestX), append(Y,RestX,X), !.

% === sum ===

sum([], 0).
sum([Head|Tail], Sum) :- is_list(Head), sum(Tail, RestSum), Sum is RestSum, !.
sum([Head|Tail], Sum) :- sum(Tail, RestSum), Sum is Head + RestSum, !.

% === toBinaryString ===

toBinaryString(0,"0").
toBinaryString(1,"1").
toBinaryString(Number,Result) :- Remainder is mod(Number,2), Quotient is div(Number,2), toBinaryString(Quotient,Y), string_concat(Y,Remainder,Result).

% === isort ===
insert(X, [], [X]).
insert(X, [Head|Tail], [X, Head|Tail]):- X =< Head.
insert(X, [Head|Tail], [Head|L]):- insert(X, Tail, L).

isort([], []). 
isort([Head|Tail], Order):- isort(Tail, NextOrder), insert(Head, NextOrder, Order).

% === magicSquare ===

% |-------|
% | A B C |
% | D E F |
% | G H I |
% |-------|

magicSquare([A, B, C, D, E, F, G, H, I]) :-
	between(1, 9, A),
	between(1, 9, B),
	between(1, 9, C),
    15 is A+B+C,
	between(1, 9, D),
	between(1, 9, E),
	between(1, 9, F),
    15 is D+E+F,
	between(1, 9, G),
	between(1, 9, H),
	between(1, 9, I),
   	15 is G+H+I,
    15 is A+D+G,
    15 is C+E+G,
    15 is B+E+H,
	15 is C+F+I,
	15 is A+E+I,
	all_different([A, B, C, D, E, F, G, H, I]).

% === path ===

edge(a, c, 5).
edge(c, b, 6).
edge(c, d, 8).
edge(b, e, 8).
edge(d, e, 2).
edge(e, f, 3).
edge(e, g, 7).
edge(f, g, 1).

path(X,Y,P,Cost) :- edge(X,Y,Cost), append([X],[Y],P).
path(X,Y,P,Cost) :- edge(X,Z,EdgeCost), path(Z,Y,RestPath,RestCost), append([X],RestPath,P), Cost is EdgeCost + RestCost.

start :-
	write("% === duplicate ==="), nl, 
	duplicate([], X1), % []
	write(X1), nl,
	duplicate([1, 2, 3], X2), % [1,1,2,2,3,3]
	write(X2), nl,
	duplicate(X3, [a, a, b, b]), % [a,b]
	write(X3), nl,
	write("% === sum ==="), nl, 
	sum([], X4), % 0
	write(X4), nl,
	sum([1, 2, 3, 4, 5, 6], X5), % 21
	write(X5), nl,
	sum([1, [2, 3], [4, 5, 6], 7], X6), % 8
	write(X6), nl,
	write("% === toBinaryString ==="), nl, 
	toBinaryString(0, X7), % 0
	write(X7), nl,
	toBinaryString(1, X8), % 1
	write(X8), nl,
	toBinaryString(32, X9), % 100000
	write(X9), nl,
	toBinaryString(572, X10), % 1000111100
	write(X10), nl,
	write("% === isort ==="), nl, 
	isort([1, -1, 2, 10, 3], X11), % [-1,1,2,3,10]
	write(X11), nl, 
	write("% === magicSquare ==="), nl, 
	magicSquare(X12), % Many answers, check the constraints. 
	write(X12), nl,
	write("% === path ==="), nl, 
	path(a, e, PathAE, CostAE), % [a,c,b,e], 19
	write(PathAE), write(", "), write(CostAE), nl,
	path(d, g, PathDG, CostDG), % [d,e,g], 9
	write(PathDG), write(", "), write(CostDG), nl, !.
