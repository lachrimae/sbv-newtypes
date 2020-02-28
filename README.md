# sbv-newtypes

An example of malfunctioning code. Call `stack --resolver lts-15.1 script --package sbv ./SBV_newtypes.hs` to build and run.

The `main` function first prints the available solvers, then is supposed to exert some simple constraints. These constraints work for the `SInteger` type, but on my machine they create an error with the `SMetres` type. I get some warnings having to do with using both `DeriveAnyClass` and `GeneralizedNewtypeDeriving`, but the automatic resolution of the overlapping cases appears to be working properly. My error output is as below:

```
[Z3]
sbv-newtypes-exe: SBV.SMT.SMTLib2.sh.unintComp: Unexpected arguments: ("<",["s2","s5"],[Metres,Metres])
CallStack (from HasCallStack):
  error, called at ./Data/SBV/SMT/SMTLib2.hs:694:28 in sbv-8.6-3JWHh0xNlESIquVipyNOgx:Data.SBV.SMT.SMTLib2
```
