% Solve the water jug problem
solve_jug_problem(Solution) :-
    % Take input for jug capacities
    write('Enter the capacity of jug1: '),
    read(Cap1),
    write('Enter the capacity of jug2: '),
    read(Cap2),
    % Take input for the goal amount
    write('Enter the goal amount: '),
    read(Goal),
    % Initialize DFS with start state, goal, and capacities
    dfs([(0, 0)], Goal, Cap1, Cap2, [], Solution).

% Depth-first search utility predicate
dfs([(Jug1, Jug2)|_], Goal, _, _, Path, Solution) :-
    % Check if the goal state is reached
    (Jug1 =:= Goal ; Jug2 =:= Goal),
    reverse([(Jug1, Jug2)|Path], Solution). % Reverse the solution path
dfs([(Jug1, Jug2)|Rest], Goal, Cap1, Cap2, Visited, Solution) :-
    % Generate possible next states
    next_state((Jug1, Jug2), Cap1, Cap2, Visited, NewStates),
    % Append new states to the rest of the search queue
    append(NewStates, Rest, UpdatedQueue),
    % Continue DFS with updated queue and visited list
    dfs(UpdatedQueue, Goal, Cap1, Cap2, [(Jug1, Jug2)|Visited], Solution).

% Generate next possible states
next_state((Jug1, Jug2), Cap1, Cap2, Visited, NewStates) :-
    findall((NewJug1, NewJug2),
            (action((Jug1, Jug2), (NewJug1, NewJug2), Cap1, Cap2),
            \+ member((NewJug1, NewJug2), Visited)),
            NewStates).

% Define possible actions
action((Jug1, Jug2), (Cap1, Jug2), Cap1, _) :- Jug1 < Cap1. % Fill Jug1
action((Jug1, Jug2), (Jug1, Cap2), _, Cap2) :- Jug2 < Cap2. % Fill Jug2
action((Jug1, Jug2), (0, Jug2), _, _) :- Jug1 > 0.          % Empty Jug1
action((Jug1, Jug2), (Jug1, 0), _, _) :- Jug2 > 0.          % Empty Jug2
action((Jug1, Jug2), (NewJug1, NewJug2), Cap1, Cap2) :-     % Pour Jug1 -> Jug2
    Jug1 > 0, Jug2 < Cap2,
    Pour is min(Jug1, Cap2 - Jug2),
    NewJug1 is Jug1 - Pour,
    NewJug2 is Jug2 + Pour.
action((Jug1, Jug2), (NewJug1, NewJug2), Cap1, Cap2) :-     % Pour Jug2 -> Jug1
    Jug2 > 0, Jug1 < Cap1,
    Pour is min(Jug2, Cap1 - Jug1),
    NewJug1 is Jug1 + Pour,
    NewJug2 is Jug2 - Pour.