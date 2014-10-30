        OCaml version 4.02.1

type arbre =
    Feuille of int
  | Noeud of (int * arbre * arbre)
  | NoeudG of (int * arbre)
  | NoeudD of (int * arbre)
val taille : arbre -> int = <fun>
val valeur : arbre -> int = <fun>
val tas : arbre -> bool = <fun>

