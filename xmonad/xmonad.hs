-- Imports --
import XMonad
import IO(Handle,hPutStrLn)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run(runInTerm, spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.NoBorders
import XMonad.Layout.WorkspaceDir
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
	workspaceBar <- spawnPipe "dzen2 -ta l -fn '-*-droid sans-medium-r-*-*-11-*-*-*-*-*-*' -w 500"
	timeBar <- spawnPipe "conky | dzen2 -ta r -sa r -fn '-*-droid sans-medium-r-*-*-11-*-*-*-*-*-*' -x 500"

	xmonad $ withUrgencyHook NoUrgencyHook
	       $ defaultConfig
		{ manageHook 		= myManageHook <+> manageHook defaultConfig
		, layoutHook 		= myLayoutHook
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
		, ((mod4Mask, xK_w),			 AL.launchApp myPromptConfig "sr wikipedia")
		, ((mod4Mask, xK_u),			 AL.launchApp myPromptConfig "uzbl-browser")
		, ((mod4Mask, xK_m), AL.launchApp myPromptConfig "mplayer")
		, ((mod4Mask .|. shiftMask, xK_m), AL.launchApp myPromptConfig "mpd")
		, ((mod4Mask, xK_v),			 runInTerm "-title vim" "vim")
		, ((mod4Mask, xK_e),			 runInTerm "-title mutt" "mutt")
		, ((mod4Mask, xK_i),			 runInTerm "-title irssi" "irssi")
		, ((mod4Mask, xK_n),			 runInTerm "-title ncmpcpp" "ncmpcpp")
		, ((mod4Mask, xK_d),			 changeDir myPromptConfig)
		, ((mod4Mask, xK_BackSpace),       focusUrgent)
		]
-- Terminal --
myTerminal = "urxvt"

-- Workspaces --
myWorkspaces = ["main", "misc", "3", "4", "5", "6", "irssi", "music", "web"]

-- Borders --
myBorderWidth		= 2
myNormalBorderColor	= myNormalBGColor
myFocusedBorderColor	= myFocusedFGColor

-- Layouts --
myLayoutHook		= smartBorders $ avoidStruts (workspaceDir "~" (Tall 1 (3/100) (50/100)) ||| workspaceDir "~" (Mirror (Tall 1 (3/100) (85/100)))) ||| workspaceDir "/mnt/media/Movies" (Full)

-- ManageHook --
myManageHook = manageDocks <+> composeAll
	[ className =? "Uzbl-core"	--> doF (W.shift "web")
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
