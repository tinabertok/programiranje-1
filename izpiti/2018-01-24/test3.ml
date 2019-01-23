(*1.naloga*)
let rec izpisi_vsa_stevila s = 
  for i = 0 to (List.length s)-1 do 
    print_int (List.nth s i)
  done
;;
let map2_opt f xs ys = 
  let rec aux f xs ys acc =
    match xs, ys with
    | xs, ys when List.length xs != List.length ys -> None
    | [], [] -> Some (List.rev acc)
    | xs, [] -> None
    | [], ys -> None
    | x :: xs', y :: ys' -> aux f xs' ys' ((f x y) :: acc)
  in 
  aux f xs ys []


(*2.naloga*)

type filter_tree = Leaf of int list | Node of filter_tree * int * filter_tree

let primer = Node(
  Node((Leaf[1]), 5, (Leaf[])),
  10,
  Node((Leaf[]), 15, (Leaf[19;20]))
)

let rec vstavi n tree =
  match tree with
  | Leaf[] -> Leaf[n]
  | Leaf(xs) -> Leaf(n :: xs)
  | Node(lt, k, rt) -> 
    if n <= k then
      Node(vstavi n lt, k, rt)
    else
      Node(lt, k, vstavi n rt)
      

let rec vstavi_seznam list tree =
  match list with
  | [] -> tree
  | [x] -> vstavi x tree
  | x :: xs -> 
    let new_tree = vstavi x tree in
    vstavi_seznam xs new_tree


let rec vsi_manjsi x tree =
   match tree with
   | Leaf xs -> List.for_all ((>) x) xs
   | Node(lt, k, rt)-> 
    let left = vsi_manjsi x lt in
    let right = vsi_manjsi x rt in 
    left && right && x > k

let rec vsi_vecji x tree =
  match tree with
  | Leaf xs -> List.for_all ((<) x) xs
  | Node(lt, k, rt)-> 
    let left = vsi_vecji x lt in
    let right = vsi_vecji x rt in 
    left && right && x < k
   
let rec preveri tree = 
  match tree with
  | Leaf(_) -> true
  | Node(lt, x, rt) -> if vsi_manjsi x lt && vsi_vecji x rt then true else false
  
(*********************************************************************************************)

