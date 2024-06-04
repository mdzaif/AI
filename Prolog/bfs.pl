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

% BFS predicate
bfs(Start, Goal, Path) :-
    bfs_helper([[Start]], Goal, Path).

% Helper predicate for BFS
bfs_helper([[Goal|Rest]|_], Goal, Path) :-
    reverse([Goal|Rest], Path).
bfs_helper([[Current|Rest]|Queues], Goal, Path) :-
    findall([Next,Current|Rest],
            (edge(Current, Next), \+ member(Next, [Current|Rest])),
            NextQueues),
    append(Queues, NextQueues, NewQueues),
    bfs_helper(NewQueues, Goal, Path).
