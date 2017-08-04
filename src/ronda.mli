open Jugador
open Cartas

type round

val get_players : unit -> round;;
val print_round : round -> unit;;
val reset_round : round -> round;;
val initial_deal : round -> deck -> (round*deck);;
val play_round : round -> deck -> (round*deck);;
val player_num : round -> int;;
val print_positions : round -> unit;;
