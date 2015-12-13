{-# LANGUAGE CPP #-}

{-|
Module:      Spec.Derived.DataFamiliesSpec
Copyright:   (C) 2014-2015 Ryan Scott
License:     BSD-style (see the file LICENSE)
Maintainer:  Ryan Scott
Stability:   Provisional
Portability: GHC

@hspec@ tests for corner case-provoking data families.
-}
module Spec.Derived.DataFamiliesSpec (main, spec) where

import Prelude ()
import Prelude.Compat

import Test.Hspec (Spec, hspec, parallel)

#if MIN_VERSION_template_haskell(2,7,0)
import Derived.DataFamilies (NotAllShow)

import Spec.Utils (prop_matchesTextShow2, prop_genericTextShow, prop_genericTextShow1)

import Test.Hspec (describe)
import Test.Hspec.QuickCheck (prop)

# if __GLASGOW_HASKELL__ >= 708
import Derived.DataFamilies (NullaryData)
import Spec.Utils (prop_matchesTextShow)
# endif
#endif

main :: IO ()
main = hspec spec

spec :: Spec
spec = parallel $ do
#if MIN_VERSION_template_haskell(2,7,0)
    describe "NotAllShow Int Int Int Int" $ do
        prop "TextShow2 instance" (prop_matchesTextShow2 :: Int -> NotAllShow Int Int Int Int -> Bool)
        prop "generic TextShow"   (prop_genericTextShow  :: Int -> NotAllShow Int Int Int Int -> Bool)
        prop "generic TextShow1"  (prop_genericTextShow1 :: Int -> NotAllShow Int Int Int Int -> Bool)
# if __GLASGOW_HASKELL__ >= 708
    describe "NullaryData" $ do
        prop "TextShow instance"  (prop_matchesTextShow  :: Int -> NullaryData -> Bool)
        prop "generic TextShow"   (prop_genericTextShow  :: Int -> NullaryData -> Bool)
# endif
#else
    pure ()
#endif