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

 




type 'a neprazen_sez =  Konec of 'a | Sestavljen of 'a * 'a neprazen_sez


let prvi = function
    | Sestavljen(x, xs) -> x
    | Konec(x) -> x 

    