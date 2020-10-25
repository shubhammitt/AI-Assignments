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
			writeln(Source),
			write("Cost is "),
			write(Cost),
			writeln(" KMs"),
			!
		);
		(
			predecessor(X, Destination),
			edges(X, Destination, C),
			NewCost is Cost + C,
			write(Destination),
			write("<--"),
			retracepath(X, Source, NewCost)
		)
	).

dfs(Source, Destination, Open, Closed) :-
	(
		(
			Open = [], 
			writeln("No path found!"),
			!
		);
		(
			getFirstElement(Open, S),  %get first node from Open
			select(S, Open, NewOpen),  %remove first node from Open
			append([S], Closed, NewClosed), %insert first node in Closed
			findall(Successor, edges(S, Successor, _), ListOfSuccessors),
			subtract(ListOfSuccessors, NewClosed, ListOfUnvisitedSuccessors),
			(
				(
					member(Destination, ListOfUnvisitedSuccessors),
					writeln("Path Found"),
					addAssert(S, [Destination]),
					retracepath(Destination, Source, 0),
					!
				);
				(
					reverse(ListOfUnvisitedSuccessors, X),
					append(X, NewOpen, NewOpen1),
					addAssert(S, X),
					dfs(Source, Destination, NewOpen1, NewClosed)
				)

			)


		)
	).



:- dfs("Agartala", "Hubli",  ["Agartala"], []).