        OCaml version 4.01.0

type arbre =
    Feuille of int
  | Noeud of (int * arbre * arbre)
  | NoeudG of (int * arbre)
  | NoeudD of (int * arbre)
val taille : arbre -> int = <fun>
[A[A[A[A[A[A# 
  let valeur = function
  | Feuille(a) -> [4maHello[24m World
  | Noeud(a,_,_) -> a
  | NoeudG(a,_) -> a
  | NoeudD(a,_) -> a ;;
[24mError: Unbound value aHello
[A[A[A[A[A[A[A# 
  
  let rec tas = function
  | Feuille(_)-> true
  | Noeud(e,g,d) -> if e >= ([4mvaleur[24m g) + (valeur d) then (tas g && tas d) else false
  | NoeudG(e,g) -> if e >= (valeur g) then tas g else false
  | NoeudD(e,d) -> false ;;
[24mError: Unbound value valeur

