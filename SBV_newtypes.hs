{-# LANGUAGE PackageImports #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Main where

import "base"         GHC.Generics  (Generic)
import "base"         Data.Data (Data)
import "base"         Data.Typeable (Typeable)
import "sbv"          Data.SBV

newtype Metres = Metres Integer
    deriving (Num, Real, Enum, Bits, Integral, Show, Read, Eq, Ord, Data, Typeable, Generic)

deriving instance SymVal Metres
deriving instance HasKind Metres
deriving instance SIntegral Metres
deriving instance SatModel Metres
deriving instance IEEEFloatConvertible Metres

type SMetres  = SBV Metres

formula :: Symbolic SBool
formula = do
    x :: SInteger <- exists "x"
    y :: SInteger <- exists "y"
    w :: SMetres <- exists "length"
    constrain $ x .< (literal 13)
    constrain $ w .< (literal $ Metres 13)
    return $ (literal 3) * x + 4 * y .== (literal 0)

main :: IO ()
main = do
    print . map (name . solver) =<< sbvAvailableSolvers
    result <- sat formula
    print result
