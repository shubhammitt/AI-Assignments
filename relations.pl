% Facts


male("Shubham").
male("Yogesh").
male("Suresh").
male("Pankaj").
male("Dev").
male("Tekchand").
male("Ashok").
male("Deepu").


female("Seema").
female("Radha").
female("Mansi").
female("Suman").
female("Gyanwati").
female("Mamta").
female("Anchal").
female("Sarla").
female("Meenu").
female("Muniya").

parent("Yogesh", "Mansi").
parent("Yogesh", "Radha").
parent("Yogesh", "Shubham").
parent("Seema", "Mansi").
parent("Seema", "Radha").
parent("Seema", "Shubham").
parent("Suresh", "Yogesh").
parent("Suman", "Yogesh").
parent("Gyanwati", "Seema").
parent("Mamta", "Anchal").
parent("Mamta", "Dev").
parent("Pankaj", "Dev").
parent("Pankaj", "Anchal").
parent("Gyanwati", "Mamta").
parent("Tekchand", "Seema").
parent("Tekchand", "Mamta").
parent("Ashok", "Meenu").
parent("Ashok", "Deepu").
parent("Ashok", "Muniya").
parent("Sarla", "Meenu").
parent("Sarla", "Deepu").
parent("Sarla", "Muniya").
parent("Gyanwati", "Ashok").
parent("Tekchand", "Ashok").



child("Mansi", "Yogesh").
child("Radha", "Yogesh").
child("Shubham", "Yogesh").
child("Mansi", "Seema").
child("Radha", "Seema").
child("Shubham", "Seema").
child("Yogesh", "Suresh").
child("Yogesh", "Suman").
child("Seema", "Gyanwati").
child("Mamta", "Gyanwati").
child("Anchal", "Mamta").
child("Dev", "Mamta").
child("Anchal", "Pankaj").
child("Dev", "Pankaj").
child("Mamta", "Tekchand").
child("Seema", "Tekchand").
child("Meenu", "Sarla").
child("Muniya", "Sarla").
child("Deepu", "Sarla").
child("Meenu", "Ashok").
child("Muniya", "Ashok").
child("Deepu", "Ashok").
child("Ashok", "Gyanwati").
child("Ashok", "Tekchand").

spouse("Yogesh", "Seema").
spouse("Suresh", "Suman").
spouse("Pankaj", "Mamta").
spouse("Gyanwati", "Tekchand").
spouse("Ashok", "Sarla").

is_spouse(X, Y) :- spouse(X, Y).
is_spouse(X, Y) :- spouse(Y, X),!.




% rules for father
is_father(Father, Child) :- 							male(Father), 
						 								parent(Father, Child).

% rules for mother
is_mother(Mother, Child) :- 							female(Mother),
						 								parent(Mother, Child).

% rules for son
is_son(Son, Parent) :- 									male(Son),
														parent(Parent, Son).

% rules for daughter
is_daughter(Daughter, Parent) :- 						female(Daughter),
						 	  							parent(Parent, Daughter).

% rules for husband
is_husband(Husband, Wife) :- 							male(Husband),
									  					female(Wife),
								      					is_spouse(Wife, Husband).

% rules for wife
is_wife(Wife, Husband) :- 								female(Wife),
								   						male(Husband),
								  	 					is_spouse(Wife, Husband).

% rules for sibling :- 
is_sibling(Sibling1, Sibling2) :- 						is_mother(Mother, Sibling1),
										   				is_mother(Mother, Sibling2),
										 			  	is_father(Father, Sibling1),
										   				is_father(Father, Sibling2),
										   				Sibling1 \= Sibling2.


% rules for brother :- 
is_brother(Brother, Sibling) :- 						male(Brother),
										    			is_sibling(Brother, Sibling),
										    			Sibling \= Brother.


% rules for sister :- 
is_sister(Sister, Sibling) :-   						female(Sister),
										 				is_sibling(Sister, Sibling),
										 				Sibling \= Sister.


% rules for grandfather : assumed fathers father

is_grandfather(G_father, G_Child) :- 					male(G_father),
											  	 		child(G_Child, Parent),
											  	 		male(Parent),
											  	 		child(Parent, G_father).

% rules for grandmother: assumed fathers mother
is_grandmother(G_mother, G_Child) :- 					female(G_mother),
											  	 		child(G_Child, Parent),
											  	 		male(Parent),
											  	 		child(Parent, G_mother).

% rules for grandpa : assumed mothers father
is_grandpa(G_father, G_Child) :-     					male(G_father),
											  	 		child(G_Child, Parent),
											  	 		female(Parent),
											  	 		child(Parent, G_father).

% rules for grandma: assumed mothers mother
is_grandma(G_mother, G_Child) :-     					female(G_mother),
								  	 					child(G_Child, Parent),
								  	 					female(Parent),
								  	 					child(Parent, G_mother).







% rules for daughter-in-law
is_daughter_in_law(Daughter_in_law, Parent) :- 			female(Daughter_in_law),
														is_husband(Husband, Daughter_in_law),
														child(Husband, Parent).

% rules for son-in-law
is_son_in_law(Son_in_law, Parent) :- 					male(Son_in_law),
														is_wife(Wife, Son_in_law),
														child(Wife, Parent).

% rules for father-in-law
is_father_in_law(Father_in_law, Child_in_law) :- 		male(Father_in_law),
										  				is_spouse(Child_in_law,Spouse),
										  				is_father(Father_in_law, Spouse).

% rules for mother-in-law
is_mother_in_law(Mother_in_law, Child_in_law) :- 		female(Mother_in_law),
										  				is_spouse(Child_in_law,Spouse),
										  				is_mother(Mother_in_law, Spouse).




