(** Basic types **)
type deck
type card

(** Full deck and empty deck constants and function to shuffle **)
val full_deck : deck;;
val empty_deck : deck;;
val id : card;;
val top : card;;
val swap : card;;
val min : card;;
val max : card;;
val par : card;;
val shuffle : deck -> deck;;

(** General functions for standard card play **)
val take_from_deck : deck -> deck -> (deck*deck);;
val take : int -> deck -> (deck*deck);;
val deal_hand : deck -> deck -> (deck*deck);;
val deck_has_card : card -> deck -> bool;;
val deck_size : deck -> int;;
val play_card : card -> deck -> deck -> (deck*deck);;
val biggest_card : card -> card -> card;;
val max_card : deck -> card;;
val print_deck : deck -> unit;;
val string_to_card : string -> deck;;
val cards_equal : card -> card -> bool;;
val decks_equal : deck -> deck -> bool;;
val is_normal : card -> bool;;

(** Functions for using special cards **)
val swap_decks : deck -> deck -> (deck*deck);;
val take_evens : deck -> deck -> (deck*deck);;
val throw_min_card : deck -> deck -> (deck*deck);;
val take_max_card : deck -> deck -> (deck*deck);;
