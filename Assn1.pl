career_advisory :- 
	reset_facts_learned,
	dash,
	writeln("Welcome to Career Advisory System for IIIT-D B.Tech students!"),
	writeln("This system helps you to choose most optimal career."),
	writeln("Please give valid and accurate answers for the system to be most effective."),
	dash,
	career(_).


% so that current execution will not conflict with previous execution of the code.
reset_facts_learned :-
	retractall(answered(_, _)).

dash :-
	writeln("------------------------------------------------------------------------------------------------------------------------------------------------------------------------").



option(research) :- 
	writeln("A Reseacher").

option(job) :- 
	writeln("A Job").

option(others) :- 
	writeln("You want Non-tech").

option(yes) :-
	writeln("Yes").

option(no) :- 
	writeln("No").

option(cse) :-
	writeln("CSE").

option(csam) :-
	writeln("CSAM").

option(csss) :-
	writeln("CSSS").

option(csd) :-
	writeln("CSD").

option(csai) :-
	writeln("CSAI").

option(ece) :-
	writeln("ECE").





query(cgpa) :- 
	writeln("Please enter you CGPA").

query(career_interest) :-
	writeln("In what type of career you are interested in?").

query(btp_done) :- 
	writeln("Have you done some kind of BTP during the B.Tech or has some kind of research work?").

query(branch) :-
	writeln("What is your branch?").

query(enterpreneur) :- 
	writeln("Have you done Minor in Entrepreneurship?").
	
query(aptitude) :- 
	writeln("Do you have good aptitude skills?").
	
query(social_sciences) :- 
	writeln("Do you like social sciences?").

query(gk) :-
	writeln("Are you good in General knowledge and current affairs?").

query(Course, _ , Answer) :- 
	answered(Course, Answer), !.
query(Course, Name, Answer) :-
	\+ answered(Course, _),
	write("Have you done the course "),
	write(Name),writeln("?"),
	generate_options([yes, no], 1),
	read(Index),
	find_option(Index, [yes, no], Selection),
	asserta(answered(Course, Selection)),
	Selection = Answer.






print_career(software_engineer) :- 
	dash,
	writeln("You have pretty good coding skills with interest in dev. and codes, so you may opt for Software Engineering "),
	dash.

print_career(data_scientist) :- 
	dash,
	writeln("You have a decent CGPA with interest in coding, Data Mining and likes to visualize , so you may go for Data Scientist."),
	dash.

print_career(research) :-
	dash,
	writeln("You have a awesome CGPA and also have good experience in research.\nSo, you may go for Research/Higher Studies."),
	dash.

print_career(cryptographer) :- 
	dash,
	writeln("You like to play with numbers and have already some taste of decoding codes, so you may opt for Cryptographer."),
	dash.

print_career(statistician) :- 
	dash,
	writeln("You like to play with numbers and have shown some interest in data analytics, so you may opt for Statistician."),
	dash.

print_career(ml_ai) :-
	dash,
	writeln("You have very good experience in AI and ML and decent coding skills, so you may opt for ML/AI engineer."),
	dash.

print_career(robotic_engineer) :-
	dash,
	writeln("You have decent coding skills and have some hands on experience in robos and ml, so you may opt for Robotics"),
	dash.

print_career(hardware_design) :-
	dash,
	writeln("You have good knowledge in signals and hardware and have played with it, so you may go for Hardware Design/Engineer"),
	dash.

print_career(philosopher) :- 
	dash,
	writeln("You have good knowledge about philosophy and done relevant courses, so you may go for Philosopher"),
	dash.

print_career(economist) :-
	dash,
	writeln("You have pretty good knowledge about economics and done relevant courses and have decent grades ,so you may opt for Economist"),
	dash.

print_career(economics) :- 
	dash,
	writeln("You have great interest in visuals and photography and done relevant courses, so you may opt for Photographer"),
	dash.

