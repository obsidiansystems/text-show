{-# OPTIONS_GHC -fno-warn-orphans #-}

{-|
Module:      Instances.Data.Dynamic
Copyright:   (C) 2014-2015 Ryan Scott
License:     BSD-style (see the file LICENSE)
Maintainer:  Ryan Scott
Stability:   Experimental
Portability: GHC

'Arbitrary' instance for 'Dynamic'.
-}
module Instances.Data.Dynamic () where

import Data.Dynamic (Dynamic, toDyn)
import Test.QuickCheck (Arbitrary(..), Gen)

instance Arbitrary Dynamic where
    arbitrary = toDyn <$> (arbitrary :: Gen Int)