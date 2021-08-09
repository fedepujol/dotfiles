-- Imports
-- General
import XMonad
import qualified XMonad.StackSet    as W
import System.IO
import System.Exit

-- Actions
import XMonad.Actions.WorkspaceNames

-- Data
import Data.Monoid
import qualified Data.Map  as M

-- Utils
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

-- Layouts
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid

-- Layout Modifiers
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

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
   spawnOnce "nitrogen --restore &"

--------------------------------------------------------------------------------------
-- Key bindings. Add, modify or remove here.
myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $ [
    -- Launch Terminal
    ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),

    -- Launch DMenu
    ((modm, xK_p), spawn "~/.config/bspwm/dmenu.sh"),

    -- TogglStrus
    ((modm, xK_b), sendMessage ToggleStruts),

    -- Close focused window
    ((modm .|. shiftMask, xK_c), kill),

    -- Rotate through the available layouts
    ((modm, xK_space), sendMessage NextLayout),

    -- Reset the layouts on the current workspace to default
    ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),

    -- Resize viewed windows to the correct size
    ((modm, xK_n), refresh),

    -- Move focus to the next window
    ((modm, xK_j), windows W.focusDown),

    -- Move focus to the previous window
    ((modm, xK_k), windows W.focusUp),

    -- Move focus to the Master window
    ((modm, xK_Return), windows W.focusMaster),

    -- Swap the focused window and the master window
    ((modm, xK_Return), windows W.swapMaster),

    -- Swap the focused window with the next one
    ((modm .|. shiftMask, xK_j), windows W.swapDown),

    -- Swap the focused window with the previous one
    ((modm .|. shiftMask, xK_k), windows W.swapUp),

    -- Shrink the master area
    ((modm, xK_h), sendMessage Shrink),

    -- Expand the master area
    ((modm, xK_l), sendMessage Expand),

    -- Push window back into tiling
    ((modm, xK_t), withFocused $ windows . W.sink),

    -- Increment the number of windows in the master area
    ((modm, xK_comma), sendMessage (IncMasterN 1)),

    -- Decrease the number of windows in the master area
    ((modm, xK_period), sendMessage( (IncMasterN (-1)))),

    -- Quit XMonad
    ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)),

    -- Restart XMonad
    ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
   ] ++
   -- Swith Workspaces
   [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
   ] ++
   -- Switch to physical Xinerama
   [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..],
          (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myAddKeys :: [(String, X())]
myAddKeys = [
    ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 5%-"),
    ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 5%+"),
    ("<XF86AudioMute>", spawn "amixer -q set Master toggle"),
    ("<XF86MonBrightnessUp>", spawn "python $HOME/workspace/python/xbacli/xbacli.py -inc 5"),
    ("<XF86MonBrightnessDown>", spawn "python $HOME/workspace/python/xbacli/xbacli.py -dec 5")]

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
                 ppTitle = xmobarColor "white" "" . shorten 50,
                 ppSep = magenta " * ",
                 ppUrgent = red . wrap (red "!") (red "!")
             },
         keys = myKeys,
         workspaces = myWorkspaces,
         manageHook = myManageHook,
         modMask = myModMask,
         startupHook = myStartupHook,
         terminal = myTerminal,
         focusedBorderColor = focusedBColor,
         normalBorderColor = normalBColor,
         borderWidth = border
    } `additionalKeysP` myAddKeys
