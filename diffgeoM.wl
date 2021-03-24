#!/usr/bin/env wolframscript
(* ::Package:: *)
(* For an up-to-date version, go to:
    https://github.com/bryango/diffgeoM
*)


(* ::Section:: *)
(* Clean up symbols *)

(*
Unprotect["`diffgeo`*"];
ClearAll["`diffgeo`*"];

`diffgeo`preContext = Context[];
 *)

"# system symbols and functions";
symbols = Hold[{

    \[DoubleStruckD],
    Wedge, Del,

    dn

}]  // Map[HoldForm, #, {2}] & \
    // ReleaseHold \
    // Map[ToString];

Unprotect /@ symbols;
ClearAll /@ symbols;


(* ::Section:: *)
(* Renamed symbols *)

renames = Hold[{

        g -> metric,
        gInv -> inverse,
        dim -> dimen,
        vol -> rg,

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


(* ::Section:: *)
(* Pass initial values *)

(*
"# pre-define differential form symbol";
`diffgeo`\[DoubleStruckD] = \[DoubleStruckD];

"# import vars from previous context";
`diffgeo`coord = coord;
`diffgeo`metric = metric;
 *)

"# metricSign is globally defined";
If[ MemberQ[{1, -1}, metricSign],
    (* `diffgeo`metricsign = metricSign; *)
    metricsign = metricSign;
];


(* ::Section:: *)
(* diffgeo in sub-context *)

(*
Begin["`diffgeo`"];

Block[
    { $ContextPath
        = $ContextPath // DeleteCases["Global`"] },
 *)

    Get[
        FileNameJoin[{
            DirectoryName @ $InputFileName,
            "diffgeo.m"
        }]
    ];

(*
];

End[];
 *)


(* ::Section:: *)
(* Personalizations *)

"# See: <https://mathematica.stackexchange.com/a/68872>"
copyDefCmdString[new_String, old_String] := (
    "Language`ExtendedDefinition[" <> new <> "] =" <>
    "Language`ExtendedDefinition[" <> old <> "] /." <>
                    "HoldPattern[" <> old <> "] :>" <> new
);

renames // KeyValueMap[
    copyDefCmdString[#1, #2] &
] // Map[ToExpression];

"# Riemann in Carroll = Wald, ";
"# ... but with different idx ordering:";
"# ... R^u_c_a_b = - R_a_b_c^u";
tRiemann := (
    tRiemann = Transpose[
        - Riemann,
        {3, 4, 2, 1}
    ];
    tRiemann
);

"# avoid unnecessary simplification in covD";
Language`ExtendedDefinition[covD] =
Language`ExtendedDefinition[covD] /. HoldPattern[Simplify] :> Identity

Del := covD;
dn := down;


(* ::Section:: *)
(* Import as-is *)

(*
`diffgeo`symbols = Names["`diffgeo`*"] \
    // Select[
        MemberQ[Attributes[#], Protected] &
    ] \
    // Map[ StringSplit[#, "`"][[-1]] & ] \
    // Complement[#,
        (* Values[renames], *) (* no longer removed, for backward compatibility *)
        {
            "\[DoubleStruckD]"
        }
    ] &;

Unprotect /@ `diffgeo`symbols;
ClearAll /@ `diffgeo`symbols;

`diffgeo`symbols // Map[
    copyDefCmdString[#, #] &
] // Map[ToExpression];
 *)


(* ::Section:: *)
(* Protect symbols *)

Protect /@ symbols;
Protect /@ Keys[renames];
(* Protect /@ `diffgeo`symbols; *)
