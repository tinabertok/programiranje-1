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
