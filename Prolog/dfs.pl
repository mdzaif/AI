% Define edges of the graph
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(c, g).
edge(d, h).
edge(e, i).
edge(f, j).

% DFS predicate
dfs(Start, Goal, Path) :-
    dfs_helper(Start, Goal, [Start], Path).

% Helper predicate for DFS
dfs_helper(Goal, Goal, Path, Path).
dfs_helper(Current, Goal, Visited, Path) :-
    edge(Current, Next),
    \+ member(Next, Visited),       % Ensure Next node is not visited
    dfs_helper(Next, Goal, [Next|Visited], Path).
