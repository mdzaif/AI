import heapq

# Heuristic: Manhattan Distance
def manhattan(puzzle, goal):
    distance = 0
    for i in range(1, 9):
        x1, y1 = divmod(puzzle.index(i), 3)
        x2, y2 = divmod(goal.index(i), 3)
        distance += abs(x1 - x2) + abs(y1 - y2)
    return distance

# A* Search Algorithm
def astar(start, goal):
    open_list = []
    closed_list = set()
    heapq.heappush(open_list, (0, start, 0, -1, None))
    
    while open_list:
        _, current, g, _, path = heapq.heappop(open_list)
        
        if current == goal:
            return path
        
        closed_list.add(tuple(current))
        
        zero_index = current.index(0)
        x, y = divmod(zero_index, 3)
        
        # Possible moves: up, down, left, right
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        
        for dx, dy in directions:
            new_x, new_y = x + dx, y + dy
            
            if 0 <= new_x < 3 and 0 <= new_y < 3:
                new_zero_index = new_x * 3 + new_y
                new_puzzle = current[:]
                new_puzzle[zero_index], new_puzzle[new_zero_index] = new_puzzle[new_zero_index], new_puzzle[zero_index]
                
                if tuple(new_puzzle) not in closed_list:
                    h = manhattan(new_puzzle, goal)
                    heapq.heappush(open_list, (g + h, new_puzzle, g + 1, h, (path, new_puzzle)))
                    
    return None

# Example Usage
start_state = input("Enter start node [use _ for the empty tile]: ").replace('_', '0').split()
start_state = list(map(int, start_state))

goal_state = input("Enter goal node [use _ for the empty tile]: ").replace('_', '0').split()
goal_state = list(map(int, goal_state))

result = astar(start_state, goal_state)
path = []
p = 0
if result:
    print("Path to goal:")
    while result:
        result, step = result
        path = [step] + path
        p = 1
else:
    print("No solution found.")

path = [start_state] + path

if p == 1:
    for i in path:
        p = 0
        for i2 in i:
            if p == 3:
                p = 0
                print()
                    
            if i2 == 0:
                print('_', end=" ")
                p += 1
                
            else:
                print(i2, end=" ")
                p += 1
                    
        print("\n\n")
