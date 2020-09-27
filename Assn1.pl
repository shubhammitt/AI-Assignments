career_advisory :- 
	reset_system,
	dash,
	writeln("Welcome to Career Advisory System for IIIT-D B.Tech students!"),
	writeln("This system helps you to choose most optimal career."),
	writeln("Please give valid and accurate answers for the system to be most effective."),
	dash,
	career(X).


reset_system :-
	retractall(answered(_, _)).

dash :-
	writeln("-----------------------------------------------------------------------------------------------").



option(research) :- 
	writeln("A Reseacher").

option(job) :- 
	writeln("A Job").

option(yes) :-
	writeln("Yes").

option(no) :- 
	writeln("No").



query(cgpa) :- 
	writeln("Please enter you CGPA").

query(career_interest) :-
	writeln("In what type of career you are interested in?").

query(btp_done) :- 
	writeln("Have you done some kind of BTP during the B.Tech or has some kind of research work?").





print_career(research) :-
	dash,
	writeln("You have a awesome CGPA and also have good experience in research.\nSo, you may go for Research."),
	dash.





career(job) :- 
	career_interest(CI), 
	CI = job.

career(research) :-
	career_interest(CI), 
	CI = research,
	ask(btp_done, Answer, [yes, no]),
	(
		( 
			Answer = no, writeln("Research career is not suitable for you ")
		);
		(
			Answer = yes, print_career(research)
		)
	).




career_interest(CI) :- 
	answered(career_interest, X), CI = X, !.
career_interest(CI) :- 
	\+ answered(career_interest, _),
	(
		cgpa(CGPA), CGPA >= 9 , ask(career_interest, CI, [research, job]), !
	);
	(
		% CGPA is not suitable for Research career so taking job as interest
		asserta(answered(career_interest, job))
	).




cgpa(CGPA) :- 
	answered(cgpa, X ), CGPA = X, !.
cgpa(CGPA) :- 
	query(cgpa),
	read(_CGPA),
	(
		(
			(_CGPA > 10 ; _CGPA < 0), writeln("Invalid CGPA!\nTry again!"), query(CGPA)
		);
		(
			CGPA = _CGPA,
			asserta(answered(cgpa, CGPA))
		)
	).



ask(Question, Answer, Options) :-
	query(Question),
	generate_options(Options, 1),
	read(Index),
	find_option(Index, Options, Selection),
	asserta(answered(Question, Selection)),
	Selection = Answer.


find_option(1, [Head|_] , Head).
find_option(Index, [_|Tail], Result) :-
	Nextindex is Index -1,
	find_option(Nextindex, Tail, Result).


generate_options([],_).
generate_options([Head|Tail], Index) :-
	write(Index), write(' '),
	option(Head),
	Nextindex is Index + 1,
	generate_options(Tail, Nextindex).
