:- retractall(edges(_,_,_)), retractall(predecessor(_,_)).
:- consult("edges.pl").


getFirstElement([H| _], H).

addAssert(_, []).
addAssert(S, [H|T]) :- 
	retractall(predecessor(_, H)),
	asserta(predecessor(S, H)),
	addAssert(S, T).

retracepath(Destination, Source, Cost) :-
	(
		(
			\+ predecessor(_, Destination), 
			write("Cost = "),
			write(Cost),
			writeln(" KMs"),
			write(Source),
			!
		);
		(
			predecessor(X, Destination),
			edges(X, Destination, C),
			NewCost is Cost + C,
			retracepath(X, Source, NewCost),
			write(" --> "),
			write(Destination)
		)
	).

dfs(Source, Source, _, _) :- writeln("You are at Destination only!").
dfs(Source, Destination, Open, Closed) :-
	Source \= Destination,
	(
		(
			Open = [], 
			writeln("No path found!"),
			!
		);
		(
			getFirstElement(Open, S),  %get first node from Open
			select(S, Open, Open1),  %remove first node from Open
			append(Closed, [S], NewClosed), %insert first node in Closed
			findall(Successor, edges(S, Successor, _), ListOfSuccessors),
			subtract(ListOfSuccessors, NewClosed, ListOfUnvisitedSuccessors),
			(
				(
					member(Destination, ListOfUnvisitedSuccessors),
					writeln("Path Found!"),
					addAssert(S, [Destination]),
					retracepath(Destination, Source, 0),
					!
				);
				(
					reverse(ListOfUnvisitedSuccessors, X),
					append(X, Open1, Open2),
					addAssert(S, X),
					dfs(Source, Destination, Open2, NewClosed)
				)
			)
		)
	).

:- dfs("Agartala", "Agra",  ["Agartala"], []).