#!/usr/bin/env wolframscript
(* ::Package:: *)
(* For an up-to-date version, go to:
    https://github.com/bryango/diffgeoM
*)

`Private`preContext = Context[];

(* ::Section:: *)
(* Private diffgeo *)

Begin["`Private`"];

"# import vars from previous context";
coord = ToExpression[preContext <> "coord"];
metric = ToExpression[preContext <> "metric"];

<< diffgeo`
End[];

(* ::Section:: *)
(* Customization *)

dim := `Private`dimen;

zeroTensor := `Private`zeroTensor;
displayTensor := `Private`display;

"# Riemann in Carroll = Wald, ";
"# ... but with different idx ordering:";
"# ... R^u_c_a_b = - R_a_b_c^u"
tRiemann := (
    tRiemann = Transpose[
        - `Private`Riemann,
        {3, 4, 2, 1}
    ];
    tRiemann
);

tRicci := `Private`RicciTensor;
sRicci := `Private`RicciScalar;
