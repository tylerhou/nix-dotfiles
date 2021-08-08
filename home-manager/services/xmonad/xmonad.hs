import XMonad
import XMonad.Util.EZConfig

main = xmonad $ def { terminal = "alacritty" }
                `additionalKeysP`
		[ ("M-p", spawn "rofi -show drun")
		]
