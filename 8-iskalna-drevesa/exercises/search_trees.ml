(* ========== Exercise 4: Search trees  ========== *)

(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 In Ocaml working with trees is fairly simple. We construct a new type for
 trees, which are either empty or they contain some data and two (possibly
 empty) subtrees. We assume no further structure of the trees.
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)
type 'a tree = 
    | Empty
    | Node of 'a tree *  'a * 'a tree
(*
type 'a tree =
    | Empty 
    | Leaf 'a
    | Node of 'a tree *  'a * 'a tree

iz tega da dodamo leaf ne profitiramo je le kozmetični popravek 
Leaf x = Node (Empty, x, Empty)
*)

let leaf x = Node(Empty, x, Empty)


(*----------------------------------------------------------------------------*]
 We define a test case for simpler testing of functions. The test case
 represents the tree below. The function [leaf], which constructs a leaf from a
 given data, is used for simpler notation.
          5
         / \
        2   7
       /   / \
      0   6   11
[*----------------------------------------------------------------------------*)
let test_tree = 
    let left_tree = Node(leaf 0, 2, Empty) in
    let right_tree = Node(leaf 6, 7, leaf 11) in
    Node(left_tree, 5, right_tree)


(*----------------------------------------------------------------------------*]
 The function [mirror] returns a mirrored tree. When applied to our test tree
 it returns
          5
         / \
        7   2
       / \   \
      11  6   0
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # mirror test_tree ;;
 - : int tree =
 Node (Node (Node (Empty, 11, Empty), 7, Node (Empty, 6, Empty)), 5,
 Node (Empty, 2, Node (Empty, 0, Empty)))
[*----------------------------------------------------------------------------*)

let rec mirror = function
    | Empty -> Empty
    | Node(lt, x, rt) -> Node(mirror rt, x, mirror lt)


(*----------------------------------------------------------------------------*]
 The function [height] returns the height (or depth) of the tree and the
 function [size] returns the number of nodes in the tree.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # height test_tree;;
 - : int = 3
 # size test_tree;;
 - : int = 6
[*----------------------------------------------------------------------------*)

let rec height = function
    | Empty -> 0
    | Node(lt, x, rt) -> 
    if height lt > height rt then 1 + height lt
    else 1 + height rt

let rec size = function 
    | Empty -> 0
    | Node(lt, x, rt) -> 1 + size lt + size rt


(* probajmo napisati še repno rekurzivni size, rabimo še dodaten akumulator da si zapomnimo 
vsa drevesa ki jih moramo še obdelat*)

let tl_rec_size tree =
    let rec size' acc queue =
        (*Pogledamo, kateri je naslednji element v vrsti za obravnano.*)
        match queue with
        | [] -> acc
        | t :: ts -> (
            (*Obravnavamo drevo.*)
            match t with 
            | Empty -> size' acc ts (* Prazno drevo samo odstranimo iz vrste.*)
            | Node(lt, x, rt) -> 
                let new_acc = acc + 1 in (*obravnavamo vozlišče*)
                let new_queue = lt :: rt :: ts in (*Dodamo poddrevesa v vrsto.*)
                size' new_acc new_queue
        )
        in
        (*Zaženemo pomožno funkcijo*)
        size' 0 [tree]


(*----------------------------------------------------------------------------*]
 The function [map_tree f tree] maps the tree into a new tree with nodes that
 contain data from [tree] mapped with the function [f].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # map_tree ((<)3) test_tree;;
 - : bool tree =
 Node (Node (Node (Empty, false, Empty), false, Empty), true,
 Node (Node (Empty, true, Empty), true, Node (Empty, true, Empty)))
[*----------------------------------------------------------------------------*)

let rec map_tree f tree =
    match tree with
    | Empty -> Empty
    | Node(lt, x, rt) -> Node (map_tree f lt, f x, map_tree f rt)

