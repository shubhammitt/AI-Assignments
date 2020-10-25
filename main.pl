query:- writeln("1.) for Depth First Search"),	
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
	   		consult("DFS.pl"),
	   		writeln(Source),
	   		writeln(Destination),
	   		dfs(Source, Destination, [Source], [])

   		);
	   	(
	   		Choice = 2,
			writeln("Enter Source :"),
			read(Source),
			writeln("Enter Destination :"), 
			read(Destination),
			consult("BFS.pl"),
	   		bfs(Source, Destination, [Source], [])
	   	);
	   	(
	   		Choice > 2,
	   		query
	   	)
   ).
   
:- query.