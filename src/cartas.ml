exception Empty_deck
exception No_card

(* Definimos algunos tipos y constantes *)
type suit = Espada | Copa | Oro | Basto |  ID | SWAP | MAX | MIN | TOP | PAR 

type card =
  { value : int;
    suit  : suit
  }

type deck = card list

(* '-1' para no tener conflicto con la funcion save_even*)
(* Constantes especiales*)
let id = {value = -1; suit = ID};;
let swap = {value = -1; suit = SWAP};;
let max = {value = -1; suit = MAX};;
let min = {value = -1; suit = MIN};;
let top = {value = -1; suit = TOP};;
let par = {value = -1; suit = PAR};;

let specials = [id; swap; max; min; top; par]

let values = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12]
let normal_suits = [Espada; Copa; Oro; Basto]

let empty_deck = ([]:deck)
let full_deck =
  let make_value_cards num =
    List.map (fun suit -> {value = num; suit = suit}) normal_suits
  in
  specials @ (List.concat (List.map make_value_cards values))

(* Mezclar el maso *)
let rec shuffle (cards:deck) =
  let rec extract acc n = function
    [] -> raise Not_found
    | h :: t -> if n = 0 then (h, acc @ t) else extract (h::acc) (n-1) t
  in
  let extract_rand aux_list len =
    Random.self_init();
    extract [] (Random.int len) aux_list
  in
  let rec aux acc aux_list len =
    if len = 0 then acc else
      let picked, rest = extract_rand aux_list len in
      aux (picked :: acc) rest (len-1)
  in
  aux [] cards (List.length cards)
;;

(* Funciones generales para usar cartas *)

let rec deck_size (target:deck) = List.length target
;;

(* Mueve la primera carta del segundo mazo al primero *)
let take_from_deck (hand:deck) = function
  [] -> (hand, [])
  | x :: xs -> (x::hand, xs)
;;

(* Funcion auxiliar para tomar n cartas del mazo *)
let take n xs =
  let rec take' n xs acc =
    match n with 
      0 -> (List.rev acc, xs)
    | _ -> take' (n-1) (List.tl xs) (List.hd xs :: acc)
  in take' n xs []
;;

(* Repartir las cartas iniciales *)
let deal_hand (hand:deck) = function
  [] -> invalid_arg "Empty deck"
  | xs -> let firsts, rest = take 7 xs in
          (hand @ firsts, rest)
;;

(* Definimos una funcion para comparar cartas *)
let cards_equal (first:card) (second:card) =
  if first.value = second.value then
  if first.suit = second.suit then true
  else false
  else false
;;

let rec deck_has_card (c:card) (d:deck) =
  match d with
    [] -> false
  | x :: xs -> if cards_equal c x then true else deck_has_card c xs
;;

let rec decks_equal (d:deck) (o:deck) =
  match d with
    [] -> (match o with
             [] -> true
           | _ -> false)
  | x :: xs -> match o with
                 [] -> false
               | y :: ys -> if cards_equal x y then decks_equal xs ys
                            else false
;;

let play_card (c:card) (hand:deck) (table:deck) =
  try
    let rec play_card' c h t acc =
      match h with
        [] -> invalid_arg "Card not in deck."
      | x :: xs -> if cards_equal c x then ((List.rev acc) @ xs, x :: t)
                 else play_card' c xs t (x::acc)
      in
    play_card' c hand table []
  with No_card -> (hand, table)
;;

let biggest_card (fst:card) (scnd:card) =
  if fst.value == scnd.value then
    if fst.suit == Espada then fst
    else if scnd.suit == Espada then scnd
    else if fst.suit == Basto then fst
    else if scnd.suit == Basto then scnd
    else if fst.suit == Oro then fst
    else scnd
  else if fst.value < scnd.value then scnd else fst
;;

let lowest_card (fst:card) (scnd:card) =
  if fst.value == scnd.value then
    if fst.suit == Espada then scnd
    else if scnd.suit == Espada then fst
    else if fst.suit == Basto then scnd
    else if scnd.suit == Basto then fst
    else if fst.suit == Oro then scnd
    else fst
  else if fst.value < scnd.value then fst else scnd
;;

let rec print_card (target:card) =
  match target.suit with
    Espada -> print_char 'E'; print_int target.value
  | Oro -> print_char 'O'; print_int target.value
  | Copa -> print_char 'C'; print_int target.value
  | Basto -> print_char 'B'; print_int target.value
  | ID -> print_string "SID"
  | SWAP -> print_string "SSWAP"
  | MAX -> print_string "SMAX"
  | MIN -> print_string "SMIN"
  | TOP -> print_string "STOP"
  | PAR -> print_string "SPAR"
;;

let rec print_deck (target:deck) =
  match target with
    [] -> print_newline ()
  | [x] -> print_card x;
           print_newline ()
  | x :: xs -> print_card x;
               print_char ' ';
               print_deck xs
;;

let string_to_card c =
  let len = (String.length c - 1)  in
  let possible_int = (String.sub c 1 len)
  in
  try
  match String.get c 0 with
    'E' -> [{value = int_of_string possible_int; suit = Espada}]
  | 'C' -> [{value = int_of_string possible_int; suit = Copa}]
  | 'O' -> [{value = int_of_string possible_int; suit = Oro}]
  | 'B' -> [{value = int_of_string possible_int; suit = Basto}]
  | 'S' -> (match String.sub c 1 2 with
              "ID" -> [{value = -1; suit = ID}]
            | "SW" -> [{value = -1; suit = SWAP}]
            | "MA" -> [{value = -1; suit = MAX}]
            | "MI" -> [{value = -1; suit = MIN}]
            | "TO" -> [{value = -1; suit = TOP}]
            | "PA" -> [{value = -1; suit = PAR}]
            | _ -> invalid_arg "No such card.")
  | _ -> invalid_arg "No such card."
  with Failure "int_of_string" -> (print_endline "No es una carta valida!"; [])
;;

(* Funciones para usar cartas especiales *)
let swap_decks (hand:deck) (general:deck) = (general, hand)
;;

let is_odd (x:card) =
  if (x.value) mod 2 == 0 then false
  else true
;;

let is_even (x:card) =
  not (is_odd x)
;;

let take_evens (hand:deck) (general:deck) =
  match general with
    [] -> (hand, [])
  | x :: xs ->
     (hand @ (List.filter is_even general), List.filter is_odd general)
;;

let max_card = function 
  [] -> invalid_arg "Empty deck"
  | x :: xs -> List.fold_left biggest_card x xs
(*fold_left Recursion en la cola*)
;;

let min_card = function
  [] -> invalid_arg "Empty deck"
  | x :: xs -> List.fold_left lowest_card x xs
;;

let rec remove_card (c:card) = function
  [] -> invalid_arg "Empty deck"
  | x :: xs -> if cards_equal x c then xs else x :: remove_card c xs
;;

let is_normal (c:card) = 
  if (cards_equal c id || cards_equal c swap || cards_equal c par ||
      cards_equal c max || cards_equal c min || cards_equal c top) then false
  else true 
;;

let throw_min_card (hand:deck) (general:deck) =
  try 
    let min = min_card hand
    in (remove_card min hand, general @ [min])
  with Empty_deck -> (hand, general)
;;

let take_max_card (hand:deck) (general:deck) =
  try
    let max = max_card general
    in (max :: hand, remove_card max general)
  with Empty_deck -> (hand, general)
;;
