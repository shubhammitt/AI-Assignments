% Facts

male(shubham).
male(yogesh).
male(suresh).
male(pankaj).

female(seema).
female(radha).
female(mansi).
female(suman).
female(gyanwati).
female(mamta).

parent(yogesh, mansi).
parent(yogesh, radha).
parent(yogesh, shubham).
parent(seema, mansi).
parent(seema, radha).
parent(seema, shubham).
parent(suresh, yogesh).
parent(suman, yogesh).
parent(gyanwati, seema).
parent(mamta, anchal).
parent(mamta, dev).
parent(pankaj, dev).
parent(pankaj, anchal).
parent(gyanwati, mamta).

child(mansi, yogesh).
child(radha, yogesh).
child(shubham, yogesh).
child(mansi, seema).
child(radha, seema).
child(shubham, seema).
child(yogesh, suresh).
child(yogesh, suman).
child(seema, gyanwati).
child(mamta, gyanwati).
child(anchal, mamta).
child(dev, mamta).
child(anchal, pankaj).
child(dev, pankaj).

spouse(yogesh, seema).
spouse(suresh, suman).
spouse(pankaj, mamta).

is_spouse(X, Y) :- spouse(X, Y).
is_spouse(X, Y) :- spouse(Y, X),!.




% rules for father
is_father(Father, Child) :- male(Father), 
						 parent(Father, Child).

% rules for mother
is_mother(Mother, Child) :- female(Mother),
						 parent(Mother, Child).

% rules for son
is_son(Son, Parent) :- male(Son),
					parent(Parent, Son).

% rules for daughter
is_daughter(Daughter, Parent) :- female(Daughter),
						 	  parent(Parent, Daughter).

% rules for husband
is_husband(Husband, Wife) :- male(Husband),
						  female(Wife),
					      is_spouse(Wife, Husband).

% rules for wife
is_wife(Wife, Husband) :- female(Wife),
					   male(Husband),
					   is_spouse(Wife, Husband).


% rules for sibling :- 
is_sibling(Sibling1, Sibling2) :- is_mother(Mother, Sibling1),
							   is_mother(Mother, Sibling2),
							   is_father(Father, Sibling1),
							   is_father(Father, Sibling2),
							   Sibling1 \= Sibling2.

% rules for brother :- 
is_brother(Brother, Sibling) :- male(Brother),
							    is_sibling(Brother, Sibling),
							    Sibling \= Brother.


% rules for sister :- 
is_sister(Sister, Sibling) :-   female(Sister),
							 	is_sibling(Sister, Sibling),
							 	Sibling \= Sister.


% rules for grandfather : assumed fathers father
is_grandfather(G_father, G_Child) :- male(G_father),
								  	 child(G_Child, Parent),
								  	 male(Parent),
								  	 child(Parent, G_father).

% rules for grandmother: assumed fathers mother
is_grandmother(G_mother, G_Child) :- female(G_mother),
								  	 child(G_Child, Parent),
								  	 male(Parent),
								  	 child(Parent, G_mother).

% rules for grandpa : assumed mothers father
is_grandpa(G_father, G_Child) :-     male(G_father),
								  	 child(G_Child, Parent),
								  	 female(Parent),
								  	 child(Parent, G_father).

% rules for grandma: assumed mothers mother
is_grandma(G_mother, G_Child) :-     female(G_mother),
								  	 child(G_Child, Parent),
								  	 female(Parent),
								  	 child(Parent, G_mother).







% rules for daughter-in-law
is_daughter_in_law(Daughter_in_law, Parent) :- female(Daughter_in_law),
												is_husband(Husband, Daughter_in_law),
												child(Husband, Parent).

% rules for son-in-law
is_son_in_law(Son_in_law, Parent) :- male(Son_in_law),
												is_wife(Wife, Son_in_law),
												child(Wife, Parent).

% rules for father-in-law
is_father_in_law(Father_in_law, Child_in_law) :- male(Father_in_law),
										  is_spouse(Spouse, Child_in_law),
										  is_father(Father_in_law, Spouse).

% rules for mother-in-law
is_mother_in_law(Mother_in_law, Child_in_law) :- female(Mother_in_law),
										  is_spouse(Spouse, Child_in_law),
										  is_mother(Mother_in_law, Spouse).







% rules for uncle
is_uncle(Uncle, Child) :- male(Uncle),
						  parent(Parent, Child),
						  is_brother(Uncle, Parent).

% rules for aunt
is_aunt(Aunt, Child) :- female(Aunt),
						  parent(Parent, Child),
						  is_sister(Aunt, Parent).

% rules for cousin
is_cousin(Cousin, Child) :- is_uncle(Uncle, Child),
							child(Cousin, Uncle).

is_cousin(Cousin, Child) :- is_aunt(Aunt, Child),
							child(Cousin, Aunt).

% rules for nephew
is_nephew(Nephew, Uncle) :- male(Nephew),
							is_sibling(Uncle, Sibling),
							child(Nephew, Sibling).

% rules for neice
is_neice(Neice, Uncle) :-  female(Neice),
							is_sibling(Uncle, Sibling),
							child(Neice, Sibling).

% rules for granduncle
is_granduncle(G_uncle, Child) :- parent(Parent, Child),
								 is_uncle(G_uncle, Parent).

% rules for grandaunt
is_grandaunt(G_aunt, Child) :-   parent(Parent, Child),
								 is_aunt(G_aunt, Parent).


print_Father(X, Y) :- forall(is_father(X, Y), (write(X), write(" is father of "), writeln(Y))),nl,nl.

:- print_Father(_, _).

print_Mother(X, Y) :- forall(is_mother(X, Y), (write(X), write(" is mother of "), writeln(Y))),nl,nl.

:- print_Mother(_, _).






% 
% :- son(X,Y), write(X), write(" is son of "),write(Y).