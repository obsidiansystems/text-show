{-# LANGUAGE CPP                        #-}
{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

{-|
Module:      Derived.TypeSynonyms
Copyright:   (C) 2014-2017 Ryan Scott
License:     BSD-style (see the file LICENSE)
Maintainer:  Ryan Scott
Stability:   Provisional
Portability: GHC

Defines data types that use type synonyms.
-}
module Derived.TypeSynonyms (TyCon(..), TyFamily(..)) where

import           Data.Orphans ()

import qualified Generics.Deriving.TH as Generics

import           GHC.Generics (Generic)

import           Prelude

import           Test.QuickCheck (Arbitrary)

import           Text.Show.Deriving (deriveShow1)
#if defined(NEW_FUNCTOR_CLASSES)
import           Text.Show.Deriving (deriveShow2)
#endif

import           TextShow.TH (deriveTextShow, deriveTextShow1, deriveTextShow2)

-------------------------------------------------------------------------------

type FakeOut a = Int
type Id a = a
type Flip f a b = f b a

-------------------------------------------------------------------------------

newtype TyCon a b = TyCon
    ( Id (FakeOut (Id a))
    , Id (FakeOut (Id b))
    , Id (Flip Either (Id a) (Id Int))
    , Id (Flip Either (Id b) (Id a))
    )
  deriving ( Arbitrary
           , Show
           , Generic
           )

-------------------------------------------------------------------------------

data family TyFamily y z :: *

newtype instance TyFamily a b = TyFamily
    ( Id (FakeOut (Id a))
    , Id (FakeOut (Id b))
    , Id (Flip Either (Id a) (Id Int))
    , Id (Flip Either (Id b) (Id a))
    )
  deriving ( Arbitrary
           , Show
           , Generic
           )

-------------------------------------------------------------------------------

#if !(MIN_VERSION_base(4,9,0))
-- TODO: Delete this code once we depend on transformers-compat-0.7.1 as the
-- minimum
# if !(MIN_VERSION_transformers_compat(0,7,1))
$(deriveShow1 ''(,,,))
#  if defined(NEW_FUNCTOR_CLASSES)
$(deriveShow2 ''(,,,))
#  endif
# endif
#endif

$(deriveShow1 ''TyCon)
#if defined(NEW_FUNCTOR_CLASSES)
$(deriveShow2 ''TyCon)
#endif

$(deriveTextShow  ''TyCon)
$(deriveTextShow1 ''TyCon)
$(deriveTextShow2 ''TyCon)

$(Generics.deriveMeta           ''TyCon)
$(Generics.deriveRepresentable1 ''TyCon)

#if !defined(NEW_FUNCTOR_CLASSES)
$(deriveShow1 'TyFamily)
#else
$(deriveShow1 'TyFamily)
$(deriveShow2 'TyFamily)
#endif

$(deriveTextShow  'TyFamily)
$(deriveTextShow1 'TyFamily)
$(deriveTextShow2 'TyFamily)

$(Generics.deriveMeta           'TyFamily)
$(Generics.deriveRepresentable1 'TyFamily)
