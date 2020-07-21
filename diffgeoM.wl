#!/usr/bin/env wolframscript
(* ::Package:: *)
(* For an up-to-date version, go to:
    https://github.com/bryango/diffgeoM
*)


(* ::Section:: *)
(* Clean up symbols *)

Unprotect["`Private`*"];
ClearAll["`Private`*"];

`Private`preContext = Context[];

symbols = Hold[{

    \[DoubleStruckD],
    Wedge, Del

}]  // Map[HoldForm, #, {2}] & \
    // ReleaseHold \
    // Map[ToString];

Unprotect /@ symbols;
ClearAll /@ symbols;


renames = Hold[{

        g -> metric,
        gInv -> inverse,
        dim -> dimen,
        vol -> rg,

        up -> up,
        dn -> down,

        displayTensor -> display,
        formToTensor -> FormToTensor,
        tensorToForm -> TensorToForm,
        nameToNumber -> NameToNumber,

        pD -> partial,
        extD -> exterior,
        lieD -> Lie,
        covD -> covariant,

        pDg -> dg,

        tRicci -> RicciTensor,
        sRicci -> RicciScalar

}]  // Map[HoldForm, #, {3}] & \
    // ReleaseHold \
    // Association \
    // KeyMap[ToString] \
    // Map[ToString];

Unprotect /@ Keys[renames];
ClearAll /@ Keys[renames];


"# pre-define differential form symbol";
`Private`\[DoubleStruckD] = \[DoubleStruckD];

"# import vars from previous context";
`Private`coord = coord;
`Private`metric = metric;

"# metricSign is globally defined";
If[ MemberQ[{1, -1}, metricSign],
    `Private`metricsign = metricSign;
];


(* ::Section:: *)
(* Private diffgeo *)

Begin["`Private`"];

"# run diffgeo.m";
Block[
    { $ContextPath
        = $ContextPath // DeleteCases["Global`"] },

    Get[
        FileNameJoin[{
            DirectoryName @ $InputFileName,
            "diffgeo.m"
        }]
    ];
];

End[];


(* ::Section:: *)
(* Personalizations *)

renames // KeyValueMap[
    #1 <> ":=" <> "`Private`" <> #2 &
] // Map[ToExpression];

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

Del := covD;


(* ::Section:: *)
(* Import as-is *)

`Private`symbols = Names["`Private`*"] \
    // Select[
        MemberQ[Attributes[#], Protected] &
    ];

symbolsLegacy = `Private`symbols \
    // Map[ StringSplit[#, "`"][[-1]] & ] \
    // Complement[#, Values[renames], {
        "\[DoubleStruckD]"
    }] &;

Unprotect /@ symbolsLegacy;
ClearAll /@ symbolsLegacy;

symbolsLegacy // Map[
    # <> ":=" <> "`Private`" <> # &
] // Map[ToExpression];


(* ::Section:: *)
(* Protect symbols *)

Protect /@ symbols;
Protect /@ Keys[renames];
Protect /@ symbolsLegacy;
