        OCaml version 4.02.0

val list_sigma : int list -> int = <fun>

val mem : 'a -> 'a list -> bool = <fun>

- : bool = true

val map2 : ('a -> 'b) -> 'a list -> 'b list = <fun>

val x : int list = [3; 4; 5]

val liste_min : 'a list -> 'a = <fun>

- : int = -30

val is_sorted : 'a list -> bool = <fun>

- : bool = true

# let rec append u v = match u with | x::w -> x::(append w v);;

Warning 8: this pattern-matching is not exhaustive.

Here is an example of a value that is not matched:

[]

val append : 'a list -> 'b -> 'a list = <fun>

Exception: Match_failure ("//toplevel//", 1, 21).

val inverse : 'a list -> 'a list = <fun>

Exception: Match_failure ("//toplevel//", 1, 21).

val inverse : 'a list -> 'a list = <fun>

val flatten : 'a list list -> 'a list = <fun>

Exception: Match_failure ("//toplevel//", 1, 21).

# let rotation_d u = match u with | []->[] | x::[]->u | x::q -> match (inverse q) with y :: p -> y::q@[x];;

Warning 8: this pattern-matching is not exhaustive.

Here is an example of a value that is not matched:

[]

val rotation_d : 'a list -> 'a list = <fun>

- : int list = [5; 2; 3; 4; 5; 1]

val moyenne : int list -> int = <fun>

- : int = 3

val insert : 'a -> 'a list -> 'a list = <fun>

- : int list = [1; 3; 5; 8]

- : int list = [1; 3; 5; 6]

val sort : 'a list -> 'a list = <fun>

- : int list = [1; 2; 3; 5; 6; 8; 12]

- : int list = [5; 4; 3; 2; 1]

- : int = 13

val mem_sorted : 'a -> 'a list -> bool = <fun>

val union_sorted : 'a list -> 'a list -> 'a list = <fun>

- : int list = [1; 2; 3; 5; 7; 9; 10; 11]

val inter_sorted : 'a list -> 'a list -> 'a list = <fun>

- : int list = [5]



