:- retractall(edges(_,_,_)), retractall(predecessor(_,_)), retractall(heuristic(_, _, _)).
:- consult("edges.pl").
:- consult("heuristic.pl").


indexOf([Element | _], Element, 0) :- !.
indexOf([_|Tail], Element, Index) :-
	indexOf(Tail, Element, Index1),
	!,
	Index is Index1 + 1.


getMinElement(Open, H, Destination) :- 
	findall(Heurstic_Cost, ( member(S, Open), heuristic(S ,Destination , Heurstic_Cost)), List_of_heurstic_cost_to_destination),
	min_list(List_of_heurstic_cost_to_destination, M),
	indexOf(List_of_heurstic_cost_to_destination, M, Index),
	nth0(Index, Open, H1),
	H1 = H.


setLink(_, []).
setLink(S, [H|T]) :- 
	asserta(predecessor(S, H)),
	setLink(S, T).


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



bfs(Source, Source, _, _) :- writeln("You are at Destination only!"), !.
bfs(Source, Destination, Open, Closed) :-
	Source \= Destination,
	(
		(
			Open = [], 
			writeln("No path found!"),
			!
		);
		(
			getMinElement(Open, S, Destination),								% get node, S from Open with minimum cost to Destination 
			select(S, Open, Open1),  											% remove first node, S from Open
			append(Closed, [S], Closed1),										% insert first node, S in Closed

			findall(Successor, edges(S, Successor, _), ListOfSuccessors), 		% generate all successors of S
			subtract(ListOfSuccessors, Closed1, ListOfUnvisitedSuccessors),		% remove all successors which are already visited
			(
				setLink(S, ListOfUnvisitedSuccessors),							% Set link from successors of S to S
				(
					member(Destination, ListOfUnvisitedSuccessors), 			% some successor of S is Destination
					writeln("Path Found!"),						
					retracepath(Destination, Source, 0),						% retrace back the path
					!
				);
				(
					reverse(ListOfUnvisitedSuccessors, ListOfUnvisitedSuccessors1),
					append(ListOfUnvisitedSuccessors1, Open1, Open2),			% append successors in front of Open
					bfs(Source, Destination, Open2, Closed1)					% repeat
				)
			)
		)
	).


dfs(Source, Source, _, _) :- writeln("You are at Destination only!"), !.
dfs(Source, Destination, Open, Closed) :-
	Source \= Destination,
	(
		(
			Open = [], 
			writeln("No path found!"),
			!
		);
		(
			nth0(0, Open, S),													% get first node, S from Open
			select(S, Open, Open1),  											% remove first node, S from Open
			append(Closed, [S], Closed1),										% insert first node, S in Closed

			findall(Successor, edges(S, Successor, _), ListOfSuccessors), 		% generate all successors of S
			subtract(ListOfSuccessors, Closed1, ListOfUnvisitedSuccessors),		% remove all successors which are already visited
			(
				setLink(S, ListOfUnvisitedSuccessors),							% Set link from successors of S to S
				(
					member(Destination, ListOfUnvisitedSuccessors), 			% some successor of S is Destination
					writeln("Path Found!"),						
					retracepath(Destination, Source, 0),						% retrace back the path
					!
				);
				(
					reverse(ListOfUnvisitedSuccessors, ListOfUnvisitedSuccessors1),
					append(ListOfUnvisitedSuccessors1, Open1, Open2),			% append successors in front of Open
					dfs(Source, Destination, Open2, Closed1)					% repeat
				)
			)
		)
	).



query :- 
	writeln("1.) for Depth First Search"),	
	writeln("2.) for Best First Search"),
	writeln("Enter Your Choice :"),
	read(Choice),
	(
		(
			Choice = 1,
			writeln("Enter Source :"),
			read(Source),
			writeln("Enter Destination :"), 
			read(Destination),
			dfs(Source, Destination, [Source], [])
		);
		(
			Choice = 2,
			writeln("Enter Source :"),
			read(Source),
			writeln("Enter Destination :"), 
			read(Destination),
			bfs(Source, Destination, [Source], [])
		);
		(
			Choice > 2,
			query
		)
	).

:- query.