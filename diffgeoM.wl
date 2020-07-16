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
{
    coord, metric
} = ToExpression[preContext <> #] & /@ {
    "coord", "metric"
};

"# the sane metric convention";
metricsign = -1;

"# run diffgeo.m";
Get[
    FileNameJoin[{
        DirectoryName @ $InputFileName,
        "diffgeo.m"
    }]
];

End[];


(* ::Section:: *)
(* Clean up symbols *)

"# see MathUtils > holdItems";
symbols = ToString /@ ReleaseHold[
    MapAt[HoldForm, Hold[{

        g, gInv, dim, vol

    }], {All, All}]
];

Unprotect /@ symbols;
(* Remove /@ symbols; *)


(* ::Section:: *)
(* Personalizations *)

g := `Private`metric;
gInv := `Private`inverse;
dim := `Private`dimen;
vol := `Private`rg;

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

pD := `Private`partial;
lieD := `Private`Lie;
covD := `Private`covariant;
Del := covD;

up := `Private`up;
dn := `Private`down;

formToTensor := `Private`FormToTensor;
tensorToForm := `Private`TensorToForm;
nameToNumber := `Private`NameToNumber;


(* ::Section:: *)
(* Import as-is *)

scalarQ := `Private`scalarQ;
zeroTensor := `Private`zeroTensor;
contract := `Private`contract;

raise := `Private`raise;
lower := `Private`lower;

antisymmetrize := `Private`antisymmetrize;
symmetrize := `Private`symmetrize;

(* ::Section:: *)
(* Protect symbols *)

Protect /@ symbols;
