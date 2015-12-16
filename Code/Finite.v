(* https://coq.inria.fr/stdlib/Coq.Sets.Finite_sets.html *)

Require Import Ensembles.

Section Ensembles_finis.
  Variable U : Type.

  Inductive Finite : Ensemble U -> Prop :=
    | Empty_is_finite : Finite (Empty_set U)
    | Union_is_finite :
      forall A:Ensemble U,
        Finite A -> forall x:U, ~ In U A x -> Finite (Add U A x).

  Inductive cardinal : Ensemble U -> nat -> Prop :=
    | card_empty : cardinal (Empty_set U) 0
    | card_add :
      forall (A:Ensemble U) (n:nat),
        cardinal A n -> forall x:U, ~ In U A x -> cardinal (Add U A x) (S n).

End Ensembles_finis.

Hint Resolve Empty_is_finite Union_is_finite: sets v62.
Hint Resolve card_empty card_add: sets v62.

Require Import Constructive_sets.

Section Ensembles_finis_facts.
  Variable U : Type.

(* noch zu beweisen: *)
  Lemma cardinal_invert :
    forall (X:Ensemble U) (p:nat),
      cardinal U X p ->
      match p with
        | O => X = Empty_set U
        | S n =>
          exists A : _,
            (exists x : _, X = Add U A x /\ ~ In U A x /\ cardinal U A n)
      end.

  Lemma cardinal_elim :
    forall (X:Ensemble U) (p:nat),
      cardinal U X p ->
      match p with
        | O => X = Empty_set U
        | S n => Inhabited U X
      end.

End Ensembles_finis_facts.