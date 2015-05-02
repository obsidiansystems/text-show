{-# LANGUAGE CPP #-}

{-|
Module:      Spec.Data.OldTypeableSpec
Copyright:   (C) 2014-2015 Ryan Scott
License:     BSD-style (see the file LICENSE)
Maintainer:  Ryan Scott
Stability:   Experimental
Portability: GHC

@hspec@ tests for data types in the "Data.Monoid" module.
-}
module Spec.Data.OldTypeableSpec (main, spec) where

import Instances.Data.OldTypeable ()

import Prelude ()
import Prelude.Compat

import Test.Hspec (Spec, hspec, parallel)

#if MIN_VERSION_base(4,7,0) && !(MIN_VERSION_base(4,8,0))
import Data.OldTypeable (TyCon, TypeRep)

import Spec.Utils (prop_matchesShow)

import Test.Hspec (describe)
import Test.Hspec (prop)
#endif

main :: IO ()
main = hspec spec

spec :: Spec
spec = parallel $
#if MIN_VERSION_base(4,7,0) && !(MIN_VERSION_base(4,8,0))
    describe "Text.Show.Text.Data.OldTypeable" $ do
        prop "TypeRep instance" (prop_matchesShow :: Int -> TypeRep -> Bool)
        prop "TyCon instance"   (prop_matchesShow :: Int -> TyCon -> Bool)
#else
    pure ()
#endif