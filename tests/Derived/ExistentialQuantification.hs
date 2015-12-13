{-# LANGUAGE CPP                       #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE GADTs                     #-}
{-# LANGUAGE StandaloneDeriving        #-}
{-# LANGUAGE TemplateHaskell           #-}
{-# LANGUAGE TypeFamilies              #-}

{-|
Module:      Derived.ExistentialQuantification
Copyright:   (C) 2014-2015 Ryan Scott
License:     BSD-style (see the file LICENSE)
Maintainer:  Ryan Scott
Stability:   Provisional
Portability: GHC

Defines data types with existentially quantified type variables.
-}
module Derived.ExistentialQuantification (TyCon(..), TyFamily(..)) where

import GHC.Show (appPrec, appPrec1, showSpace)

import Prelude ()
import Prelude.Compat

import Test.QuickCheck (Arbitrary(..), Gen, oneof)

import TextShow (TextShow)
import TextShow.TH (deriveTextShow, deriveTextShow1, deriveTextShow2)

import TransformersCompat (Show1(..), Show2(..), showsBinaryWith)

-------------------------------------------------------------------------------

data TyCon a b c d where
    TyConClassConstraints    :: (Ord m, Ord n, Ord o, Ord p)
                             => m -> n -> o -> p
                             -> TyCon m n o p

    TyConEqualityConstraints :: (e ~ g, f ~ h, e ~ f)
                                => e -> f -> g -> h
                             -> TyCon e f g h

    TyConTypeRefinement      :: Int -> z
                             -> TyCon Int z Int z

    TyConForalls             :: forall p q r s t u.
                                (Arbitrary p, Show p, TextShow p,
                                 Arbitrary q, Show q, TextShow q)
                             => p -> q -> u -> t
                             -> TyCon r s t u

-------------------------------------------------------------------------------

data family TyFamily
#if __GLASGOW_HASKELL__ >= 708 && __GLASGOW_HASKELL__ < 710
    a b c d :: *
#else
    w x y z :: *
#endif

data instance TyFamily a b c d where
    TyFamilyClassConstraints    :: (Ord m, Ord n, Ord o, Ord p)
                                => m -> n -> o -> p
                                -> TyFamily m n o p

    TyFamilyEqualityConstraints :: (e ~ g, f ~ h, e ~ f)
                                => e -> f -> g -> h
                                -> TyFamily e f g h

    TyFamilyTypeRefinement      :: Int -> z
                                -> TyFamily Int z Int z

    TyFamilyForalls             :: forall p q r s t u.
                                   (Arbitrary p, Show p, TextShow p,
                                    Arbitrary q, Show q, TextShow q)
                                => p -> q -> u -> t
                                -> TyFamily r s t u

-------------------------------------------------------------------------------

instance (a ~ Int, b ~ Int, c ~ Int, d ~ Int) => Arbitrary (TyCon a b c d) where
    arbitrary = oneof [ TyConClassConstraints    <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary
                      , TyConEqualityConstraints <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary
                      , TyConTypeRefinement      <$> arbitrary <*> arbitrary
                      , TyConForalls             <$> (arbitrary :: Gen Int) <*> (arbitrary :: Gen Int)
                                                 <*> arbitrary              <*> arbitrary
                      ]

instance (a ~ Int, b ~ Int, c ~ Int, d ~ Int) => Arbitrary (TyFamily a b c d) where
    arbitrary = oneof [ TyFamilyClassConstraints    <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary
                      , TyFamilyEqualityConstraints <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary
                      , TyFamilyTypeRefinement      <$> arbitrary <*> arbitrary
                      , TyFamilyForalls             <$> (arbitrary :: Gen Int) <*> (arbitrary :: Gen Int)
                                                    <*> arbitrary              <*> arbitrary
                      ]

-------------------------------------------------------------------------------

deriving instance (Show a, Show b, Show c, Show d) => Show (TyCon a b c d)
instance (Show a, Show b, Show c) => Show1 (TyCon a b c) where
    showsPrecWith = showsPrecWith2 showsPrec
instance (Show a, Show b) => Show2 (TyCon a b) where
    showsPrecWith2 sp1 sp2 p (TyConClassConstraints a b c d) =
        showsFour sp1 sp2 "TyConClassConstraints" p a b c d
    showsPrecWith2 sp1 sp2 p (TyConEqualityConstraints a b c d) =
        showsFour sp1 sp2 "TyConEqualityConstraints" p a b c d
    showsPrecWith2 _   sp2 p (TyConTypeRefinement i d) =
        showsBinaryWith showsPrec sp2 "TyConTypeRefinement" p i d
    showsPrecWith2 sp1 sp2 p (TyConForalls p' q d c) =
        showsFour sp2 sp1 "TyConForalls" p p' q d c

deriving instance (Show a, Show b, Show c, Show d) => Show (TyFamily a b c d)
instance (Show a, Show b, Show c) => Show1 (TyFamily a b c) where
    showsPrecWith = showsPrecWith2 showsPrec
instance (Show a, Show b) => Show2 (TyFamily a b) where
    showsPrecWith2 sp1 sp2 p (TyFamilyClassConstraints a b c d) =
        showsFour sp1 sp2 "TyFamilyClassConstraints" p a b c d
    showsPrecWith2 sp1 sp2 p (TyFamilyEqualityConstraints a b c d) =
        showsFour sp1 sp2 "TyFamilyEqualityConstraints" p a b c d
    showsPrecWith2 _ sp2 p (TyFamilyTypeRefinement i d) =
        showsBinaryWith showsPrec sp2 "TyFamilyTypeRefinement" p i d
    showsPrecWith2 sp1 sp2 p (TyFamilyForalls p' q d c) =
        showsFour sp2 sp1 "TyFamilyForalls" p p' q d c

showsFour :: (Show a, Show b)
          => (Int -> c -> ShowS) -> (Int -> d -> ShowS)
          -> String -> Int -> a -> b -> c -> d -> ShowS
showsFour sp1 sp2 name p a b c d = showParen (p > appPrec) $
      showString name      . showSpace
    . showsPrec appPrec1 a . showSpace
    . showsPrec appPrec1 b . showSpace
    . sp1 appPrec1 c       . showSpace
    . sp2 appPrec1 d

-------------------------------------------------------------------------------

$(deriveTextShow  ''TyCon)
$(deriveTextShow1 ''TyCon)
$(deriveTextShow2 ''TyCon)

#if MIN_VERSION_template_haskell(2,7,0)
$(deriveTextShow  'TyFamilyClassConstraints)
$(deriveTextShow1 'TyFamilyEqualityConstraints)
$(deriveTextShow2 'TyFamilyTypeRefinement)
#endif