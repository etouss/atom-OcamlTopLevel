        OCaml version 4.02.0

type 'a bit_channel = { chan : 'a; mutable byte : int; mutable len : int; }
type bit_in_channel = in_channel bit_channel
type bit_out_channel = out_channel bit_channel
val open_in_bit : string -> in_channel bit_channel = <fun>
val open_out_bit : string -> out_channel bit_channel = <fun>
val input_bit : in_channel bit_channel -> int = <fun>
val input_bit_byte : in_channel bit_channel -> int = <fun>
val input_align_bit : in_channel bit_channel -> unit = <fun>
val output_bit : out_channel bit_channel -> int -> unit = <fun>
val output_bit_byte : out_channel bit_channel -> int -> unit = <fun>
val output_align_bit : out_channel bit_channel -> unit = <fun>
val close_in_bit : in_channel bit_channel -> unit = <fun>
val close_out_bit : out_channel bit_channel -> unit = <fun>
type 'a tree = Feuille of 'a | Node of int * 'a tree * 'a tree
val freqDirFile :
  string -> ('a * int) array -> string list -> ('a * int) array * string list =
  <fun>
val min : ('a * int) tree -> ('a * int) tree -> ('a * int) tree = <fun>
val somme : ('a * int) tree -> ('b * int) tree -> int = <fun>
val freq : string -> (int * int) array = <fun>
val reduc : (int * int) array -> (int * int) tree array = <fun>
val entasserMin :
  ('a * int) tree array -> int -> int -> ('a * int) tree array = <fun>
val extractionMin : ('a * int) tree array -> int -> ('a * int) tree = <fun>
val extractionMin2 : 'a array -> int -> 'a = <fun>
val creerTas : ('a * int) tree array -> ('a * int) tree array = <fun>
val hauffMan : ('a * int) tree array -> ('a * int) tree = <fun>
val creaEncode : (int * 'a) tree -> int list array = <fun>
val ecrire : out_channel bit_channel -> int list array -> int -> unit = <fun>
val encode : string -> int list array -> out_channel bit_channel -> unit =
  <fun>
val representation_arbre : (int * 'a) tree -> out_channel bit_channel -> unit =
  <fun>
val final_encode : string -> unit = <fun>
val rename : string -> string = <fun>
val decode : string -> in_channel bit_channel -> (int * 'a) tree -> unit =
  <fun>
val getArbre : in_channel bit_channel -> (int * int) tree = <fun>
val magiqueCheck : in_channel bit_channel -> bool = <fun>
val ignoreDecode : in_channel bit_channel -> int -> unit = <fun>
val fullDecode : string -> unit = <fun>
val print_list : string list -> unit = <fun>
val get_files_names : in_channel bit_channel -> int -> string list = <fun>
val decode_dir :
  string list -> (int * 'a) tree -> in_channel bit_channel -> unit = <fun>
val real_decode_dir : string -> unit = <fun>
Exception:
Sys_error
 "/media/data/git/ProjetL3/PF5/Projet/Didel/Bibliotheque_bitio/Dossier_test/grosDoss.hf: No such file or directory".
val decode : bool ref = {contents = false}
val run : string -> unit = <fun>
val main : unit = ()

