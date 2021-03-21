# diffgeoM

This package aims to extend the famous general relativity toolkit  `diffgeo.m` by [Matthew Headrick](http://people.brandeis.edu/~headrick/Mathematica).

The original `diffgeo.m` is very well designed, with a minimalist code base (only ~600 lines of core code) while being fairly robust. Therefore, this project tries not to modify its core code, but rather builds around it, with personalized symbols inspired by similar packages, such as [MathGR](https://github.com/tririver/MathGR) and [ccgrg](http://library.wolfram.com/infocenter/MathSource/8848).

The wrapper script `diffgeoM.wl` calls the main package `diffgeo.m`, and perform various modifications. Symbols are renamed for personal convenience, while the original symbols remain accessible under the `` `diffgeo` `` context.

## Usage

The usage of `diffgeoM` is very much similar to the original `diffgeo.m`, which is well documented in `diffgeoManual.nb`. The only difference is that there are some new symbols:

- The association between `new -> original` symbols is given in the variable [`renames`](diffgeoM.wl#L33)
- Some other extended symbols are defined in [this section](diffgeoM.wl#L117).

The initial input of `diffgeoM` is `coord`, `metric`, and optionally, `metricSign` (note the captital S in `Sign`; this is a rename of the original `metricsign` in `diffgeo.m`).

- It is recommended to run `diffgeoM` (or even the original `diffgeo.m`) in a special Mathematica "Context", especially when there are multiple coordinate systems involved.

- When there are multiple contexts, it is recommended to re-run `diffgeoM` before tensor calculations, to ensure that `` System` `` functions are correctly defined.

For example,

```Mathematica
metricSign = -1;

"# Define bulk coordinates outside the bulk` context";
bulk`coord = {t, r, \[Phi]};
"# ... in this way, the symbols: t, r and \[Phi]";
"# ... are Global`ly available";

"# Entering the bulk` context";
Begin["bulk`"];

"# Define bulk metric";
metric = ...;

"# Call diffgeoM";
<< diffgeoM`

"# Exiting the bulk` context";
End[];


"### Now we want to switch to another geometry";
"# Entering the boundary` context";
Begin["boundary`"];

coord = {r, \[Phi]};
metric = ...;
<< diffgeoM`

"# Exiting the boundary` context";
End[];

"# Ricci tensors";
bulk`tRicci // MatrixForm
boundary`tRicci // MatrixForm
```

## License

- `diffgeo.m` and `diffgeoManual.nb` are retrieved from:
  > http://people.brandeis.edu/~headrick/Mathematica <br/>
  > All rights belong to the original author, Matthew Headrick.

- All other code, including `diffgeoM.wl`, is licensed under GPLv3.
