from functools import lru_cache 

denominations = [1, 4, 7, 13, 28, 52, 91, 365]
@lru_cache(maxsize = None)
def bills_rec(n):
    if n == 0 :
        return []
    candidates = []
    all_solutions = []
    for element in denominations:
        if element <= n:
            candidates.append(element)
        else:
            pass
    for candidate in candidates:
        solution = n - candidate
        list_of_solutions = bills_rec(solution) + [candidate]
        all_solutions.append(list_of_solutions)
    return min(all_solutions, key=len)

def bills_greedy(n):
    if n == 0:
        return [] 
    candidates = []
    solutions = []
    for element in denominations:
        if element <= n:
            candidates.append(element)
        else:
            pass
    solutions.append(candidates[-1])
    for element in bills_greedy(n - candidates[-1]):
        solutions.append(element)
    return solutions