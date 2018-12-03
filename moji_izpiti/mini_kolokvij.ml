(* -------- 1 -------- *)

let rec prva_funkcija list =
  let rec prva_funkcija' acc list =
    match list with
    | [] -> acc
    | [x] -> acc + x
    | x :: xs -> prva_funkcija' (acc + x) xs

  in
  prva_funkcija' 0 list


(* -------- 2 -------- *)

let rec narascajoce = function
    | [] -> true
    | [x] -> true
    | x :: y :: xs when x <= y -> narascajoce (y :: xs)
    | x :: y :: xs -> false

 
  
(* -------- 3 -------- *)

(*let rec vstavi list x =
  match list, x with 
  | [] -> [x] 
  | a :: as when x <= a -> x :: a :: as
  | a :: b :: bs when a <= x =< b -> a :: x :: b :: bs
  | a :: b :: bs when x > b -> a :: b :: (vstavi bs x ) *)




(* -------- 4 -------- *)




(* -------- 5 -------- *)


type priority =
  | Top
  | Group of int 


type status =
  | Staff
  | Passenger of priority



type flyer = { status : status ; name : string }

let flyers = [ {status = Staff; name = "Quinn"}
             ; {status = Passenger (Group 0); name = "Xiao"}
             ; {status = Passenger Top; name = "Jaina"}
             ; {status = Passenger (Group 1000); name = "Aleks"}
             ; {status = Passenger (Group 1000); name = "Robin"}
             ; {status = Staff; name = "Alan"}
             ] 


(* -------- 6 -------- *)

let rec uredi list =
  let rec uredi' acc1 acc2 acc3 list =
    match list with
    | [] -> acc1 @ acc2 @ acc3
    | flyer :: xs ->
      (match flyer.status with
      | Staff -> uredi' (flyer :: acc1) xs
      | Passenger(priority) -> 
        (match priority with
        | Top -> uredi' (flyer :: acc2) xs
        | Group _  -> uredi' (flyer :: acc3) xs))
  in
  uredi' [] [] [] list 

    






(* -------- 7 -------- *)


let rec bloki list =
  let rec rep bloki' acc list =
    match list with
    | [] -> acc
    | flyer :: xs -> 
      match flyer.status with
      | Staff -> bloki' ([flyer]:: acc)
      | Passenger(priority) -> 
        match priority with 
        | Top -> ([flyer]:: acc)
        | Group - -> ...
