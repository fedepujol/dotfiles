-- Imports
import XMonad
import qualified XMonad.StackSet    as W

-- Actions
import XMonad.Actions.WorkspaceNames

-- Data
import Data.Monoid
import qualified Data.Map  as M

-- Utils
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
-- import XMonad.Hooks.EwmhDesktops

-- Layouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.TwoPane
import XMonad.Layout.Tabbed
import XMonad.Layout.Spacing

-- IO
import System.IO
import System.Exit

--------------------------------------------------------------------------------------
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
myWorkspaces = ["main", "www", "dev", "files", "media", "0", "1", "2", "3"]

-- Xmobar Colors
blue, lowWhite, magenta, red, white, yellow :: String -> String
magenta    = xmobarColor "#FF79C6" ""
blue       = xmobarColor "#BD93F9" ""
white      = xmobarColor "#F8F8F2" ""
yellow     = xmobarColor "#F1FA8C" ""
red        = xmobarColor "#FF5555" ""
lowWhite   = xmobarColor "#BBBBBB" ""

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
myStartupHook = do
   spawnOnce "nitrogen --restore"

--------------------------------------------------------------------------------------
-- Key bindings. Add, modify or remove here.
myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList [
    -- Launch DMenu
    ((modm, xK_p), spawn "~/.config/bspwm/dmenu.sh"),

    -- TogglStrus
    ((modm, xK_b), sendMessage ToggleStruts)
   ]
--------------------------------------------------------------------------------------
-- Layouts

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| simpleTabbed ||| Full ||| twoPane ||| Mirror twoPane 
    where
       -- default tiling algorithm partitions the screen into two panes
       tiled = Tall nmaster delta ration
       twoPane = TwoPane delta ration
       -- The default number of windows in the master pane
       nmaster = 1
       -- Default proportion of screen occupied by master pane
       ration = 1 / 2
       -- Percent of screen to increment by when resizing panes
       delta = 3 / 300

--------------------------------------------------------------------------------------
-- Window Rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
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
      className =? "kdesktop"        --> doIgnore ]

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
                 ppCurrent = wrap (white "[") (white "]"),
                 ppVisible = wrap (white "") (white ""),
                 ppHidden = lowWhite . wrap "(" ")",
                 ppHiddenNoWindows = blue . wrap " " "",
                 ppTitle = xmobarColor "green" "" . shorten 50,
                 ppSep = magenta " * ",
                 ppUrgent = red . wrap (yellow "!") (yellow "!")
             },
         -- keys = myKeys,
         workspaces = myWorkspaces,
         manageHook = myManageHook,
         modMask = myModMask,
         terminal = myTerminal,
         focusedBorderColor = focusedBColor,
         normalBorderColor = normalBColor,
         borderWidth = border
    } `additionalKeysP` [("<XF86AudioLowerVolume>", spawn "amixer -q set Master 5%-"),
                        ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 5%+"),
                        ("<XF86AudioMute>", spawn "amixer -q set Master toggle"),
                        ("<XF86MonBrightnessUp>", spawn "python $HOME/workspace/python/xbacli/xbacli.py -inc 5"),
                        ("<XF86MonBrightnessDown>", spawn "python $HOME/workspace/python/xbacli/xbacli.py -dec 5")
                        ]
