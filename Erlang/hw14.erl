-module(hw14).
-export([start/0]).

% ====================
% Complete the following functions and submit your file to Canvas.
% ====================
% Do not change the names of the functions. 
% Do not change the number of arguments in the functions.
% If your file cannot be loaded by the Erlang compiler, your submission may be cancelled. 
% Then, submit only code that works.
% ====================
% Grading instructions:
% There is a series of test cases for each function. In order to state that your function
% "works as described", your output must be similar to the expected one in each case.

% === pow ===
pow(Number, Pow) -> powAux(Number, Pow, Number).

powAux(_, 0, _) -> 1;
powAux(_, 1, Accum) -> Accum;
powAux(Number, Pow, Accum) -> powAux(Number, Pow - 1, Number* Accum).
% pow(5, 3) -> 125
% powAux(5,3,5)
% powAux(5,2,25)
% powAux(5,1,125) -> 125

% === fibinacci ===
fibonacci(Number) -> fibonacciAux(0, 1, Number).

fibonacciAux(First, _, 0) -> First;
fibonacciAux(First, Second, Number) -> fibonacciAux(Second, First + Second, Number - 1).
% fibonacci(10) -> 55
% fibAux(0,1,10) 
% fibAux(1,1,9)
% fibAux(1,2,8)
% fibAux(2,3,7)
% fibAux(3,5,6)
% fibAux(5,8,5)
% fibAux(8,13,4)
% fibAux(13,21,3)
% fibAux(21,34,2)
% fibAux(34,55,1)
% fibAux(55,89,0)

% === reverse ===
reverse(List) -> reverseAux(List, []).

reverseAux([], Accum) -> Accum; %when I have moved over the whole list
reverseAux([Head | Tail], Accum) -> reverseAux(Tail, [Head | Accum]).
%	reverse([33, 45, 18, 17, 25, 62, 100]) -> [100,62,25,17,18,45,33]
%reverseAux([33 | 45, 18, 17, 25, 62, 100],[])
%reverseAux([45 | 18, 17, 25, 62, 100],[33])
%reverseAux([18 | 17, 25, 62, 100],[45, 33])
%reverseAux([17 | 25, 62, 100],[18, 45, 33])
%reverseAux([25 | 62, 100],[17, 18, 45, 33])
%reverseAux([62 | 100],[25, 17, 18, 45, 33])
%reverseAux([100],[62, 25, 17, 18, 45, 33])
%reverseAux([],[100, 62, 25, 17, 18, 45, 33]) -> [100, 62, 25, 17, 18, 45, 33]

% === count ===
count(List, Number) -> countAux(List, Number, 0).

countAux([], _, Accum) -> Accum;
countAux([Head | Tail], Number, Accum) -> if 
    Head == Number -> countAux(Tail, Number, Accum + 1);
    true -> countAux(Tail, Number, Accum)
  end.

%count([1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 1], 1) -> 3
%countAux([1 | 2, 3, 4, 5, 5, 4, 3, 2, 1, 1], 1, 0)
%countAux([2 | 3, 4, 5, 5, 4, 3, 2, 1, 1], 1, 1)
%countAux([3 | 4, 5, 5, 4, 3, 2, 1, 1], 1, 1)
%countAux([4 | 5, 5, 4, 3, 2, 1, 1], 1, 1)
%countAux([5 | 5, 4, 3, 2, 1, 1], 1, 1)
%countAux([5 | 4, 3, 2, 1, 1], 1, 1)
%countAux([4 | 3, 2, 1, 1], 1, 1)
%countAux([3 | 2, 1, 1], 1, 1)
%countAux([2 | 1, 1], 1, 1)
%countAux([1 | 1], 1, 2)
%countAux([], 1, 3) -> 3

% === sum ===
sum(List) -> sumAux(List, 0).

sumAux([], Accum) -> Accum; %when I have moved over the whole list
sumAux([Head | Tail], Accum) -> sumAux(Tail, Accum + Head).

% === Test cases ===

start() -> 
	io:format("=== pow ===~n"),
	io:format("~p~n", [pow(2, 10)]), % 1024
	io:format("~p~n", [pow(5, 3)]), % 125
	io:format("=== fibonacci ===~n"),
	io:format("~p~n", [fibonacci(5)]), % 5
	io:format("~p~n", [fibonacci(10)]), % 55
	io:format("=== reverse ===~n"),	
	io:format("~p~n", [reverse([33, 45, 18, 17, 25, 62, 100])]), % [100,62,25,17,18,45,33]
	io:format("~p~n", [reverse([10, 20, 30, 40, 50])]), % [50,40,30,20,10]
	io:format("=== count ===~n"),
	io:format("~p~n", [count([1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 1], 1)]), % 3
	io:format("~p~n", [count([1, 2, 3, 4, 5, 3, 10, 3, 5, 3, 4, 3, 2, 1, 1, 3], 3)]), % 6
	io:format("=== sum ===~n"),
	io:format("~p~n", [sum([33, 45, 18, 17, 25, 62, 100])]), % 300
	io:format("~p~n", [sum([10, 20, 30, 40, 50])]). % 150