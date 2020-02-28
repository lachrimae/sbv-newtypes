{-# LANGUAGE PackageImports #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
module Main where

import "base"         GHC.Generics  (Generic)
import "base"         Data.Data (Data)
import "base"         Data.Typeable (Typeable)
import "sbv"          Data.SBV
import "sbv-newtypes" Lib (Metres(..))

deriving instance SymVal Metres
deriving instance HasKind Metres
deriving instance SIntegral Metres
deriving instance SatModel Metres
deriving instance IEEEFloatConvertible Metres

--instance IEEEFloatConvertableMetres where
    --fromSFloat = genericFromFloat
    --fromSDouble m sf    = undefined
    --toSFloat m a  = undefined
    --toSDouble m a = undefined

type SMetres  = SBV Metres

formula :: Symbolic SBool
formula = do
    x :: SInteger <- exists "x"
    y :: SInteger <- exists "y"
    w :: SMetres <- exists "length"
    -- Exponents must be unsigned words
    -- Exponents must be unsigned words
    constrain $ x .< (literal 13)
    constrain $ w .< ((literal $ Metres 13) :: SMetres)
    return $ (literal 3) * x + 4 * y .== (literal 0)

main :: IO ()
main = do
    print . map (name . solver) =<< sbvAvailableSolvers
    result <- sat formula
    print result
