two_loops([], [], _).
two_loops([H1 | T1], [H2 | T2], X0) :-
	asserta(edges(X0, H1, H2)),
	asserta(edges(H1, X0, H2)),
	two_loops(T1, T2, X0).


make_edges([]) :- !.
make_edges([H | T]) :- 
	M1 = [ahmedabad,bangalore,bhubaneshwar,bombay,calcutta,chandigarh,cochin,delhi,hyderabad,indore,jaipur,kanpur,lucknow,madras,nagpur,nasik,panjim,patna,pondicherry,pune],
	asserta(H),
	citydist(X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20),
	M2 = [X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20],
	retractall(citydist(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
	two_loops(M1, M2, X0),
	make_edges(T).

check :- 
	csv_read_file("roaddistance.csv", Rows, [functor(citydist), arity(21)]), 
	[_ | T] = Rows,
	make_edges(T).
:- check.