open Cartas

exception Empty_deck
exception No_card

(* Funciones de Jugador y estructura*)

type player =
  { name    : string;
    points  : int;
    cards   : deck;
    played  : deck;
  }

(* Inicializa un nuevo jugador con el nombre otorgado*)
let new_player (new_name:string) = 
  { name = new_name; points = 0; cards = empty_deck; played = empty_deck}
;;

(* Entrega una carta a un jugador 'p'*)
let give_card (p:player) (general:deck) =
  try
    let hand, new_general = take_from_deck p.cards general 
    in
    ({ name = p.name; points = p.points; cards = hand; played = p.played}
    , new_general)
  with Empty_deck -> (print_string "No hay mas cartas";
                      (p, general))
;;

 (* Entrega 7 cartas a un jugador 'p' del mazo general *)
let give_seven_cards (p:player) (general:deck) =
  let hand, new_general = deal_hand p.cards general
  in
  ({ name = p.name; points = p.points; cards = hand; played= p.played},
     new_general)
;;

(* Otorga un punto al jugador 'p' *)
let give_point (p:player) = 
  {name = p.name; points = p.points + 1; cards = p.cards; played = p.played}
;;

let winner (p:player) (o:player) =
  let c = max_card p.played in
  let d = max_card o.played in
  if cards_equal (biggest_card c d) c then p
  else o
;;

(* Toma una carta del maso del jugador 'p' y lo entrega al maso de 'table'
    table seria 'las cartas jugadas en la ronda' del jugador *)
let use_card (c:card) (p:player) =
  try 
    let new_hand, new_table = play_card c p.cards p.played in
    {name = p.name; points = p.points; cards = new_hand; played = new_table}
  with No_card -> p
;;

(* Funcion cartas especiales *)
let use_card_special (c:card) (p:player) (general:deck) =
  let new_player = use_card c p in
  let aux_hand, new_played = new_player.cards, new_player.played in
  if cards_equal c par then
  let new_hand, aux_gen = take_evens aux_hand general in
  let aux_p = 
    {name = p.name; points = p.points;
     cards = new_hand; played = new_played}
  in
  give_card aux_p aux_gen
  else if cards_equal c swap then
  let new_hand, aux_gen = swap_decks aux_hand general in
  let aux_p = 
    {name = p.name; points = p.points;
     cards = new_hand; played = new_played}
  in
  give_card aux_p aux_gen
  else if cards_equal c top then 
  let new_hand, aux_gen = take_from_deck aux_hand general in
  let aux_p = 
    {name = p.name; points = p.points;
     cards = new_hand; played = new_played}
  in
  give_card aux_p aux_gen
  else if cards_equal c max then
  let new_hand, aux_gen = take_max_card aux_hand general in
  let aux_p = 
    {name = p.name; points = p.points;
     cards = new_hand; played = new_played}
  in
  give_card aux_p aux_gen    
  else if cards_equal c min then
  let new_hand, aux_gen = throw_min_card aux_hand general in
  let aux_p = 
    {name = p.name; points = p.points;
     cards = new_hand; played = new_played}
  in
  give_card aux_p aux_gen
  else (* id *)
  let aux_p = 
    {name = p.name; points = p.points;
     cards = aux_hand; played = new_played}
  in
  give_card aux_p general
;;

(* revisa si el jugador posee la carta 'c' *)
let valid_player_card (c:card) (p:player) =  
  deck_has_card c p.cards
;;

(* Devuelve el mejor jugador entre dos *)
let top_player (p:player) (q:player) =
  if p.points > q.points then p else q
;;

(* Funcion auxiliar para imprimir las posiciones*)
let player_order (p:player) (q:player)=
  if p.points = q.points then 0 
  else if p.points > q.points then 1
  else -1
;;

(* Devuelve si el jugador posee cartas *)
let has_cards (p:player) =
  if deck_size p.cards = 0 then false else true
;;

(* Imprime el jugador con sus datos *)
let print_player_position (p:player) (a:int) =
  print_int a; print_string "   "; print_string p.name;
  print_string "   "; print_int p.points; print_newline();
;;

let players_equal (p:player) (o:player) =
  p.name = o.name && decks_equal p.cards o.cards
;;

(* Imprime los datos del jugador*)
let print_player (p:player) =
  print_string p.name;
  print_char '(';
  print_int p.points;
  print_char ')';
  print_string ": ";
  print_deck p.cards
;;

let print_player_name (p:player) =
  print_string p.name
;;

let reset_player (p:player) =
  {name = p.name; points = p.points; cards = p.cards; played = empty_deck}
;;

let print_player_played (p:player) =
  if decks_equal p.played empty_deck then ()
  else (print_string p.name;
        print_string "  ";
        print_deck p.played)
;;