(*----------------------------------------------------------------------------*]
 The function [list_of_tree] returns the list of all elements in the tree. If
 the tree is a binary search tree the returned list should be ordered.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # list_of_tree test_tree;;
 - : int list = [0; 2; 5; 6; 7; 11]
[*----------------------------------------------------------------------------*)

let rec list_of_tree = function
    | Empty -> []
    | Node(lt, x, rt) -> list_of_tree lt @ [x] @ list_of_tree rt


(*----------------------------------------------------------------------------*]
 The function [is_bst] checks wheter a tree is a binary search tree (BST). 
 Assume that the input tree has no repetitions of elements. An empty tree is a
 BST.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # is_bst test_tree;;
 - : bool = true
 # test_tree |> mirror |> is_bst;;
 - : bool = false
[*----------------------------------------------------------------------------*)


let rec narascajoce = function
    | [] -> true
    | [x] -> true
    | x :: y :: xs when x <= y -> narascajoce (y :: xs)
    | x :: y :: xs -> false

let is_bst tree = 
    match tree with 
    | Empty -> true
    | Node(lt, x, rt) ->
    if narascajoce(list_of_tree tree) then true
    else false



(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 In the remaining exercises we assume that all trees are binary search trees.
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)

(*----------------------------------------------------------------------------*]
 The function [insert] correctly inserts an element into the bst. The function
 [member] checks wheter an element is present in the bst.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # insert 2 (leaf 4);;
 - : int tree = Node (Node (Empty, 2, Empty), 4, Empty)
 # member 3 test_tree;;
 - : bool = false
[*----------------------------------------------------------------------------*)

let rec insert x tree = 
    match tree with 
    | Empty -> leaf x
    | Node(lt, y, rt) -> 
    if x = y then 
        tree
    else if x < y then
        Node(insert x lt, y, rt)
    else
        Node(lt, y, insert x rt)



let rec member x tree =
    match tree with
    | Empty -> false
    | Node(lt, y, rt) ->
    if x = y then 
        true
    else if x < y then
        member x lt 
    else 
        member x rt


(*----------------------------------------------------------------------------*]
 The function [member2] does not assume that the tree is a bst.
 
 Note: Think about the differences of time complexity for [member] and 
 [member2] assuming an input tree with n nodes and depth of log(n). 
[*----------------------------------------------------------------------------*)

let rec member2 x tree = 
    match tree with
    | Empty -> false
    | Node(lt, y, rt) -> 
    if x = y then true
    else if member2 x lt || member2 x rt then true
    else false



(*----------------------------------------------------------------------------*]
 The function [succ] returns the successor of the root of the given tree, if
 it exists. For the tree [bst = Node(l, x, r)] it returns the least element of
 [bst] that is larger than [x].
 The function [pred] symetrically returns the largest element smaller than the
 root, if it exists.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # succ test_tree;;
 - : int option = Some 6
 # pred (Node(Empty, 5, leaf 7));;
 - : int option = None
[*----------------------------------------------------------------------------*)

let rec min = function
    | Empty -> None
    | Node (Empty, x, _) -> Some x
    | Node(lt, x, rt) -> min lt 

let rec succ = function
    | Empty -> None
    | Node(lt, x, rt) -> min rt



let rec max = function
    | Empty -> None
    | Node (_, x, Empty) -> Some x
    | Node(lt, x, rt) -> max rt 


let rec pred = function
    | Empty -> None
    | Node(lt, x, rt) -> max lt




(*----------------------------------------------------------------------------*]
 In lectures you two different approaches to deletion, using either [succ] or
 [pred]. The function [delete x bst] deletes the element [x] from the tree. If
 it does not exist, it does not change the tree. For practice you can implement
 both versions of the algorithm.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # (*<< For [delete] defined with [succ]. >>*)
 # delete 7 test_tree;;
 - : int tree =
 Node (Node (Node (Empty, 0, Empty), 2, Empty), 5,
 Node (Node (Empty, 6, Empty), 11, Empty))
[*----------------------------------------------------------------------------*)


