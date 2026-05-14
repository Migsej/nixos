
import XMonad
import XMonad.Actions.CopyWindow (kill1)
import Data.Map (fromList)

myKeys = [ ((mod4Mask, xK_Return), spawn "st")
         --, ((mod4Mask, xK_Return), kill1)
         ]


main :: IO ()
main = xmonad def
    { terminal    = "st"
    , modMask     = mod4Mask
    , borderWidth = 3
    , keys = const (fromList myKeys)
    }

