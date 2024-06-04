% ///////////////////////////////////////////////////////////////////////////////////////////////////
% Task: The Water Jug Problem have one 4L Jug & one 3L Jug. Get 2L of
% Water
%

checkXY(F,S):- F>=0,F=<4,S>=0,S=<3.

%pour from 3L to 4L until 4L is full
move((X,Y), (4,NewY)) :-
	                      NewY is X + Y - 4, X + Y > 4, checkXY(4,NewY).

%pour from 4L to 3L until 4L is empty
move((X,Y), (0,NewY)) :-
	                      NewY is X + Y , X + Y =< 4, checkXY(0,NewY).

%pour from 4L to 3L until 3L is full
move((X,Y), (NewX,3)) :-
	                      NewX is X + Y - 3, X + Y > 3, checkXY(NewX,3).

%pour from 3L to 4L until 3L is empty
move((X,Y), (NewX,0)) :-
	                      NewX is X + Y , X + Y =<4, checkXY(NewX,0).



% Fill the 4L jug from tap

move((X,Y), (4,Y)):-
                          X=<4, X>=0.

% Fill the 3L jug from tap

move((X,Y), (X,3)):-
	                   Y=<3, Y>=0.

% Empty the 3L jug down the sink

move((X,Y), (X,0)) :-
			    Y >= 0.

% Empty the 4L jug down the sink

move((X,Y), (0,Y)) :-
	                    X >= 0.


% R is a list of each state after pouring the water
% solve([Before], Fill, [After]).

solve([(X1,Y1)|R], [(2,Y2), (X1,Y1)|R]):-
					        move((X1,Y1), (2,Y2)), !.

% Recursion
% Starting at 4 different initial states
% Start pouring the jugs
% True if (X2,Y2) is not a member of [(X1,Y1)|R]
% Stop when found (2,Y)

solve([(X1,Y1)|R], Path) :-
                                move((X1,Y1), (X2,Y2)),
			        not(member((X2,Y2), [(X1,Y1)|R])),
                                solve([(X2,Y2), (X1,Y1)|R], Path).


% Start the search with (4,0).

solved40(PathList) :-
	             solve([(4,0)], PathList).


% Start the search with (0,0).

solved00(PathList) :-
	             solve([(0,0)], PathList).

% Start the search with (0,3).

solved03(PathList) :-
	             solve([(0,3)], PathList).

% Start the search with (4,3).

solved43(PathList) :-
	             solve([(4,3)], PathList).



% ? - solved43(Path), print(Path).
% ? - solved40(Path), print(Path).
% ? - solved03(Path), print(Path).
% ? - solved00(Path), print(Path).




