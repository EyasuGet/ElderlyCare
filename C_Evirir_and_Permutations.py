def is_valid(s: str, n: int) -> str:
    min_prefix = [0] * n
    max_prefix = [0] * n
    min_suffix = [0] * n
    max_suffix = [0] * n
    
    for i in range(n):
        min_prefix[i] = i + 1
        max_prefix[i] = n
    for i in reversed(range(n)):
        min_suffix[i] = 1
        max_suffix[i] = n - i

    used = set()
    current = 1
    perm = [0] * n
    
    # Just assign increasing numbers left to right greedily
    for i in range(n):
        perm[i] = current
        used.add(current)
        current += 1

    # Now validate
    for i in range(n):
        if s[i] == 'p':
            seen = set(perm[:i+1])
            if seen != set(range(1, i+2)):
                return "NO"
        elif s[i] == 's':
            seen = set(perm[i:])
            if seen != set(range(1, n - i + 1)):
                return "NO"
    return "YES"

t = int(input())
for _ in range(t):
    n = int(input())
    s = input().strip()
    print(is_valid(s, n))
