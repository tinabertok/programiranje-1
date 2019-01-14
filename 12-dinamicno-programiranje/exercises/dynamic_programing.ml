(* ========== Exercises 6: Dynamic programing  ========== *)
let memoiziraj_rec odviti_f =
  let rezultati = Hashtbl.create 512 in
  let rec mem_f x =
    if Hashtbl.mem rezultati x then 
      Hashtbl.find rezultati x
    else
      let y = odviti_f mem_f x in
      Hashtbl.add rezultati x y;
      y
  in
  mem_f


(*----------------------------------------------------------------------------*]
 The gluttonous mouse is located in the left upper corner of a matrix. It can
 only move one field down or one field right and at the end it must arrive at
 the lower right corner. On every square of the field there is a given
 (non-negative) amount of cheese. The mouse wants to eat as much as possible
 and its trying to figure out the optimal way.

 Write the function [max_cheese cheese_matrix] that given a matrix of cheese
 amounts calculates the overall amount of cheese that the mouse will eat if it
 follows the optimal way.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # max_cheese test_matrix;;
 - : int = 13
[*----------------------------------------------------------------------------*)

let test_matrix = 
  [| [| 1 ; 2 ; 0 |];
     [| 2 ; 4 ; 5 |];
     [| 7 ; 0 ; 1 |] |]


(*
let max_cheese matrix = 
  let n = Array.length matrix in 
  let m = Array.length matrix.(0) in (*to lahko faila, če je prva vrstica prazna*)
  let rec max_cheese' (i, j) =
    if i >= n || j >= m then (*zaustavitveni poogoj*)
      0
    else
      let right = max_cheese' (i, j+1) in 
      let down = max_cheese' (i+1, j) in
      let our_cheese = matrix.(i).(j) in
      our_cheese +  max right down
  in 
  max_cheese' (0, 0) 
*)


  let max_cheese matrix = 
    let n = Array.length matrix in 
    let m = Array.length matrix.(0) in (*to lahko faila, če je prva vrstica prazna*)
    let max_cheese' recursive_max_cheese' (i, j) =
      if i >= n || j >= m then (*zaustavitveni poogoj*)
        0
      else
        let right = recursive_max_cheese' (i, j+1) in 
        let down = recursive_max_cheese' (i+1, j) in
        let our_cheese = matrix.(i).(j) in
        our_cheese +  max right down
    in 
    let memoised_max_cheese = memoiziraj_rec max_cheese' in 
    memoised_max_cheese (0, 0)

(*----------------------------------------------------------------------------*]
 We are solving the problem of alternatingly colored towers. There are four
 different types of building blocks, two of them blue and two red. The blue
 blocks have heights 2 and 3 and the red ones 1 and 2.

 Write the function [alternating_towers] for a given height calculates the
 number of different towers of given height that we can build using alternatingly
 colored blocks (red on blue, blue on red etc.). We may start with any color.

 Hint: Use two mutually recursive auxilary functions using the keyword "and".
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # alternating_towers 10;;
 - : int = 35
[*----------------------------------------------------------------------------*)


(*----------------------------------------------------------------------------*]
 You have won a coupon for Mercator, allowing you to purchase any articles in
 the shop, whose total weight does not exceed [max_w] kilograms. Write a
 function [best_value articles max_w], which computes the largest price sum,
 that we can get for the coupon, where we can take as many articles of the
 same kind as we want. Then write a function [best_value_uniques articles max_w]
 where only one article of the same kind may be pruchased.

 Hint: The module [Array] offers many functions such as [map], [fold_left],
 [copy] and similar, which can be used as an alternative to loops.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # best_value articles 1.;;
 - : float = 10.95
 # best_value_unique articles 1.;;
- : float = 7.66
[*----------------------------------------------------------------------------*)

(* Articles are of form (name, price, weight) *)
let articles = [|
	("yoghurt", 0.39, 0.18);
	("milk", 0.89, 1.03);
  ("coffee", 2.19, 0.2);
  ("butter", 1.49, 0.25);
  ("yeast", 0.22, 0.042);
  ("eggs", 2.39, 0.69);
  ("sausage", 3.76, 0.50);
  ("bread", 2.99, 1.0);
  ("Nutella", 4.99, 0.75);
  ("juice", 1.15, 2.0)
|]


 