:- retractall(edges(_,_,_)), retractall(predecessor(_,_)), retractall(heuristic(_, _, _)).
:- consult("edges.pl").
:- consult("heuristic.pl").

indexOf([Element|_], Element, 0):- !.
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1),
  !,
  Index is Index1+1.

getMinElement(Open, H, Destination) :- 
	findall(Heurstic_Cost, ( member(S, Open), heuristic(S ,Destination , Heurstic_Cost)), List_of_heurstic_cost_to_destination),
	min_list(List_of_heurstic_cost_to_destination, M),
	indexOf(List_of_heurstic_cost_to_destination, M, Index),
	nth0(Index, Open, H1),
	H1=H.


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

bfs(Source, Source, _, _) :- writeln("You are at Destination only!").
bfs(Source, Destination, Open, Closed) :-
	(
		(
			Open = [], 
			writeln("No path found!"),
			!
		);
		(
			getMinElement(Open, S, Destination),  %get first node from Open
			select(S, Open, NewOpen),  %remove first node from Open
			append([S], Closed, NewClosed), %insert first node in Closed
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
					append(X, NewOpen, NewOpen1),
					addAssert(S, X),
					bfs(Source, Destination, NewOpen1, NewClosed)
				)

			)
		)
	).
:- bfs("Agartala", "Gwalior",  ["Agartala"], []).