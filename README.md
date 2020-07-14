# diffgeoM

This package aims to extend the famous general relativity toolkit  `diffgeo.m` by [Matthew Headrick](http://people.brandeis.edu/~headrick/Mathematica).

The original `diffgeo.m` is very well designed, with a minimalistic code base (only ~600 lines of core code) while being fairly robust. Therefore, this project tries not to modify its core code, but rather builds around it, with personalized extensions inspired by similar packages, such as [MathGR](https://github.com/tririver/MathGR) and [ccgrg](http://library.wolfram.com/infocenter/MathSource/8848).

The wrapper script `diffgeoM.wl` calls the main package `diffgeo.m`, and perform various modifications. Symbols are renamed for personal convenience, while the original symbols remain accessible under the `` `Private` `` context.

## License

- `diffgeo.m` and `diffgeoManual.nb` are retrieved from http://people.brandeis.edu/~headrick/Mathematica. All rights belong to the original author, Matthew Headrick.

- All other code, including `diffgeoM.wl`, is licensed under GPLv3.
