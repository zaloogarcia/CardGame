open Jugador
open Cartas

type round = player list

let empty_round = ([]:round)

let player_num (current:round) =
  let fil_ps = List.filter has_cards current in
  List.length fil_ps
;;

(* Builds a list of players *)
let get_players () =
  let init_message =
    "Ingrese el nombre del jugador o EXIT para comenzar el juego:"
  in
  let rec get_players_rec plays n =
    print_endline init_message;
    let inp = read_line () in
    let auxb = (inp = "EXIT") in
    if not auxb then let np = new_player inp in
                     let n = n-1 in
                     if n > 0 then get_players_rec (np :: plays) n
                     else (List.rev (np :: plays))
    else ((List.rev plays):round)
  in
  get_players_rec empty_round 5
;;

let initial_deal (players:round) (general:deck) =
  let rec initial_deal_rec (acc:round) (ps:round) (gen:deck) =
    match ps with
      [] -> (List.rev acc, gen)
    | x :: xs -> let new_x, new_gen = give_seven_cards x gen in
                 initial_deal_rec (new_x :: acc) xs new_gen
  in
  initial_deal_rec [] players general
;;

(* Imprime los datos de la Ronda *)
let print_round (current:round) =
  print_endline "Ronda:";
  let rec print_round_rec (o:round) = 
    match o with
    [] -> ()
    |x :: xs -> print_player_played x;
                print_round_rec xs
  in
  print_round_rec current;
;;

let rec reset_round (current:round) =
  match current with
  [] -> current
  | x::xs -> reset_player x::reset_round xs
;;

let rec print_nth_player (current:round) n =
  match current with
    [] -> ()
  | x :: xs -> match n with
                 0 -> invalid_arg "print_nth_player"
               | 1 -> print_player x
               | _ -> print_nth_player xs (n-1)
;;

let rec print_nth_player_name (current:round) n =
  match current with
    [] -> ()
  | x :: xs -> match n with
                 0 -> invalid_arg "print_nth_player_name"
               | 1 -> print_player_name x
               | _ -> print_nth_player_name xs (n-1)
;;


let rec nth_plays (current:round) (c:card) n =
  match current with
    [] -> current
  | x :: xs -> match n with
                 0 -> invalid_arg "nth_plays"
               | 1 -> (use_card c x) :: xs
               | _ -> x :: (nth_plays xs c (n-1))
;;

let nth_plays_special (current:round) (general:deck) (c:card) n =
  let rec nth_plays_special_rec acc cur gen c n =
    match cur with
      [] -> (acc, gen)
    | x :: xs -> match n with
                   0 -> invalid_arg "nth_plays_special"
                 | 1 -> let new_p, new_gen = use_card_special c x gen in
                        (acc @ (new_p :: xs), new_gen)
                 | _ -> nth_plays_special_rec (x :: acc) xs gen c (n-1)
  in
  nth_plays_special_rec [] current general c n
;;

let give_nth_player_card (current:round) (general:deck) n =
  let rec give_card_rec acc cur gen n =
    match cur with
      [] -> (List.rev acc, gen)
    | x :: xs -> match n with
                   0 -> invalid_arg "give_nth_player_card"
                 | 1 -> let new_play, new_gen = give_card x gen
                        in
                        ((List.rev acc) @ [new_play] @ xs, new_gen)
                 | _ -> give_card_rec (x :: acc) xs gen (n-1)
  in
  give_card_rec [] current general n
;;

let rec valid_nth_player_card (current:round) (c:card) n =
  match current with
    [] -> invalid_arg "valid_nth_player_card"
  | x :: xs -> match n with
                 0 -> invalid_arg "valid_nth_player_card"
               | 1 -> valid_player_card c x
               | _ -> valid_nth_player_card xs c (n-1)
;;

let rec remove_nth_player (current:round) n =
  match current with
    [] -> invalid_arg "remove_nth_player"
  | x :: xs -> match n with
                 0 -> invalid_arg "remove_nth_player"
               | 1 -> xs
               | _ -> x :: remove_nth_player xs (n-1)
;;

let rec nth_has_cards (current:round) n =
  match current with
    [] -> invalid_arg "nth_has_cards"
  | x :: xs -> match n with
                 0 -> invalid_arg "nth_has_cards"
               | 1 -> has_cards x
               | _ -> nth_has_cards xs (n-1)
;;

let rec give_winner_point (current:round) (winner:player) =
  match current with
    [] -> invalid_arg "give_winner_points"
  | x :: xs -> if players_equal winner x then (give_point x) :: xs
               else x :: give_winner_point xs winner
;;

let winner_round (current:round) =
  List.fold_left winner (List.hd current) current
;;

(* Encuentra el mejor jugador en una ronda *)
let rec find_best_player = function
  [] -> invalid_arg "Invalid args find best player"
  | x :: xs -> List.fold_left top_player x xs
;;

(* Imprime todas las posiciones de una ronda *)
let print_positions (r:round) =
  print_string "GAME OVER. Posiciones:";
  print_newline();
  let rec print_all_position (r:round) (a:int) =
    match r with
    [] -> ()
    | x::xs -> print_player_position x a;
               print_all_position xs (a+1)     
  in
  let sort_players (r:round) = List.rev (List.sort player_order r) in
  print_all_position (sort_players r) 1
;;

let print_round_message (current:round) (general:deck) n =
  print_newline ();
  print_string "Mazo: ";
  print_int (deck_size general);
  print_endline " cartas";
  print_round current;
  print_nth_player current n;
  print_string "Que carta vas a jugar ";
  print_nth_player_name current n;
  print_endline "?";
;;

let play_round (players:round) (general:deck) =
  let rec play_round_rec r gen n =
    let len = (List.length r)+1 in
    if n < len then
    (match r with
       [] -> invalid_arg "play_round_rec"
     | _ -> if nth_has_cards r n then
            (print_round_message r gen n;
             let inp = read_line () in
             let aux_c = string_to_card inp in
             if deck_size aux_c > 0 then
             (let c = max_card aux_c in
              if valid_nth_player_card r c n then
              (if is_normal c then
               (let aux_r = nth_plays r c n in
                let new_r, new_gen = give_nth_player_card aux_r gen n in
                if nth_has_cards new_r n then
                play_round_rec new_r new_gen (n+1)
                else
                (print_string "El jugador ";
                 print_nth_player_name r n;
                 print_endline " ya no tiene cartas.";
                 play_round_rec new_r new_gen (n+1))
               )
               else
               let new_r, new_gen = nth_plays_special r gen c n in
               play_round_rec new_r new_gen n
              )
              else
              (print_endline "No tiene esa carta...";
               play_round_rec r gen n)
             )
             else play_round_rec r gen n
            )
            else
            play_round_rec r gen (n+1)
    )
    else
    (let winner = winner_round r in
     let new_ps = give_winner_point r winner in
     print_string "El jugador ";
     print_player_name winner;
     print_endline " gano la ronda.";
     (reset_round new_ps, gen))
  in play_round_rec players general 1
;;