print_career(enterpreneurship) :- 
	dash,
	writeln("You have done Minor in Entrepreneur which shows your interest in Entrepreneurship, so enjoy this new career and achieve great heights."),
	dash.

print_career(civil_services) :-
	dash,
	writeln("You have good aptitude skills and great interest in social sciences and are upto date with current world, so you may go for Civil services"),
	dash.



% Career options are :- Research, Job, Non-tech like civil_services, enterpreneurship.
career(research) :-
	cgpa(CGPA),
	CGPA > 9,
	career_interest(research),
	ask(btp_done, Answer, [yes, no]),
	(
		( 
			Answer = no, 
			writeln("Research career is not suitable for you.\nBut since you have good CGPA, so we would be exploring job career too."),
			retract(answered(career_interest, research)),
			asserta(answered(career_interest, job)),
			career(job)
		);
		(
			Answer = yes, 
			print_career(research)
		)
	).



career(job) :- 
	cgpa(CGPA),
	(
		(
		CGPA > 6,
		career_interest(job),
		branch(_),
		field(_)
		);
		(
			retractall(answered(career_interest, job)),
			asserta(answered(career_interest, others)),
			career(others)
		)
	).


career(others) :-
	career_interest(others),
	(
		(
			enterpreneur(yes),  
			print_career(enterpreneurship)
		);
		(
			cgpa(CGPA), 
			CGPA >= 8, aptitude(yes), 
			social_sciences(yes), 
			gk(yes), 
			print_career(civil_services)
		);
		(
			writeln("Sorry, unable to find suitable career for you.")
		)
	).



% field means career relevant to your branch. If no suitable career is found by current branch then we explore other carrer options like enterpreneurship, civil_services.
field(cse) :-
	branch(cse),
	(
		(
			query(dmg, "Data Mining", yes),
			query(dbms, "DBMS", yes),
			query(dsa, "Data Structures and Algorithms", yes),
			print_career(data_scientist)
		);
		(
			query(ada, "Analysis and Design of Algorithms", yes),
			query(ap, "Advanced Programming", yes),
			query(se, "Software Engineering", yes),
			print_career(software_engineer)
		);
		(
			retractall(answered(career_interest, job)),
			asserta(answered(career_interest, others)),
			career(others)
		)
	).

field(csam) :- 
	branch(csam),
	(
		(
			query(nt, "Number Theory", yes),
			query(ac, "Applied Cryptography", yes),
			print_career(cryptographer)
		);
		(
			query(spa, "Stochastic Processes and Applications", yes),
			query(da, "Data Analystics", yes),
			query(ps, "Probablity and Statistics", yes),
			print_career(statistician)
		);
		(
			query(dmg, "Data Mining", yes),
			query(dbms, "DBMS", yes),
			query(dsa, "Data Structures and Algorithms", yes),
			print_career(data_scientist)
		);
		(
			retractall(answered(career_interest, job)),
			asserta(answered(career_interest, others)),
			career(others)
		)
	).

field(csai) :- 
	branch(csai),
	(
		(
			query(ml, "Machine Learning", yes),
			query(ai, "Artificial Intelligence", yes),
			query(ip, "Introduction to Programming", yes),
			print_career(ml_ai)
		);
		(
			query(ada, "Analysis and Design of Algorithms", yes),
			query(ap, "Advanced Programming", yes),
			query(se, "Software Engineering", yes),
			print_career(software_engineer)
		);
		(
			retractall(answered(career_interest, job)),
			asserta(answered(career_interest, others)),
			career(others)
		)
	).

field(ece) :-
	branch(ece),
	(
		(
			query(cnt, "Nonlinear and Adaptive Control of Robotic Systems", yes),
			query(ip, "Introduction to Programming", yes),
			query(ml, "Machine Learning", yes),
			print_career(robotic_engineer)
		);
		(
			query(ss, "Signals & Systems", yes),
			query(dc, "Digital Circuits", yes),
			query(eld, "Embedded Logic Design", yes),
			print_career(hardware_design)
		);
		(
			retractall(answered(career_interest, job)),
			asserta(answered(career_interest, others)),
			career(others)
		)

	).

