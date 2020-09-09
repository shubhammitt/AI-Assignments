% Facts

male(shubham).
male(yogesh).
male(suresh).
male(pankaj).
male(dev).
male(tekchand).
male(ashok).
male(deepu).


female(seema).
female(radha).
female(mansi).
female(suman).
female(gyanwati).
female(mamta).
female(anchal).
female(sarla).
female(meenu).
female(muniya).

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
parent(tekchand, seema).
parent(tekchand, mamta).
parent(ashok, meenu).
parent(ashok, deepu).
parent(ashok, muniya).
parent(sarla, meenu).
parent(sarla, deepu).
parent(sarla, muniya).
parent(gyanwati, ashok).
parent(tekchand, ashok).



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
child(mamta, tekchand).
child(seema, tekchand).
child(meenu, sarla).
child(muniya, sarla).
child(deepu, sarla).
child(meenu, ashok).
child(muniya, ashok).
child(deepu, ashok).
child(ashok, gyanwati).
child(ashok, tekchand).

spouse(yogesh, seema).
spouse(suresh, suman).
spouse(pankaj, mamta).
spouse(gyanwati, tekchand).
spouse(ashok, sarla).

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
										  is_spouse(Child_in_law,Spouse),
										  is_father(Father_in_law, Spouse).

% rules for mother-in-law
is_mother_in_law(Mother_in_law, Child_in_law) :- female(Mother_in_law),
										  is_spouse(Child_in_law,Spouse),
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
