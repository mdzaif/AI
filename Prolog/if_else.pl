% If-Then-Else statement

gt(X,Y) :- X >= Y,write('X is greater').
gt(X,Y) :- X < Y,write('X is smaller').

% If-Elif-Else statement

gt(X,Y) :- X > Y,write('X is greater').
gt(X,Y) :- X=:=Y,write('X and Y are same').
gt(X,Y) :- X < Y,write('X is smaller').
