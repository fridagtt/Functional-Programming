-module(hw15).
-export([test01/0, append/1, test02/0, friend/1, test03/0, marco/3, polo/2, test04/0, bank/1, auxBank/4]).

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

% === append ===

append(List) -> 
    receive
        X when is_number(X) and (X >= 0) -> append(List ++ [X]);
        _ -> io:format("~p~n",[List])
    end.
test01() -> 
	io:format("=== append ===~n"),
	Pid = spawn(hw15, append, [[]]),
	Pid ! 5, 	% Nothing printed on screen.
	Pid ! 10, 	% Nothing printed on screen.
	Pid ! 14, 	% Nothing printed on screen.
	Pid ! x, 	% The process ends and prints [5, 10, 14] on screen.
	Pid ! 5, 	% Nothing happens since the process has already finished.
	ok.			% This is the return value for test01 (it will eventually be printed on screen).

% === friend ===

friend(Color) ->
    receive
        {Pid, Message} -> Pid ! {self(), Color, Message}, friend(Color); %Send Message. Send the process my color and my own id and the message the terminal told me to send you
        {Pid, C, Message} -> if
            C == Color -> io:format("~p: ~p~n", [Pid, Message]), friend(Color);
            true -> friend(Color)
        end
    end.

test02() -> 
	io:format("=== friend ===~n"),
	P1 = spawn(hw15, friend, [red]), %create processes with a color assigned.
	P2 = spawn(hw15, friend, [green]),
	P3 = spawn(hw15, friend, [blue]),	
	P4 = spawn(hw15, friend, [green]),
	P1 ! {P2, "A la grande le puse cuca."},
	P2 ! {P4, "Hable más fuerte que tengo una toalla."},
	P3 ! {P4, "Tiene todo el dinero del mundo, pero hay algo que no puede comprar... un dinosaurio."},
	P4 ! {P1, "na na na na na na na na, líder."},
	P4 ! {P2, "¿Qué te pasó, viejo? Antes eras chévere."},
	ok.
	% Only two of the phrases are printed on screen (the PID is likely to be different):
	% I received a message from a friend (<0.227.0>): "Hable más fuerte que tengo una toalla.".
	% I received a message from a friend (<0.229.0>): "¿Qué te pasó, viejo? Antes eras chévere.".
	% ok will eventually be printed on screen.

% === marcopolo ===

marco(Pid, MarcoPositionX, MarcoPositionY) -> 
    Pid ! {self(), MarcoPositionX, MarcoPositionY}, %send polo my pid and my positions
    receive
        {Pid, NewPosX, NewPosY} -> marco(Pid, NewPosX, NewPosY) %change my positions
    end.

polo(PoloPositionX, PoloPositionY) ->
    receive
        {Pid, X, Y} -> if
            (X < PoloPositionX) and (Y < PoloPositionY) -> io:format("Marco moves too (~p, ~p)~n", [X+1, Y+1]), Pid ! {self(), X+1, Y+1}, polo(PoloPositionX, PoloPositionY);
            (X > PoloPositionX) and (Y > PoloPositionY) -> io:format("Marco moves to22 (~p, ~p)~n", [X-1, Y-1]), Pid ! {self(), X-1, Y-1}, polo(PoloPositionX, PoloPositionY);
            (X > PoloPositionX) and (Y < PoloPositionY) -> io:format("Marco moves to33 (~p, ~p)~n", [X-1, Y+1]), Pid ! {self(), X-1, Y+1}, polo(PoloPositionX, PoloPositionY);
            (X < PoloPositionX) and (Y > PoloPositionY) -> io:format("Marco moves to44 (~p, ~p)~n", [X+1, Y-1]), Pid ! {self(), X+1, Y-1}, polo(PoloPositionX, PoloPositionY);
            X < PoloPositionX -> io:format("Marco moves to1 (~p, ~p)~n", [X+1, Y]), Pid ! {self(), X+1, Y}, polo(PoloPositionX, PoloPositionY);
            X > PoloPositionX -> io:format("Marco moves to2 (~p, ~p)~n", [X-1, Y]), Pid ! {self(), X-1, Y}, polo(PoloPositionX, PoloPositionY);
            Y < PoloPositionY -> io:format("Marco moves to3 (~p, ~p)~n", [X, Y+1]), Pid ! {self(), X, Y+1}, polo(PoloPositionX, PoloPositionY);
            Y > PoloPositionY -> io:format("Marco moves to4 (~p, ~p)~n", [X, Y-1]), Pid ! {self(), X, Y-1}, polo(PoloPositionX, PoloPositionY);
            true -> io:format("Marco found me! I was hiding at position (~p, ~p)", [PoloPositionX, PoloPositionY])
        end
    end.

test03() ->
	Xm = rand:uniform(20),
	Ym = rand:uniform(20),			
	io:format("Marco starts at position (~p, ~p)~n", [Xm, Ym]),	
	io:format("Polo is hidden (we do not know where he is)...~n"),
	PoloPid = spawn(hw15, polo, [rand:uniform(20), rand:uniform(20)]), %create polo process
	spawn(hw15, marco, [PoloPid, Xm, Ym]), %create marco process
	ok.

% === bank ===

auxBank(_,_,[],_) -> [];
auxBank(Id, deposit, [{TupleId,TupleAmount} | Rest], Amount) -> if  %separete first tuple from rest of the list of tuples
        (Id == TupleId) and (Amount >= 20) -> [{TupleId, TupleAmount + Amount} | Rest]; %keepthe order but add the amount and call recursively the funtion with the rest of the tuples
        true -> [{TupleId, TupleAmount} | auxBank(Id, deposit, Rest, Amount)] %keep the order but call recursively the function with the rest of the list of tuples
    end;
auxBank(Id, withdraw, [{TupleId,TupleAmount} | Rest], Amount) -> if %same as deposit but substracting
    (Id == TupleId) and (Amount >= 20) -> [{TupleId, TupleAmount - Amount} | Rest];
    true -> [{TupleId, TupleAmount} | auxBank(Id, deposit, Rest, Amount)]
end.

bank(List) ->
    receive
        {open, Id, Amount} -> bank(List ++ [{Id, Amount}]); %insert into list of accounts, io:format("INSERTAR ~n") 
        {deposit, Id, Amount} -> bank(auxBank(Id, deposit, List ,Amount)); %io:format("DEPOSITAR ~n")
        {withdraw, Id, Amount} -> bank(auxBank(Id, withdraw, List ,Amount)); %io:format("RETIRAR ~n")
        print -> io:format("~p~n", [List]), bank(List)
    end.

test04() -> 
	Bank = spawn(hw15, bank, [[]]),
	Bank ! {open, 100, 3000},			% Creates an account with Id = 100 and $3000.
	Bank ! {open, 200, 5000},			% Creates an account with Id = 200 and $5000.
	Bank ! {open, 300, 12000},			% Creates an account with Id = 300 and $12000.
	Bank ! print,						% Prints the balance of all the accounts on screen.
	Bank ! {deposit, 300, 5000},		% Adds $5000 to account with Id = 300.
	Bank ! {deposit, 100, 15},			% Nothing happens since the minimum amount to deposit is $20.
	Bank ! {withdraw, 200, 1500},		% Withdraws $1500 from the account with Id = 200.
	Bank ! {withdraw, 300, 0.50},		% Nothing happens since the minimum amount to withdraw is $1.
	Bank ! print,						% Prints the current balance of all the accounts: [{100,3000},{200,6500},{300,17000}]
	ok.