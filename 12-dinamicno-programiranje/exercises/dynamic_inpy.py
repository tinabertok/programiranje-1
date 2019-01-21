from functools import lru_cache

articles = [
("yoghurt", 0.39, 0.18),
("milk", 0.89, 1.03),
("coffee", 2.19, 0.2),
("butter", 1.49, 0.25),
("yeast", 0.22, 0.042),
("eggs", 2.39, 0.69),
("sausage", 3.76, 0.50),
("bread", 2.99, 1.0),
("Nutella", 4.99, 0.75),
("juice", 1.15, 2.0)
]

def best_value_uniques(articles, max_w):
    def best_val(w):
        options = []
        for item in articles:
            (name, price, weight) = item
            if w - weight <= 0:
                pass
            else:
                option = best_val(w - weight) + price
                options.append(option)
        if options:
            return max(options)
        else:
            return 0 
    return best_val(max_w)    


print(best_value_uniques(articles, 1))           


def best_value_unique(articles, max_w):
     #taken is the string where taken[n] = "0" denotes that the n-th item has not yet been taken
    @lru_cache(maxsize=None)
    def best_val(w, taken):
        options = []
        for i, item in enumerate(articles):
            (name, price, weight) = item
            if w - weight <= 0 or taken[i] == "1":
                pass
            else:
                new_taken = taken[:i] + "1" + taken[i+1:] #nov seznam, se pravi skopiramo začetek in konec vmes pa damo 1 
                option = best_val(w - weight, new_taken) + price
                options.append(option)
        if options:
            return max(options)
        else:
            return 0 
    return best_val(max_w, "0" * len(articles))

print(best_value_unique(articles, 1))

# The gluttonous mouse is located in the left upper corner of a matrix. It can
#  only move one field down or one field right and at the end it must arrive at
#  the lower right corner. On every square of the field there is a given
#  (non-negative) amount of cheese. The mouse wants to eat as much as possible
#  and its trying to figure out the optimal way.

#  Write the function [max_cheese cheese_matrix] that given a matrix of cheese
#  amounts calculates the overall amount of cheese that the mouse will eat if it
#  follows the optimal way.
#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  # max_cheese test_matrix;;
#  - : int = 13

def max_cheese(matrix):
    n = len(matrix)
    m = len(matrix[0])
    def pomozna(i,j): 
        if i >= n:
            return 0
        elif j >= m:
            return 0 
        else: 
            right = pomozna(i, j+1) 
            down = pomozna(i+1, j)
            if right > down:
                return right + matrix[i][j]
            else:
                return down + matrix[i][j]
    return pomozna(0,0)

test_matrix = [ [ 1 , 2 , 0 ],
     [ 2 , 4 , 5 ],
     [ 7 , 0 , 1 ] ]


#  We are solving the problem of alternatingly colored towers. There are four
#  different types of building blocks, two of them blue and two red. The blue
#  blocks have heights 2 and 3 and the red ones 1 and 2.

#  Write the function [alternating_towers] for a given height calculates the
#  number of different towers of given height that we can build using alternatingly
#  colored blocks (red on blue, blue on red etc.). We may start with any color.

#  Hint: Use two mutually recursive auxilary functions using the keyword "and".
#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  # alternating_towers 10;;
#  - : int = 35



@lru_cache(maxsize=None)
def stolpi(n, color):
    if n == 0:
        return 1
    elif n < 0:
        return 0
    else:
        if color == 'blue':
            option2 = stolpi(n-2, 'red')
            option3 = stolpi(n-3, 'red')
            option_blue = option2 + option3
            return option_blue
        else:
            option2 = stolpi(n-2, 'blue')
            option1 = stolpi(n-1, 'blue')
            option_red = option2 + option1
            return option_red
        
    
def alternating_towers(n):
    return stolpi(n,'blue') + stolpi(n, 'red')



