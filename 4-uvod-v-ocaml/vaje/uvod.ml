
(* ========== Vaja 1: Uvod v OCaml  ========== *)

(*----------------------------------------------------------------------------*]
 Funkcija [penultimate_element] vrne predzadnji element danega seznama. V
 primeru prekratkega seznama vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # penultimate_element [1; 2; 3; 4];;
 - : int = 3
[*----------------------------------------------------------------------------*)

let rec ultimate_element list = 
  match list with
  | [] -> failwith "List too short." (* če je seznam prazen*)
  | y :: [] -> y
  | y :: ys -> ultimate_element (ys)




let rec penultimate_element = function
  | [] | _ :: [] -> failwith "List too short."(* če je prazen ali če ima seznam le eno vrednost*)
  | x :: _ :: [] -> x (*če ima seznam dva elementa*)
  | _ :: y :: ys -> penultimate_element (y :: ys) (*drugače pokličemo rekurzijo*)



(*----------------------------------------------------------------------------*]
 Funkcija [get k list] poišče [k]-ti element v seznamu [list]. Številčenje
 elementov seznama (kot ponavadi) pričnemo z 0. Če je k negativen, funkcija
 vrne ničti element. V primeru prekratkega seznama funkcija vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # get 2 [0; 0; 1; 0; 0; 0];;
 - : int = 1
[*----------------------------------------------------------------------------*)
(*poleg argumenta seznam rabimo še k*)
let rec get k list = 
  match k, list with (*matchamo seznam in k, ker rabimo oba argumenta uporabimo match*)
  | _, [] -> failwith "List too short." (*v nadaljevanju ne bo več praznega seznama, ker je bil tu*)
  | k, x :: xs when k <= 0 -> x (*vrenmo ničti element*)
  | k, x :: xs -> get (k-1) xs (*vemo da je k vecji ali manjsi od nic, ker d aje nic je v prejsnem, naredimo rekurzijo*)


(*ker nic ne delamo s k lahko zapisemo tudi tako, ker dejansko matchamo samo list, zato napisemo function, ocaml pa iz vzorca ve da bo dobil list*)
  let rec get k  = function
    |  [] -> failwith "List too short."
    |  x :: xs when k <= 0 -> x 
    |  x :: xs -> get (k-1) xs 
  
(*----------------------------------------------------------------------------*]
 Funkcija [double] podvoji pojavitve elementov v seznamu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # podvoji [1; 2; 3];;
 - : int list = [1; 1; 2; 2; 3; 3]
[*----------------------------------------------------------------------------*)

let rec double = function
| [] -> []
| x :: [] -> x :: x :: []
| x :: xs -> x :: x :: double xs

(*----------------------------------------------------------------------------*]
 Funkcija [divide k list] seznam razdeli na dva seznama. Prvi vsebuje prvih [k]
 elementov, drugi pa vse ostale. Funkcija vrne par teh seznamov. V primeru, ko
 je [k] izven mej seznama, je primeren od seznamov prazen.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # divide 2 [1; 2; 3; 4; 5];;
 - : int list * int list = ([1; 2], [3; 4; 5])
 # divide 7 [1; 2; 3; 4; 5];;
 - : int list * int list = ([1; 2; 3; 4; 5], [])
[*----------------------------------------------------------------------------*)

let rec divide k list =
  match k, list with
  | k, list when ( k <= 0) -> ([], list)
  | k, [] -> ([], [])
  | k, x :: xs -> 
    let (left_list, right_list) = divide (k-1) xs in
    (x :: left_list, right_list)

  

(*----------------------------------------------------------------------------*]
 Funkcija [delete k list] iz seznama izbriše [k]-ti element. V primeru
 prekratkega seznama funkcija vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # delete 3 [0; 0; 0; 1; 0; 0];;
 - : int list = [0; 0; 0; 0; 0]
[*----------------------------------------------------------------------------*)

let rec delete k list =
  match k, list with
  | k, [] -> failwith "List too short."
  | k, list when ( k<0) -> list
  | 0, x :: xs -> xs
  | k, x :: xs -> x :: delete(k-1) xs

(*----------------------------------------------------------------------------*]
 Funkcija [slice i k list] sestavi nov seznam, ki vsebuje elemente seznama
 [list] od vključno [i]-tega do izključno [k]-tega. Predpostavimo, da sta [i] in
 [k] primerna.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # slice 3 6 [0; 0; 0; 1; 2; 3; 0; 0];;
 - : int list = [1; 2; 3]
