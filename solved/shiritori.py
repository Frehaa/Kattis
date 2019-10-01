import sys

n = int(sys.stdin.readline())
seen = set()

def other_player(player):
    if player == 1: return 2
    elif player == 2: return 1
player_to_win = 1
winner = 0

prev = sys.stdin.readline()
for i in range(1, n):
    seen.add(prev)
    current = sys.stdin.readline()
    
    if current in seen: 
        winner = player_to_win
        break
    elif prev[-2] != current[0]:
        winner = player_to_win
        break
    else:
        player_to_win = other_player(player_to_win)
        prev = current

if winner == 0:
    print("Fair Game")
elif winner == 1:
    print("Player 2 lost")
elif winner == 2:
    print("Player 1 lost")
