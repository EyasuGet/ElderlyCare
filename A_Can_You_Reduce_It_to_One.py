t = int(input())
for _ in range(t):
    n, k = map(int, input().split())
    a = list(map(int, input().split()))
    
    possible = False
    for i in range(n - k + 1):
        if 1 in a[i:i+k]:
            possible = True
            break
            
    print("YES" if possible else "NO")
