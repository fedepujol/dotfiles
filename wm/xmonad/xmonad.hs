-- Imports
-- General
import XMonad
import qualified XMonad.StackSet    as W
import System.IO
import System.Exit

-- Actions
import XMonad.Actions.GridSelect(GSConfig, goToSelected, gs_cellheight, gs_cellwidth, gs_font)
import XMonad.Actions.WorkspaceNames

-- Data
import Data.Monoid
import qualified Data.Map  as M
import XMonad.Actions.Submap

-- Utils
import XMonad.Util.EZConfig (additionalKeysP, checkKeymap)
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers(doCenterFloat)

-- Layouts
import XMonad.Layout.TwoPane
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid

-- Layout Modifiers
import XMonad.Layout.LayoutModifier(ModifiedLayout)
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed(renamed, Rename(Replace))
import XMonad.Layout.Spacing

-- Prompt
import XMonad.Prompt as Pmpt
import XMonad.Prompt.XMonad(xmonadPrompt)
import XMonad.Prompt.Man

--------------------------------------------------------------------------------------
-- Constants
myFont :: String
myFont = "xft:Ubuntu Nerd Font:size=12:antialias=true"

-- Override defaults for XMonad

-- By Default is XTerm
myTerminal :: String
myTerminal = "alacritty"

-- ModMask lets you specify which modkey you want to use. 
-- The default is mod1Mask ("left alt"). 
-- mod4Mask is usually the windows-key
myModMask :: KeyMask
myModMask = mod4Mask

-- Window border in pixels
border :: Dimension
border = 2

-- Border color for normal window (inactive one)
normalBColor :: String
normalBColor = "#808080"

-- Border color for focused window (active one)
focusedBColor :: String
focusedBColor = "#1F3D7E"

-- List of workspaces
myWorkspaces :: [String]
myWorkspaces = ["main", "www", "dev", "sys", "med", "off", "virt", "etc", "0"]

-- Xmobar Colors
blue, lowWhite, magenta, red, white, yellow :: String -> String
magenta    = xmobarColor "#FF79C6" ""
blue       = xmobarColor "#2196F3" ""
white      = xmobarColor "#F8F8F2" ""
yellow     = xmobarColor "#FFFF00" ""
red        = xmobarColor "#FF5555" ""
lowWhite   = xmobarColor "#BBBBBB" ""
green      = xmobarColor "#87DC89" ""
orange     = xmobarColor "#FFB327" ""

-- GridSelect Config
myGSConfig = def {
  gs_cellheight = 100,
  gs_cellwidth = 200,
  gs_font = myFont
}

-- Prompt Config
myPrompt :: XPConfig
myPrompt = def {
   Pmpt.font = myFont,
   Pmpt.bgColor = "#161616",
   Pmpt.fgColor = "#84B7E1",
   Pmpt.fgHLight = "#1E1E1E",
   Pmpt.bgHLight = "#69d36b",
   Pmpt.borderColor = "#262626",
   Pmpt.historySize = 0,
   Pmpt.position = Top
}

-- Prompts
promptList :: [(String, XPConfig -> X())]
promptList = [("x", xmonadPrompt), ("m", manPrompt)]

-- Spacing
mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing n = spacingRaw True (Border n n n n) True (Border n n n n) True

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
myStartupHook = do
   spawnOnce "nitrogen --restore &"

