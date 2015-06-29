{-# LANGUAGE CPP                        #-}
{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

#if __GLASGOW_HASKELL__ >= 702
{-# LANGUAGE DeriveGeneric              #-}
#endif

{-# OPTIONS_GHC -fno-warn-orphans #-}

{-|
Module:      Derived.TypeSynonyms
Copyright:   (C) 2014-2015 Ryan Scott
License:     BSD-style (see the file LICENSE)
Maintainer:  Ryan Scott
Stability:   Provisional
Portability: GHC

Defines data types that use type synonyms.
-}
module Derived.TypeSynonyms (TyCon(..), TyFamily(..)) where

#include "generic.h"

#if __GLASGOW_HASKELL__ >= 702
import GHC.Generics (Generic)
# if defined(__LANGUAGE_DERIVE_GENERIC1__)
import GHC.Generics (Generic1)
# endif
#endif

import Prelude hiding (Show(..))

import Test.QuickCheck (Arbitrary)

import Text.Show as S (Show(..))
import Text.Show.Text.TH (deriveShow, deriveShow1, deriveShow2)

import TransformersCompat as S (Show1(..), Show2(..), showsUnaryWith)

-------------------------------------------------------------------------------

type FakeOut a = Int
type Id a = a
type Flip f a b = f b a

deriving instance Functor ((,,,) a b c) -- Needed for the Generic1 instances
instance (S.Show a, S.Show b) => S.Show2 ((,,,) a b) where
    showsPrecWith2 sp1 sp2 _ (a, b, c, d) =
                          showChar '('
        . showsPrec 0 a . showChar ','
        . showsPrec 0 b . showChar ','
        . sp1       0 c . showChar ','
        . sp2       0 d . showChar ')'

-------------------------------------------------------------------------------

newtype TyCon a b = TyCon
    ( Id (FakeOut (Id a))
    , Id (FakeOut (Id b))
    , Id (Flip Either (Id a) (Id Int))
    , Id (Flip Either (Id b) (Id a))
    )
  deriving ( Arbitrary
           , S.Show
#if __GLASGOW_HASKELL__ >= 702
           , Generic
# if defined(__LANGUAGE_DERIVE_GENERIC1__)
           , Generic1
# endif
#endif
           )

-------------------------------------------------------------------------------

data family TyFamily
#if __GLASGOW_HASKELL__ >= 708 && __GLASGOW_HASKELL__ < 710
                     a b :: *
#else
                     y z :: *
#endif

newtype instance TyFamily a b = TyFamily
    ( Id (FakeOut (Id a))
    , Id (FakeOut (Id b))
    , Id (Flip Either (Id a) (Id Int))
    , Id (Flip Either (Id b) (Id a))
    )
  deriving ( Arbitrary
           , S.Show
#if __GLASGOW_HASKELL__ >= 702
           , Generic
# if defined(__LANGUAGE_DERIVE_GENERIC1__)
           , Generic1
# endif
#endif
           )

-------------------------------------------------------------------------------

instance S.Show a => S.Show1 (TyCon a) where
    showsPrecWith = showsPrecWith2 showsPrec
instance S.Show2 TyCon where
    showsPrecWith2 sp1 sp2 p (TyCon x) =
        showsUnaryWith (showsPrecWith2 (showsPrecWith2 showsPrec sp1)
                                       (showsPrecWith2 sp1       sp2)
                       ) "TyCon" p x

instance S.Show a => S.Show1 (TyFamily a) where
    showsPrecWith = showsPrecWith2 showsPrec
instance S.Show2 TyFamily where
    showsPrecWith2 sp1 sp2 p (TyFamily x) =
        showsUnaryWith (showsPrecWith2 (showsPrecWith2 showsPrec sp1)
                                       (showsPrecWith2 sp1       sp2)
                       ) "TyFamily" p x

-------------------------------------------------------------------------------

$(deriveShow  ''TyCon)
$(deriveShow1 ''TyCon)
$(deriveShow2 ''TyCon)

#if MIN_VERSION_template_haskell(2,7,0)
$(deriveShow  'TyFamily)
$(deriveShow1 'TyFamily)
$(deriveShow2 'TyFamily)
#endif
