{-# OPTIONS_GHC -W -fwarn-unused-imports -fno-warn-missing-signatures #-}

-- xmonad config used by Lucas Lollobrigida
-- Author: Lucas Lollobrigida
-- https://github.com/lucaslollobrigida/dotfiles

import           Data.Maybe
import           XMonad
import qualified XMonad.StackSet               as W
import           XMonad.Actions.WindowGo
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicProperty
import           XMonad.Hooks.DynamicLog        ( dynamicLogWithPP
                                                , defaultPP
                                                , wrap
                                                , pad
                                                , xmobarPP
                                                , xmobarColor
                                                , shorten
                                                , PP(..)
                                                )
import           XMonad.Hooks.ManageDocks       ( docks
                                                , avoidStruts
                                                , manageDocks
                                                )
import           XMonad.Hooks.ManageHelpers
import           XMonad.ManageHook              ( className )
import           XMonad.Layout.NoBorders
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
  , "6:vm"
  , "7:misc"
  , "8:*"
  , "9:*"
  ]

myStatusBar :: String
myStatusBar =
  "kill -9 $(pid xmobar); while pgrep -x polybar >/dev/null; do sleep 1; done; xmobar -x 0 ~/.config/xmobar/xmobarrc"

myWallpaper :: String
myWallpaper = "nitrogen --restore &"

myDialogRunner :: String
myDialogRunner =
  "rofi -modi drun -matching fuzzy -sorting-method fzf drun -show"

myCompositor :: String
myCompositor = "picom &"

myShell :: String
myShell = "zsh"

myTerm :: String
myTerm = "st"

myManageHook = composeAll
  [ className =? "Firefox" --> doShift "1:www"
  , className =? "Emacs" --> doShift "2:code"
  , className =? "Slack" --> doShift "4:comms"
  , className =? "Spotify" --> doShift "5:music"
  , className =? "*" --> doShift "9:*"
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
  tile  = Tall 1 (3 / 100) (1 / 2)
  gtile = Tall 1 (2 / 100) (2 / (1 + (toRational (sqrt (5) :: Double))))

myStartupHook = do
  spawnOnce myWallpaper
  spawnOnce myCompositor

myKeys =
  [ ("M-p", spawn myDialogRunner)
  , ( "M-<Return>"
    , spawn myTerm
    )
  -- , ("M-S-<Return>", raiseMaybe (spawn "st -c nvim -e nvim") (className =? "nvim"))
  , ("M-m", spawn "spotify")
  ]

main :: IO ()
main = do
  xmproc <- spawnPipe myStatusBar
  xmonad
    $                 docks desktopConfig
                        { normalBorderColor  = "#111111"
                        , focusedBorderColor = "#9c71C7"
                        , borderWidth        = 6
                        , terminal           = myTerm
                        , workspaces         = myWorkspaces
                        , layoutHook         = myLayoutHook
                        , manageHook         = manageDocks <+> myManageHook
                        , handleEventHook = dynamicPropertyChange "WM_CLASS" myManageHook
                                              <+> handleEventHook desktopConfig
                        , startupHook        = myStartupHook
                        , logHook            = dynamicLogWithPP xmobarPP
                                                 { ppOutput = \x -> hPutStrLn xmproc x                 -- >> hPutStrLn xmproc1 x  >> hPutStrLn xmproc2 x
                                                 , ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]" -- Current workspace in xmobar
                                                 , ppVisible = xmobarColor "#c3e88d" ""                -- Visible but not current workspace
                                                 , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                                                 , ppHiddenNoWindows = xmobarColor "#F07178" ""        -- Hidden workspaces (no windows)
                                                 , ppTitle = xmobarColor "#d0d0d0" "" . shorten 60     -- Title of active window in xmobar
                                                 , ppSep = "<fc=#666666> | </fc>"                     -- Separators in xmobar
                                                 , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                                                 , ppExtras = [windowCount]                           -- # of windows current workspace
                                                 , ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
                                                 }
                        }
    `additionalKeysP` myKeys
