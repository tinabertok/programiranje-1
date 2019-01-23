let uporabi f x = f x

let ibaropu x f = f x 

let rec zacetnih n list = 
  let rec zacetnih' n list acc =
    match n, list with
    | n, _ when n > List.length list -> None
    | 0, _ -> Some (List.rev acc)
    | n, [] -> None
    | n, x :: xs -> zacetnih' (n-1) xs (x:: acc)
    in 
    zacetnih' n list []

 
(*************************************************************************************************)


type 'a neprazen_sez =  Konec of 'a | Sestavljen of 'a * 'a neprazen_sez

let test_sez = Sestavljen(5, Sestavljen(6, Sestavljen(8, Konec (18))))



let prvi = function
    | Sestavljen(x, xs) -> x
    | Konec(x) -> x 


let rec zadnji = function
    | Konec(x) -> x
    | Sestavljen(x, xs) -> zadnji xs
 

let rec dolzina = function
    | Konec(x) -> 1
    | Sestavljen(x, xs) -> 1 + (dolzina xs)


let rec pretvori_v_seznam = function
    | Konec(x) -> [x]
    | Sestavljen(x, xs) -> x :: pretvori_v_seznam xs




let rec zlozi f xs = 
  match xs with
  | Konec(x) -> f x
  | Sestavljen(y, ys) -> zlozi f ys

(**********************************************************************************************************)

let string_rev str =
  let rec aux  idx = match idx with
    0 -> Char.escaped (str.[0])
  | _ -> (Char.escaped str.[idx]) ^ (aux (idx-1)) in
 aux ((String.length str)-1) ;;


let rec simetricen string = 
  if string = string_rev string then true
  else false



  





let rec is_palindrome list =
  let reverse list =
    let rec reverse' acc = function
      | [] -> acc
      | head :: tail -> reverse' (head :: acc) tail
    in
    reverse' [] list
  in
  if list = reverse list then true
  else false
