t = int(input())
for _ in range(t):
    n = int(input())
    a = list(map(int, input().split()))
    
    dec = 0
    for i in range(n - 1):
        if a[i] > a[i + 1]:
            dec += 1
    if a[-1] > a[0]:
        dec += 1
    
    print("Yes" if dec <= 1 else "No")
