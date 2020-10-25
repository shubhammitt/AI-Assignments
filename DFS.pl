:- consult("edges.pl").

pushFront(Item, List, [Item | List]) .
getFirstElement([H| _], H).


dfs(Source, Destination, Open, Closed) :-
	(
		(
			Open = [], 
			writeln("No path found!"),
			!
		);
		(
			getFirstElement(Open, S),
			select(S, Open, NewOpen),
			append([S], Closed, NewClosed),
			findall(Successor, edges(S, Successor, _), ListOfSuccessors),
			subtract(ListOfSuccessors, NewClosed, ListOfUnvisitedSuccessors),
			(
				(
					member(Destination, ListOfUnvisitedSuccessors),
					writeln("Path Found"),
					!
				);
				(
					reverse(ListOfUnvisitedSuccessors, X),
					append(X, NewOpen, NewOpen1),
					writeln(NewOpen1),

					dfs(Source, Destination, NewOpen1, NewClosed)
				)

			)


		)
	).



:- dfs("Agartala", "Calicut",  ["Agartala"], []).
:- retractall(edges(_,_,_)).