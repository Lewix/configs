-- Imports --
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run(runInTerm, spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

import XMonad.Layout.NoBorders
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Named

import XMonad.Actions.CycleWS
import XMonad.Prompt
import XMonad.Prompt.Directory
import XMonad.Prompt.AppLauncher as AL
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.IO

-- Colors --
myNormalBGColor		= "#202020"
myFocusedBGColor	= "#202020"
myUrgentBGColor		= "#202020"
myNormalFGColor		= "#DDDDDD"
myFocusedFGColor	= "#6F99B4"
myUrgentFGColor		= "#AE4747"

-- Main --
main = do
	workspaceBar <- spawnPipe myWorkSpaceBar
	timeBar <- spawnPipe myTimeBar

	xmonad $ withUrgencyHook NoUrgencyHook
	       $ defaultConfig
		{ manageHook 		= myManageHook
		, layoutHook 		= myLayoutHook
		, focusFollowsMouse = False
		, logHook 		= dynamicLogWithPP $ defaultPP
			{ ppOutput 	= hPutStrLn workspaceBar
			, ppCurrent 	= dzenColor myFocusedFGColor ""
			, ppVisible = dzenColor myNormalFGColor ""
			, ppUrgent  = dzenColor myUrgentFGColor ""
			, ppTitle 	= dzenColor myFocusedFGColor "" . shorten 150
			, ppSep		= "  |  "
			, ppWsSep	= "  "
			}
		, workspaces		= myWorkspaces
		, terminal		= myTerminal
		, borderWidth		= myBorderWidth
		, normalBorderColor	= myNormalBorderColor
		, focusedBorderColor	= myFocusedBorderColor
		, modMask 		= mod4Mask
		} `additionalKeys`
		[ ((mod4Mask, xK_p),			 spawn "dmenu_run -i -nb '#202020' -nf '#DDDDDD' -sb '#202020' -sf '#6F99B4' -fn '-*-droid sans-medium-r-*-*-11-*-*-*-*-*-*-*'")
		, ((mod4Mask, xK_Tab),		 toggleWS)
		, ((mod4Mask, xK_g),			 AL.launchApp myPromptConfig "sr google")
		, ((mod4Mask, xK_a),			 AL.launchApp myPromptConfig "sr wikipedia")
		, ((mod4Mask, xK_u),			 AL.launchApp myPromptConfig "uzbl-browser")
		, ((mod4Mask, xK_f),			 AL.launchApp myPromptConfig "chromium")
		, ((mod4Mask, xK_m),       AL.launchApp myPromptConfig "mplayer")
		, ((mod4Mask .|. shiftMask, xK_v), AL.launchApp myPromptConfig "urxvt -title vim -e vim")
		, ((mod4Mask .|. shiftMask, xK_m), AL.launchApp myPromptConfig "mpd")
		, ((mod4Mask, xK_v),			 runInTerm "-title vim" "vim")
		, ((mod4Mask, xK_i),			 runInTerm "-title irssi" "irssi & urxvt -title nicklist -e cat ~/.irssi/nicklistfifo")
		, ((mod4Mask, xK_n),			 runInTerm "-title ncmpcpp" "ncmpcpp")
		, ((mod4Mask, xK_d),			 changeDir myPromptConfig)
		, ((mod4Mask, xK_BackSpace),       focusUrgent)
		]

-- Dzen bars --
myWorkSpaceBar = "dzen2 -bg '" ++ myNormalBGColor ++ "' -fg '" ++ myNormalFGColor ++ "' -ta l -fn '-*-droid sans-medium-r-*-*-11-*-*-*-*-*-*' -w 500"
myTimeBar = "conky | dzen2 -bg '" ++ myNormalBGColor ++ "' -fg '" ++ myNormalFGColor ++ "' -ta r -sa r -fn '-*-droid sans-medium-r-*-*-11-*-*-*-*-*-*' -x 500"

-- Terminal --
myTerminal = "urxvt"

-- Workspaces --
myWorkspaces = ["main", "misc", "3", "4", "5", "6", "irssi", "music", "web"]

-- Borders --
myBorderWidth		= 2
myNormalBorderColor	= myNormalBGColor
myFocusedBorderColor	= myFocusedFGColor

-- Layout hook --
myLayoutHook = workspaceDir "~" $
               onWorkspace "irssi" irssiLayouts $
               myTall ||| myMirrorTall ||| myFull ||| myTabbed

-- Layouts
myIncrement = 3/100
myTall =       smartBorders $ avoidStruts $ Tall 1 myIncrement (50/100)
myMirrorTall = smartBorders $ avoidStruts $ Mirror $ Tall 1 myIncrement (85/100)
myTabbed =     named "Tabbed " (smartBorders $ avoidStruts $ tabbedBottom shrinkText myTabbedTheme)
myFull =       noBorders $ Full

-- Per workspace layouts
irssiLayouts = smartBorders $ avoidStruts (Tall 1 (3/100) (90/100) ||| Full)

-- Tabbed theme
myTabbedTheme = defaultTheme
  { activeColor = myFocusedBGColor
  , inactiveColor = myNormalBGColor
  , urgentColor = myUrgentBGColor
  , activeBorderColor = myFocusedFGColor
  , inactiveBorderColor = myNormalBGColor
  , urgentBorderColor = myUrgentBGColor
  , activeTextColor = myFocusedFGColor
  , inactiveTextColor = myNormalFGColor
  , urgentTextColor = myUrgentFGColor
  , fontName = "-*-droid sans-medium-r-*-*-11-*-*-*-*-*-*-*"
  , decoWidth = myBorderWidth
  , decoHeight = 17
  }

-- ManageHook --
myManageHook = manageDocks <+> composeAll
	[ className =? "Uzbl-core"	--> doF (W.shift "web")
	, className =? "Firefox" --> doF (W.shift "web")
	, title     =? "nicklist" --> doF (W.shift "irssi")
	, title 		=? "irssi" 			--> doF (W.shift "irssi")
	, title			=? "ncmpcpp"		--> doF (W.shift "music")
	]

-- Prompt config --
myPromptConfig :: XPConfig
myPromptConfig  = defaultXPConfig
	{ position		= Top
	, font				= "-*-droid sans-medium-r-*-*-11-*-*-*-*-*-*-*"
	, bgColor			= "#202020"
	, fgColor			= "#DDDDDD"
	, fgHLight		= "#6F99B4"
	, borderColor	= "#202020"
	}
