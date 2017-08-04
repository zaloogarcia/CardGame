open Cartas
open Jugador
open Ronda

let rec game_rec (players:round) (general:deck) =
  let new_ps, new_gen = play_round players general in
  if player_num new_ps > 1 then game_rec new_ps new_gen
  else print_positions new_ps
;;

let _ =
  let round = get_players () in
  let general = shuffle full_deck in
  let players, aux_gen = initial_deal round general in
  game_rec players aux_gen
