from functools import lru_cache

def simetricen(s):
    return s == s[::-1] 
@lru_cache(maxsize = None)

def stevilo_delov(s):
    palindromi = []
    if simetricen(s):
        return 1
    else:
        for i in range(1, len(s)):
            if simetricen(s[0:i]):
                palindromi.append(i)
    stevila = []
    for indeks in palindromi:
        stevilo = 1 + stevilo_delov(s[indeks:])
        stevila.append(stevilo)
    return min(stevila)

def razdeli(s):
    options = None
    if len(s) == 0:
        return [s]
    elif len(s) == 1:
        return [s]
    elif simetricen(s):
        return [s]
    else:
        for i in range(1, len(s)):
            left = razdeli(s[:i])
            right = razdeli(s[i:])
            k = left + right

            if options == None:
                options = k
            else:
                m = options
                if k < m:
                    options = k

        return options
