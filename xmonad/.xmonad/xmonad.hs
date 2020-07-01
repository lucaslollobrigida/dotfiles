{-# OPTIONS_GHC -W -fwarn-unused-imports -fno-warn-missing-signatures #-}

-- xmonad config used by Lucas Lollobrigida
-- Author: Lucas Lollobrigida
-- https://github.com/lucaslollobrigida/dotfiles

import           XMonad
import qualified XMonad.StackSet               as W
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicProperty
import           XMonad.Hooks.DynamicLog        ( dynamicLogWithPP
                                                , wrap
                                                , xmobarPP
                                                , xmobarColor
                                                , shorten
                                                , PP(..)
                                                )
import           XMonad.Hooks.ManageDocks       ( docks
                                                , avoidStruts
                                                , manageDocks
                                                )
import           XMonad.Hooks.EwmhDesktops      ( ewmh )
import           XMonad.Hooks.ManageHelpers
import           XMonad.ManageHook              ( className )
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing
import           XMonad.Util.EZConfig
import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce

myModMask = mod4Mask

myWorkspaces :: [WorkspaceId]
myWorkspaces =
  [ "1:www"
  , "2:code"
  , "3:sh"
  , "4:comms"
  , "5:music"
  , "6:media"
  , "7:virt"
  , "8:wiki"
  , "9:*"
  ]


myStatusBar =
  "~/.xmonad/bin/start-xmobar"

myDialogRunner =
  "rofi -modi drun -matching fuzzy -sorting-method fzf drun -show"

myTerm = "st"

raiseVolume = "amixer set Master 5%+"
lowerVolume = "amixer set Master 5%-"
toggleVolumeMute ="amixer set Master 1+ toggle"
increaseBrightness = "xbacklight -inc 20"
decreaseBrightness = "xbacklight -dec 20"

-- XF86AudioPlay exec playerctl play
-- XF86AudioPause exec playerctl pause
-- XF86AudioNext exec playerctl next
-- XF86AudioPrev exec playerctl previous

myManageHook = composeAll
  [ className =? "Firefox"  --> doShift "1:www"
  , className =? "Emacs"    --> doShift "2:code"
  , className =? "Code"     --> doShift "2:code"
  , className =? "Slack"    --> doShift "4:comms"
  , className =? "Hexchat"  --> doShift "4:comms"
  , className =? "Spotify"  --> doShift "5:music"
  , className =? "Gimp-2.0" --> doShift "9:*"

  , isFullscreen --> doFullFloat
  ]

windowCount =
  gets
    $ Just
    . show
    . length
    . W.integrate'
    . W.stack
    . W.workspace
    . W.current
    . windowset

myLayoutHook = avoidStruts $ smartBorders $ (tile ||| gtile ||| full)
 where
  full  = noBorders Full
  tile  = spacing 3 $ Tall 1 (3 / 100) (1 / 2)
  gtile = spacing 3 $ Tall 1 (2 / 100) (2 / (1 + (toRational (sqrt (5) :: Double))))

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "picom &"
  spawnOnce "xrdb -merge ~/.Xresources &"
  spawnOnce "feh --bg-max ~/wallpapers/person-wearing-red-hoodie-1097456.jpg"
  spawnOnce "xmodmap ~/.Xmodmap"

myKeys =
  [ ("M-p", spawn myDialogRunner)
  , ("M-<Return>", spawn myTerm)

  , ("M-'", spawn decreaseBrightness)
  , ("M-;", spawn increaseBrightness)

  , ("M-,", spawn toggleVolumeMute)
  , ("M-.", spawn lowerVolume)
  , ("M-/", spawn raiseVolume)

  , ("M-b", spawn "firefox")
  , ("M-n", spawn "st -c Code -e tmux new-session -c ~/dev -s development nvim")
  , ("M-m", spawn "spotify")
  ]

main :: IO ()
main = do
  xmproc <- spawnPipe myStatusBar
  xmonad
    $ docks
    $ ewmh
    -- $ pagerHints
    desktopConfig
        { normalBorderColor  = "#111111"
        , focusedBorderColor = "#9c71C7"
        , modMask            = myModMask
        , borderWidth        = 2
        , terminal           = myTerm
        , workspaces         = myWorkspaces
        , layoutHook         = myLayoutHook
        , manageHook         = manageDocks <+> myManageHook
        , handleEventHook = dynamicPropertyChange "WM_CLASS" myManageHook
                              <+> handleEventHook desktopConfig
        , startupHook        = myStartupHook
        , logHook            = dynamicLogWithPP xmobarPP
                                 { ppOutput = \x -> hPutStrLn xmproc x
                                 , ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]"
                                 , ppVisible = xmobarColor "#c3e88d" ""
                                 , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""
                                 , ppHiddenNoWindows = xmobarColor "#F07178" ""
                                 , ppTitle = xmobarColor "#d0d0d0" "" . shorten 60
                                 , ppSep = "<fc=#666666> | </fc>"
                                 , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"
                                 , ppExtras = [windowCount]
                                 , ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
                                 }
        }
    `additionalKeysP` myKeys