[*----------------------------------------------------------------------------*)

let rec slice i k list = 
  match i, k, list with
  | i, k, [] -> []
  | i, k, list -> 
    let (levi, desni) = divide (i) list in
    let (levi2, desni2) = divide (i+k) desni in
    levi2


(*----------------------------------------------------------------------------*]
 Funkcija [insert x k list] na [k]-to mesto seznama [list] vrine element [x].
 Če je [k] izven mej seznama, ga funkcija doda na začetek oziroma na konec.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # insert 1 3 [0; 0; 0; 0; 0];;
 - : int list = [0; 0; 0; 1; 0; 0]
 # insert 1 (-2) [0; 0; 0; 0; 0];;
 - : int list = [1; 0; 0; 0; 0; 0]
[*----------------------------------------------------------------------------*)

let rec insert x k list = 
  match x, k, list with
  |x, k, [] -> [x]
  |x, k, list when (k<0) -> k :: list
  |x, 0, list -> x :: list
  |x, k, y :: ys -> y :: insert x (k-1) ys



(*----------------------------------------------------------------------------*]
 Funkcija [rotate n list] seznam zavrti za [n] mest v levo. Predpostavimo, da
 je [n] v mejah seznama.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # rotate 2 [1; 2; 3; 4; 5];;
 - : int list = [3; 4; 5; 1; 2]
[*----------------------------------------------------------------------------*)

let rec rotate n list = 
  match n, list with
  |n, [] -> [](*če je n enak size(list) vrni enak seznam*)


let obrni list =
  let obrni' acc = function
    |[] -> acc
    |glava :: rep -> obrni' (glava :: acc) rep
    in
    obrni' [] list


(*----------------------------------------------------------------------------*]
 Funkcija [remove x list] iz seznama izbriše vse pojavitve elementa [x].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # remove 1 [1; 1; 2; 3; 1; 2; 3; 1; 1];;
 - : int list = [2; 3; 2; 3]
[*----------------------------------------------------------------------------*)

let rec remove x list = 
  match x, list with
  |x, [] -> []
  |x, y :: ys -> y :: remove x ys
  |x, x :: ys -> remove x ys
  |x, ys :: x -> remove x ys



(*----------------------------------------------------------------------------*]
 Funkcija [is_palindrome] za dani seznam ugotovi ali predstavlja palindrom.
 Namig: Pomagaj si s pomožno funkcijo, ki obrne vrstni red elementov seznama.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # is_palindrome [1; 2; 3; 2; 1];;
 - : bool = true
 # is_palindrome [0; 0; 1; 0];;
 - : bool = false
[*----------------------------------------------------------------------------*)

let obrni list =
  let obrni' acc = function
    |[] -> acc
    |glava :: rep -> obrni' (glava :: acc) rep
    in
    obrni' [] list


let rec is_palindrome list = 
  if list = obrni list then true
  else false


(*----------------------------------------------------------------------------*]
 Funkcija [max_on_components] sprejme dva seznama in vrne nov seznam, katerega
 elementi so večji od istoležnih elementov na danih seznamih. Skupni seznam ima
 dolžino krajšega od danih seznamov.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # max_on_components [5; 4; 3; 2; 1] [0; 1; 2; 3; 4; 5; 6];;
 - : int list = [5; 4; 3; 3; 4]
[*----------------------------------------------------------------------------*)

let rec max_on_components list_1 list_2 = 
  match list_1, list_2 with 
  |x :: xs, y :: ys when x>y -> x :: max_on_components xs ys

(*----------------------------------------------------------------------------*]
 Funkcija [second_largest] vrne drugo največjo vrednost v seznamu. Pri tem se
 ponovitve elementa štejejo kot ena vrednost. Predpostavimo, da ima seznam vsaj
 dve različni vrednosti.
 Namig: Pomagaj si s pomožno funkcijo, ki poišče največjo vrednost v seznamu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # second_largest [1; 10; 11; 11; 5; 4; 10];;
 - : int = 10
[*----------------------------------------------------------------------------*)

let my_max = function
  | [] -> failwith "Prazen seznam!"
  | x::xs -> List.fold_left max x xs


(*maksimum odstranimo iz seznama in poženemo še enkrat funkcijo my_max*)

let rec second_largest = ()
