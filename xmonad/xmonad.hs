-- Imports.
import XMonad
import qualified XMonad.StackSet as W -- "workspaces" conflicts with XMonad.workspaces
import qualified Data.Map as M
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run
import XMonad.Actions.UpdatePointer
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders

import XMonad.Layout.Spiral
import XMonad.Layout.Dishes

import System.Exit

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, determines what is being written to the bar.
myPP = xmobarPP { ppUrgent = xmobarColor "yellow" "red" . xmobarStrip, 
                  ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Workspaces
myWorkspaces = map show [1..22]

-- Keybindings
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $ [
      ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask,               xK_p     ), spawn "dmenu_run")
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun")
    , ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_n     ), refresh)
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp  )
    , ((modMask,               xK_m     ), windows W.focusMaster  )
    , ((modMask,               xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    [
        ((m .|. modMask, k), windows $ f i) |
            (i, k) <- zip (XMonad.workspaces conf) ([xK_1..xK_9] ++ [xK_0] ++ [xK_F1..xK_F12]),
            (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
    ++
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

-- Toggle status bar
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Layouts
customLayout = spiral (6/7) ||| Dishes 2 (1/6) ||| tall ||| Mirror tall ||| Full
    where
        tall = Tall 1 (3/100) (1/2)

-- Main configuration, override the defaults to your liking.
myConfig = withUrgencyHook NoUrgencyHook $
    defaultConfig {
        logHook = updatePointer (Relative 0.5 0.5),
        modMask = mod1Mask,
        keys = myKeys,
        terminal = "urxvt",
        layoutHook = smartBorders $ customLayout,
        workspaces = myWorkspaces
	}