% rules for uncle
is_uncle(Uncle, Child) :- 								male(Uncle),
						  								parent(Parent, Child),
						  								is_brother(Uncle, Parent).

% rules for aunt
is_aunt(Aunt, Child) :- 								female(Aunt),
						  								parent(Parent, Child),
						  								is_sister(Aunt, Parent).

% rules for cousin
is_cousin(Cousin, Child) :- 							is_uncle(Uncle, Child),
														child(Cousin, Uncle).


is_cousin(Cousin, Child) :- 							is_aunt(Aunt, Child),
														child(Cousin, Aunt).

% rules for nephew
is_nephew(Nephew, Uncle) :- 							male(Nephew),
														is_sibling(Uncle, Sibling),
														child(Nephew, Sibling).

% rules for neice
is_neice(Neice, Uncle) :-  								female(Neice),
														is_sibling(Uncle, Sibling),
														child(Neice, Sibling).

% rules for granduncle
is_granduncle(G_uncle, Child) :- 						is_grandfather(G_father, Child),
								 						is_brother(G_uncle, G_father).

% rules for grandaunt
is_grandaunt(G_aunt, Child) :-   						is_grandfather(G_father, Child),
								 						is_sister(G_aunt, G_father).






print_Father(X, Y) :- forall(is_father(X, Y), (write(X), write(" is father of "), writeln(Y))),nl,nl.

:- print_Father(_, _).

print_Mother(X, Y) :- forall(is_mother(X, Y), (write(X), write(" is mother of "), writeln(Y))),nl,nl.

:- print_Mother(_, _).

print_Son(X, Y) :- forall(is_son(X, Y), (write(X), write(" is son of "), writeln(Y))),nl,nl.

:- print_Son(_, _).


print_Daughter(X, Y) :- forall(is_daughter(X, Y), (write(X), write(" is daughter of "), writeln(Y))),nl,nl.

:- print_Daughter(_, _).


print_Husband(X, Y) :- forall(is_husband(X, Y), (write(X), write(" is husband of "), writeln(Y))),nl,nl.

:- print_Husband(_, _).


print_Wife(X, Y) :- forall(is_wife(X, Y), (write(X), write(" is wife of "), writeln(Y))),nl,nl.

:- print_Wife(_, _).



print_Sibling(X, Y) :- forall(is_sibling(X, Y), (write(X), write(" is sibling of "), writeln(Y))),nl,nl.

:- print_Sibling(_, _).

print_Brother(X, Y) :- forall(is_brother(X, Y), (write(X), write(" is brother of "), writeln(Y))),nl,nl.

:- print_Brother(_, _).


print_Sister(X, Y) :- forall(is_sister(X, Y), (write(X), write(" is sister of "), writeln(Y))),nl,nl.

:- print_Sister(_, _).


print_Grandfather(X, Y) :- forall(is_grandfather(X, Y), (write(X), write(" is grandfather of "), writeln(Y))),nl,nl.

:- print_Grandfather(_, _).


print_Grandmother(X, Y) :- forall(is_grandmother(X, Y), (write(X), write(" is grandmother of "), writeln(Y))),nl,nl.

:- print_Grandmother(_, _).


print_Grandpa(X, Y) :- forall(is_grandpa(X, Y), (write(X), write(" is grandpa of "), writeln(Y))),nl,nl.

:- print_Grandpa(_, _).


print_Grandma(X, Y) :- forall(is_grandma(X, Y), (write(X), write(" is grandma of "), writeln(Y))),nl,nl.

:- print_Grandma(_, _).





print_Daughter_in_law(X, Y) :- forall(is_daughter_in_law(X, Y), (write(X), write(" is daughter-in-law of "), writeln(Y))),nl,nl.

:- print_Daughter_in_law(_, _).


print_Son_in_law(X, Y) :- forall(is_son_in_law(X, Y), (write(X), write(" is son-in-law of "), writeln(Y))),nl,nl.

:- print_Son_in_law(_, _).


print_Father_in_law(X, Y) :- forall(is_father_in_law(X, Y), (write(X), write(" is father-in-law of "), writeln(Y))),nl,nl.

:- print_Father_in_law(_, _).


print_Mother_in_law(X, Y) :- forall(is_mother_in_law(X, Y), (write(X), write(" is mother-in-law of "), writeln(Y))),nl,nl.

:- print_Mother_in_law(_, _).






print_Uncle(X, Y) :- forall(is_uncle(X, Y), (write(X), write(" is uncle of "), writeln(Y))),nl,nl.

:- print_Uncle(_, _).


print_Aunt(X, Y) :- forall(is_aunt(X, Y), (write(X), write(" is aunt of "), writeln(Y))),nl,nl.

:- print_Aunt(_, _).


print_Cousin(X, Y) :- forall(is_cousin(X, Y), (write(X), write(" is cousin of "), writeln(Y))),nl,nl.

:- print_Cousin(_, _).


print_Nephew(X, Y) :- forall(is_nephew(X, Y), (write(X), write(" is nephew of "), writeln(Y))),nl,nl.

:- print_Nephew(_, _).


print_Neice(X, Y) :- forall(is_neice(X, Y), (write(X), write(" is neice of "), writeln(Y))),nl,nl.

:- print_Neice(_, _).


print_G_Uncle(X, Y) :- forall(is_granduncle(X, Y), (write(X), write(" is granduncle of "), writeln(Y))),nl,nl.

:- print_G_Uncle(_, _).


print_G_Aunt(X, Y) :- forall(is_grandaunt(X, Y), (write(X), write(" is grandaunt of "), writeln(Y))),nl,nl.

:- print_G_Aunt(_, _).