field(csss) :-
	branch(csss),
	(
		(
			query(pt, "Philosophy of Technology", yes),
			query(i_p, "Introduction to Philosophy", yes),
			print_career(philosopher)
		);
		(
			query(gmt, "Game Theory", yes),
			query(em, "Econometrics", yes),
			query(me,"Macroeconomics", yes),
			print_career(economist)
		);
		(
			retractall(answered(career_interest, job)),
			asserta(answered(career_interest, others)),
			career(others)
		)
	).

field(csd) :- 
	branch(csd),
	(
		(
			query(ag, "Animation & Graphics", yes),
			query(py, "Photography", yes),
			query(vn,"Visualization", yes),
			print_career(photographer)
		);
		(
			query(gmt, "Game Theory", yes),
			query(em, "Econometrics", yes),
			query(me,"Macroeconomics", yes),
			print_career(economist)
		);
		(
			retractall(answered(career_interest, job)),
			asserta(answered(career_interest, others)),
			career(others)
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
	Nextindex is Index - 1,
	find_option(Nextindex, Tail, Result).


generate_options([],_).
generate_options([Head|Tail], Index) :-
	write(Index), write(' '),
	option(Head),
	Nextindex is Index + 1,
	generate_options(Tail, Nextindex).




enterpreneur(Answer) :- 
	answered(enterpreneur, Answer), !.
enterpreneur(Answer) :- 
	\+ answered(enterpreneur, _),
	ask(enterpreneur, ANSWER, [yes, no]),
	Answer = ANSWER.



aptitude(Answer) :- 
	answered(aptitude, Answer), !.
aptitude(Answer) :- 
	\+ answered(aptitude, _),
	ask(aptitude, ANSWER, [yes, no]),
	Answer = ANSWER.



social_sciences(Answer) :- 
	answered(social_sciences, Answer), !.
social_sciences(Answer) :- 
	\+ answered(social_sciences, _),
	ask(social_sciences, ANSWER, [yes, no]),
	Answer = ANSWER.



gk(Answer) :- 
	answered(gk, Answer), !.
gk(Answer) :- 
	\+ answered(gk, _),
	ask(gk, ANSWER, [yes, no]),
	Answer = ANSWER.



branch(Branch) :- 
	answered(branch, Branch), !.
branch(Branch) :- 
	\+ answered(branch, _ ),
	ask(branch, BRANCH, [cse, csam, csss, csd, csai, ece]), Branch = BRANCH.



career_interest(CI) :- 
	answered(career_interest, CI), !.
career_interest(CI) :- 
	\+ answered(career_interest, _),
	(
		(
			cgpa(CGPA), CGPA > 9 , ask(career_interest, Ci, [research, job, others]), CI = Ci
		);
		(
			% CGPA is not suitable for Research career so taking job as interest
			CI = job,
			asserta(answered(career_interest, job))
		)
	).




cgpa(CGPA) :- 
	answered(cgpa, CGPA ), !.
cgpa(CGPA) :- 
	\+ answered(cgpa, _),
	query(cgpa),
	read(Cgpa),
	(
		(
			(Cgpa > 10 ; Cgpa < 0), writeln("Invalid CGPA!\nTry again!"), cgpa(CGPA)
		);
		(
			CGPA is Cgpa,
			asserta(answered(cgpa, CGPA))
		)
	).


/*
Shubham Mittal
2018101
Assignment-1  
References
https://iiitd.ac.in/sites/default/files/docs/education/2020/2020-June-B.Tech(CSSS)-Regulations.pdf
https://iiitd.ac.in/sites/default/files/docs/education/2019/2019-August-B.Tech(CSD)-Regulations.pdf
https://www.collegedekho.com/careers/sociologist
https://github.com/shivamgupta1/Career-Counsellor-expert-system
https://www.collegedekho.com/careers/sociologist
*/