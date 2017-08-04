open Cartas

(** Basic types **)
type player

(** Player Functions **)
val new_player : string -> player;;
val give_card : player -> deck -> (player*deck);;
val give_seven_cards : player -> deck -> (player*deck);;
val give_point : player -> player
val use_card : card -> player -> player;;
val use_card_special : card -> player -> deck -> (player*deck);;
val valid_player_card : card -> player -> bool;;
val has_cards : player -> bool;;
val players_equal : player -> player -> bool;;
val top_player : player -> player -> player;;
val player_order : player -> player -> int;;
val winner : player -> player -> player;;
val print_player : player -> unit;;
val print_player_name : player -> unit;;
val print_player_played : player -> unit;;
val print_player_position : player -> int -> unit
val reset_player : player -> player;;