let rec delete x bst =
    match bst with 
    | Empty -> Empty (*Empty case*)
    | Node(Empty, y, Empty) when x = y -> Empty (*Leaf case*)
    | Node(Empty, y, rt) when x = y -> rt (*One sided*)
    | Node(lt, y, Empty) when x = y -> lt
    | Node(lt, y, rt) when x <> y -> (*Recurse deeper*)
        if x > y then
            Node(lt, y, delete x rt)
        else 
            Node(delete x lt, y, rt)
    | Node(lt, y, rt) -> (*Difficult case*)
        match succ bst with 
        | None -> failwith "HOW IS THIS POSSIBLE?!" (*This cannot happen*)
        | Some z -> Node(lt, z, delete z rt)
    




(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 DICTIONARIES

 Using BST we can (sufficiently) implement dictionaries. While in practice we
 use the even more efficient hash tables, we assume that our dictionaries [dict]
 are implemented using BST. Every node includes a key and a value and the three
 has the BST structure according to the value of node keys. Because the
 dictionary requires a type for keys and a type for values, we parametrize the
 type as [('key, 'value) dict].
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)
type ('k, 'v) dict  =
    | Empty 
    | Node of ('k, 'v) dict * ('k * 'v ) * ('k, 'v) dict

    

(*----------------------------------------------------------------------------*]
 Write the test case [test_dict]:
      "b":1
      /    \
  "a":0  "d":2
         /
     "c":-2
[*----------------------------------------------------------------------------*)

let leaf (k, v) = Node(Empty, (k, v) , Empty)

let test_dict =
    let ld = leaf ("a", 0) in
    let rd = Node(leaf("c", -2), ("d", 2), Empty) in
    Node (ld, ("b", 1), rd)


(*----------------------------------------------------------------------------*]
 The function [dict_get key dict] returns the value with the given key. Because
 the  dictionary might not include the given key, we return an [option].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # dict_get "banana" test_dict;;
 - : 'a option = None
 # dict_get "c" test_dict;;
 - : int option = Some (-2)
[*----------------------------------------------------------------------------*)
let rec dict_get key dict =
    match dict with
    | Empty -> None
    | Node(ld, (k, v), rd) -> 
        (match String.compare key k with
        | 0 -> Some v
        | -1 -> dict_get key ld
        | 1 -> dict_get key rd 
        | _ -> None )
    
        
(*----------------------------------------------------------------------------*]
 The function [print_dict] accepts a dictionary with key of type [string] and
 values of type [int] and prints (in the correct order) lines containing 
 "key : value" for all nodes of the dictionary. Hint: Use functions
 [print_string] and [print_int]. Strings are concatenated with the operator [^].
 Observe how using those functions fixes the type parameters of our function, as
 opposed to [dict_get]. 
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # print_dict test_dict;;
 a : 0
 b : 1
 c : -2
 d : 2
 - : unit = ()
[*----------------------------------------------------------------------------*)

let rec print_dict = function
    | Empty -> ()
    | Node(ld, (k,v), rd) -> (print_dict ld);(print_string(k));(print_string(":"));(print_int(v));(print_string("\n"));(print_dict rd)





(*----------------------------------------------------------------------------*]
 The function [dict_insert key value dict] inserts [value] into [dict] under the
 given [key]. If a key already exists, it replaces the value.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # dict_insert "1" 14 test_dict |> print_dict;;
 1 : 14
 a : 0
 b : 1
 c : -2
 d : 2
 - : unit = ()
 # dict_insert "c" 14 test_dict |> print_dict;;
 a : 0
 b : 1
 c : 14
 d : 2
 - : unit = ()
[*----------------------------------------------------------------------------*)

let rec dict_insert key value dict = 
    match dict with 
    | Empty -> leaf(key, value)
    | Node(ld, (k,v), rd) -> 
    if k = key then
        Node(ld, (key, value), rd)
    else if key < k then
        Node(dict_insert key value ld, (k,v), rd)
    else
        Node(ld, (k,v), dict_insert key value rd)


