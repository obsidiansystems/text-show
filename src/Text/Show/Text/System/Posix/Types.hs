{-# LANGUAGE CPP, GeneralizedNewtypeDeriving, StandaloneDeriving #-}
#if !(MIN_VERSION_base(4,5,0))
{-# LANGUAGE MagicHash #-}
#endif
{-# OPTIONS_GHC -fno-warn-orphans #-}
{-|
Module:      Text.Show.Text.System.Posix.Types
Copyright:   (C) 2014 Ryan Scott
License:     BSD-style (see the file LICENSE)
Maintainer:  Ryan Scott
Stability:   Experimental
Portability: GHC

Monomorphic 'Show' functions for Haskell equivalents of POSIX data types.
-}
#include "HsBaseConfig.h"

module Text.Show.Text.System.Posix.Types (
      showbFdPrec
#if defined(HTYPE_DEV_T)
    , showbCDev
#endif
#if defined(HTYPE_INO_T)
    , showbCIno
#endif
#if defined(HTYPE_MODE_T)
    , showbCMode
#endif
#if defined(HTYPE_OFF_T)
    , showbCOffPrec
#endif
#if defined(HTYPE_PID_T)
    , showbCPidPrec
#endif
#if defined(HTYPE_SSIZE_T)
    , showbCSsizePrec
#endif
#if defined(HTYPE_GID_T)
    , showbCGid
#endif
#if defined(HTYPE_NLINK_T)
    , showbCNlink
#endif
#if defined(HTYPE_UID_T)
    , showbCUid
#endif
#if defined(HTYPE_CC_T)
    , showbCCc
#endif
#if defined(HTYPE_SPEED_T)
    , showbCSpeed
#endif
#if defined(HTYPE_TCFLAG_T)
    , showbCTcflag
#endif
#if defined(HTYPE_RLIM_T)
    , showbCRLim
#endif
    ) where

import Data.Text.Lazy.Builder (Builder)

import Prelude hiding (Show)

import System.Posix.Types

import Text.Show.Text.Classes (Show(showb, showbPrec))
import Text.Show.Text.Data.Integral ()
import Text.Show.Text.Foreign.C.Types ()

#if !(MIN_VERSION_base(4,5,0))
import GHC.Prim (unsafeCoerce#)

import Text.Show.Text.Data.Integral ( showbInt32Prec
                                    , showbInt64Prec
                                    , showbWord8
                                    , showbWord32
                                    , showbWord64
                                    )

# include "inline.h"
#endif

#if defined(HTYPE_DEV_T)
-- | Convert a 'CDev' to a 'Builder'.
showbCDev :: CDev -> Builder
# if MIN_VERSION_base(4,5,0)
showbCDev = showb
{-# INLINE showbCDev #-}
# else
showbCDev c = showbWord64 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_INO_T)
-- | Convert a 'CIno' to a 'Builder'.
showbCIno :: CIno -> Builder
# if MIN_VERSION_base(4,5,0)
showbCIno = showb
{-# INLINE showbCIno #-}
# else
showbCIno c = showbWord64 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_MODE_T)
-- | Convert a 'CMode' to a 'Builder'.
showbCMode :: CMode -> Builder
# if MIN_VERSION_base(4,5,0)
showbCMode = showb
{-# INLINE showbCMode #-}
# else
showbCMode c = showbWord32 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_OFF_T)
-- | Convert a 'COff' to a 'Builder' with the given precedence.
showbCOffPrec :: Int -> COff -> Builder
# if MIN_VERSION_base(4,5,0)
showbCOffPrec = showbPrec
{-# INLINE showbCOffPrec #-}
# else
showbCOffPrec p c = showbInt64Prec p $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_PID_T)
-- | Convert a 'CPid' to a 'Builder' with the given precedence.
showbCPidPrec :: Int -> CPid -> Builder
# if MIN_VERSION_base(4,5,0)
showbCPidPrec = showbPrec
{-# INLINE showbCPidPrec #-}
# else
showbCPidPrec p c = showbInt32Prec p $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_SSIZE_T)
-- | Convert a 'CSsize' to a 'Builder' with the given precedence.
showbCSsizePrec :: Int -> CSsize -> Builder
# if MIN_VERSION_base(4,5,0)
showbCSsizePrec = showbPrec
{-# INLINE showbCSsizePrec #-}
# else
showbCSsizePrec p c = showbInt32Prec p $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_GID_T)
-- | Convert a 'CGid' to a 'Builder'.
showbCGid :: CGid -> Builder
# if MIN_VERSION_base(4,5,0)
showbCGid = showb
{-# INLINE showbCGid #-}
# else
showbCGid c = showbWord32 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_NLINK_T)
-- | Convert a 'CNlink' to a 'Builder'.
showbCNlink :: CNlink -> Builder
# if MIN_VERSION_base(4,5,0)
showbCNlink = showb
{-# INLINE showbCNlink #-}
# else
showbCNlink c = showbWord32 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_UID_T)
-- | Convert a 'CUid' to a 'Builder'.
showbCUid :: CUid -> Builder
# if MIN_VERSION_base(4,5,0)
showbCUid = showb
{-# INLINE showbCUid #-}
# else
showbCUid c = showbWord32 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_CC_T)
-- | Convert a 'CCc' to a 'Builder'.
showbCCc :: CCc -> Builder
# if MIN_VERSION_base(4,5,0)
showbCCc = showb
{-# INLINE showbCCc #-}
# else
showbCCc c = showbWord8 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_SPEED_T)
-- | Convert a 'CSpeed' to a 'Builder'.
showbCSpeed :: CSpeed -> Builder
# if MIN_VERSION_base(4,5,0)
showbCSpeed = showb
{-# INLINE showbCSpeed #-}
# else
showbCSpeed c = showbWord32 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_TCFLAG_T)
-- | Convert a 'CTcflag' to a 'Builder'.
showbCTcflag :: CTcflag -> Builder
# if MIN_VERSION_base(4,5,0)
showbCTcflag = showb
{-# INLINE showbCTcflag #-}
# else
showbCTcflag c = showbWord32 $ unsafeCoerce# c
# endif
#endif

#if defined(HTYPE_RLIM_T)
-- | Convert a 'CRLim' to a 'Builder'.
showbCRLim :: CRLim -> Builder
# if MIN_VERSION_base(4,5,0)
showbCRLim = showb
{-# INLINE showbCRLim #-}
# else
showbCRLim c = showbWord64 $ unsafeCoerce# c
# endif
#endif

-- | Convert an 'Fd' to a 'Builder' with the given precedence.
showbFdPrec :: Int -> Fd -> Builder
showbFdPrec = showbPrec
{-# INLINE showbFdPrec #-}

#if MIN_VERSION_base(4,5,0)
# if defined(HTYPE_DEV_T)
deriving instance Show CDev
# endif

# if defined(HTYPE_INO_T)
deriving instance Show CIno
# endif

# if defined(HTYPE_MODE_T)
deriving instance Show CMode
# endif

# if defined(HTYPE_OFF_T)
deriving instance Show COff
# endif

# if defined(HTYPE_PID_T)
deriving instance Show CPid
# endif

# if defined(HTYPE_SSIZE_T)
deriving instance Show CSsize
# endif

# if defined(HTYPE_GID_T)
deriving instance Show CGid
# endif

# if defined(HTYPE_NLINK_T)
deriving instance Show CNlink
# endif

# if defined(HTYPE_UID_T)
deriving instance Show CUid
# endif

# if defined(HTYPE_CC_T)
deriving instance Show CCc
# endif

# if defined(HTYPE_SPEED_T)
deriving instance Show CSpeed
# endif

# if defined(HTYPE_TCFLAG_T)
deriving instance Show CTcflag
# endif

# if defined(HTYPE_RLIM_T)
deriving instance Show CRLim
# endif
#else
# if defined(HTYPE_DEV_T)
instance Show CDev where
    showb = showbCDev
    INLINE(showb)
# endif

# if defined(HTYPE_INO_T)
instance Show CIno where
    showb = showbCIno
    INLINE(showb)
# endif

# if defined(HTYPE_MODE_T)
instance Show CMode where
    showb = showbCMode
    INLINE(showb)
# endif

# if defined(HTYPE_OFF_T)
instance Show COff where
    showbPrec = showbCOffPrec
    INLINE(showbPrec)
# endif

# if defined(HTYPE_PID_T)
instance Show CPid where
    showbPrec = showbCPidPrec
    INLINE(showbPrec)
# endif

# if defined(HTYPE_SSIZE_T)
instance Show CSsize where
    showbPrec = showbCSsizePrec
    INLINE(showbPrec)
# endif

# if defined(HTYPE_GID_T)
instance Show CGid where
    showb = showbCGid
    INLINE(showb)
# endif

# if defined(HTYPE_NLINK_T)
instance Show CNlink where
    showb = showbCNlink
    INLINE(showb)
# endif

# if defined(HTYPE_UID_T)
instance Show CUid where
    showb = showbCUid
    INLINE(showb)
# endif

# if defined(HTYPE_CC_T)
instance Show CCc where
    showb = showbCCc
    INLINE(showb)
# endif

# if defined(HTYPE_SPEED_T)
instance Show CSpeed where
    showb = showbCSpeed
    INLINE(showb)
# endif

# if defined(HTYPE_TCFLAG_T)
instance Show CTcflag where
    showb = showbCTcflag
    INLINE(showb)
# endif

# if defined(HTYPE_RLIM_T)
instance Show CRLim where
    showb = showbCRLim
    INLINE(showb)
# endif
#endif

deriving instance Show Fd