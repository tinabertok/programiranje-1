nas_sadovnjak = [[2,4,1,1],
                [3,2,0,5],
                [8,0,7,2]]

def lisjak(sadovnjak, N):
    n = len(sadovnjak)
    m = len(sadovnjak[0])
    def pomozna(i,j, N):
        vsota = 0
        if i >= n or j >= m or N <= 0:
            pass
        elif N == 1:
            vsota += sadovnjak[i][j]
        elif N == 2:
            right = sadovnjak[i+1][j]
            down = sadovnjak[i][j+1]
            vsota += sadovnjak[i][j] + max(right, down)
        else:
            r = pomozna(i+1, j, N-1)
            d = pomozna(i, j+1, N-1)
            vsota += max(r,d)
        return vsota
    return pomozna(0,0, N)