--------------------------------------------------------------------------------------
-- Key bindings. Add, modify or remove here.
-- KEY_START
myKeys :: [(String, X())]
myKeys = [
    -- GROUP XMonad
    ("M-q", spawn "xmonad --recompile; xmonad --restart"),  -- Re-Compiles and Re-starts XMonad
    ("M-S-q", io exitSuccess),                              -- Exit XMonad
    ("M-C-h", spawn "~/.xmonad/keys_helper.sh"),                  -- Prints Help
    -- GROUP DMenu
    ("M-p", spawn "~/.config/dmenu/dmenu.sh"),              -- Launch DMenu
    -- GROUP GridSelect
    ("M-<Tab>", goToSelected myGSConfig),                   -- Launch Custom GridSelect
    -- GROUP Spacing 
    ("M-s +", incScreenSpacing 2),                          -- Increase Screen border
    ("M-s -", decScreenSpacing 2),                          -- Decrease Screen border
    -- GROUP Dock Management
    ("M-b", sendMessage ToggleStruts),                      -- Toggle Docks (XMobar) on/off
    -- GROUP Layouts
    ("M-<Space>", sendMessage NextLayout),                  -- Change layouts
    ("M-n", refresh),                                       -- Reset layout to default
    -- GROUP Screen Lock
    ("M-l", spawn "screensaver-command -lock"),             -- Lock Screen
    -- GROUP Window Management
    ("M-j", windows W.focusDown),                           -- Move focus to next window
    ("M-k", windows W.focusUp),                             -- Move focus to previous window
    ("M-<Return>", windows W.swapMaster),                   -- Swap focus window with master
    ("M-S-j", windows W.swapDown),                          -- Swap focused window with next one 
    ("M-S-k", windows W.swapUp),                            -- Swap focused window with previous one
    ("M-S-c", kill),                                        -- Kill focused window
    ("M-h", sendMessage Shrink),                            -- Shrink focused window to the left
    ("M-l", sendMessage Expand),                            -- Expand focused window to the right
    ("M-,", sendMessage (IncMasterN 1)),                    -- Increase number of master windows 
    ("M-.", sendMessage (IncMasterN (-1))),                 -- Decrease number of master windows
    -- GROUP MediaKeys
    ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 5%-"), -- Increase volume
    ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 5%+"), -- Decrease volume
    ("<XF86AudioMute>", spawn "amixer -q set Master toggle"), -- Mute/Unmute sound
    ("<XF86MonBrightnessUp>", spawn "python ~/.config/scripts/xbacli/xbacli.py -inc 5"), -- Increase brightness
    ("<XF86MonBrightnessDown>", spawn "python ~/.config/scripts/xbacli/xbacli.py -dec 5") -- Decrease brightness
    ]
    -- GROUP Prompts
    ++ [("M-C-p " ++ k, p myPrompt) | (k, p) <- promptList -- Select from: Man, Xmonad
    ]
-- KEY_END
--------------------------------------------------------------------------------------
-- Layouts

-- The default number of windows in the master pane
nmaster :: Int
nmaster = 1

-- Percent of screen to increment by when resizing panes
delta :: Rational 
delta = 3 / 300

-- Default proportion of screen occupied by master pane
ration :: Rational 
ration = 1 / 2

-- Tall
tall :: ModifiedLayout Rename (ModifiedLayout Spacing Tall) a
tall = renamed [Replace "Tall"] $
    mySpacing 5 (Tall nmaster delta ration)

-- Mirror Tall
mTall :: Mirror (ModifiedLayout Rename (ModifiedLayout Spacing Tall)) a
mTall = Mirror tall 

-- TwoPane
twoPane :: ModifiedLayout Rename (ModifiedLayout Spacing TwoPane) a
twoPane = renamed [Replace "TwoPane"] $
    mySpacing 5 (TwoPane delta ration)

-- Mirror TwoPane
mTwoPane :: Mirror (ModifiedLayout Rename (ModifiedLayout Spacing TwoPane)) a
mTwoPane = Mirror twoPane

-- Available layouts
myLayout = tall ||| mTall ||| Grid ||| Full ||| twoPane ||| mTwoPane

--------------------------------------------------------------------------------------
-- Window Rules:

-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"         --> doFloat,
      className =? "Gimp"            --> doFloat,
      className =? "desktop_window"  --> doIgnore,
      className =? "kdesktop"        --> doIgnore,
      className =? "Yad"             --> doCenterFloat,
      (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat,
      title =? "Library" --> doFloat,
      resource =? "Extension" --> doFloat]

--------------------------------------------------------------------------------------
-- Main
main :: IO()
main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmobar/.xmobarrc"
  xmonad $ docks $ fullscreenSupport def {
         layoutHook = smartBorders . avoidStruts $ myLayout,
         handleEventHook = fullscreenEventHook,
         logHook = dynamicLogWithPP $ xmobarPP {
                 ppOutput = hPutStrLn xmproc,
                 ppCurrent = wrap (green "[") (green "]"),
                 ppVisible = wrap (green "{") (green "}"),
                 ppHidden = blue . wrap "(" ")",
                 ppHiddenNoWindows = orange . wrap " " "",
                 ppTitle = xmobarColor "white" "" . shorten 30,
                 ppSep = magenta " | ",
                 ppUrgent = red . wrap (red "!") (red "!")
             },
         workspaces = myWorkspaces,
         manageHook = myManageHook,
         modMask = myModMask,
         startupHook = myStartupHook,
         terminal = myTerminal,
         focusedBorderColor = focusedBColor,
         normalBorderColor = normalBColor,
         borderWidth = Main.border
    } `additionalKeysP` myKeys 
