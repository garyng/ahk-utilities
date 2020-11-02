#InstallKeybdHook
#UseHook
#SingleInstance Force
#Persistent
#Warn
#NoEnv

DetectHiddenWindows, On
SetBatchLines -1

#Include Functions.ahk
#Include Config.ahk

#Include WindowSwitcher.ahk
#Include VirtualDesktopEnhancer.ahk
#Include WindowQuickMinMax.ahk
#Include Overlay.ahk
#Include Conditions.ahk
#Include Mouse.ahk
#Include MultiplePressListener.ahk

_windowSwitcher := new WindowSwitcher()
_virtualDesktopEnhancer := new VirtualDesktopEnhancer()
_windowQuickMinMax := new WindowQuickMinMax()
_overlay := new Overlay()
_enableOverlay := true

_layerConfig := new Config("layer")
LoadLayerTrayIcon()

; _enableHomeEndKeyRemap := false
; #Include devices/K380.ahk

^+!R::Reload

; Hot strings ===============

:*:!!dt::
	TypeDateTime()
	return
:*:!!ds::
	TypeShortDate()
	return
:*:!!dd::
	TypeIsoDate()
	return
:*:!!dz::
	TypeZettelkastenUid()
	return
:*:!!gc::
	TypeGitClone()
	return
:*:!!img::
	TypeMarkdownImageTag()
	return
:*:!!cb::
	TypeClipboard()
	return
:*:!!r::
	TypeRandomNumber()
	return
:*:!!fd::
	TypeFileDate()
	return
:*:!!ft::
	TypeFileDateTime()
	return

; Hot strings ============

!F1::ToggleActiveWindowAlwaysOnTop(), showOverlay("!F1", "Toggle active window always on top")

#if !WinActive("ahk_exe Acrobat.exe") && !WinActive("ahk_exe idea64.exe")
	~LShift & WheelUp::ScrollLeft()
	~LShift & WheelDown::ScrollRight()
#if

!F2::ResetTransparencyOfWindowUnderMouse(), showOverlay("!F2", "Reset the transparency of window under mouse")

#if GetKeyState("Esc", "P")
	F1::_windowSwitcher.Switch("xyplorer"), showOverlay("Esc, F1", "Switch to xyplorer")
	F2::_windowSwitcher.Switch("firefox"), showOverlay("Esc, F2", "Switch to firefox")
	F3::_windowSwitcher.Switch("onenote"), showOverlay("Esc, F3", "Switch to onenote")
	; F4::_windowSwitcher.Switch("gitkraken"), showOverlay("Esc, F4", "Switch to gitkraken")
	; F5::_windowSwitcher.Switch("sublime"), showOverlay("Esc, F5", "Switch to sublime")
	F6::_windowSwitcher.Switch("keepass"), showOverlay("Esc, F6", "Switch to keepass")

	+F1::_windowSwitcher.Launch("xyplorer"), showOverlay("Esc, +F1", "Launch xyplorer")
	+F2::_windowSwitcher.Launch("firefox"), showOverlay("Esc, +F2", "Launch firefox")
	+F3::_windowSwitcher.Launch("onenote"), showOverlay("Esc, +F3", "Launch onenote")
	; +F4::_windowSwitcher.Launch("gitkraken"), showOverlay("Esc, +F4", "Launch gitkraken")
	; +F5::_windowSwitcher.Launch("sublime"), showOverlay("Esc, +F5", "Launch sublime")
	+F6::_windowSwitcher.Launch("keepass"), showOverlay("Esc, +F6", "Launch keepass")

	1::_windowSwitcher.Switch("visualstudio"), showOverlay("Esc, 1", "Switch to visual studio")
	; 2::_windowSwitcher.Switch("todoist"), showOverlay("Esc, 2", "Switch to todoist")
	; 3::_windowSwitcher.Switch("cmder"), showOverlay("Esc, 3", "Switch to cmder")
	4::_windowSwitcher.Switch("vscode"), showOverlay("Esc, 4", "Switch to vscode")
	5::_windowSwitcher.Switch("notepad"), showOverlay("Esc, 5", "Switch to notepad")
	; 6::_windowSwitcher.Switch("calendar"), showOverlay("Esc, 6", "Switch to calendar")

	+1::_windowSwitcher.Launch("visualstudio"), showOverlay("Esc, +1", "Launch visual studio")
	; +2::_windowSwitcher.Launch("todoist"), showOverlay("Esc, +2", "Launch todoist")
	; +3::_windowSwitcher.Launch("cmder"), showOverlay("Esc, +3", "Launch cmder")
	+4::_windowSwitcher.Launch("vscode"), showOverlay("Esc, +4", "Launch vscode")
	+5::_windowSwitcher.Launch("notepad"), showOverlay("Esc, +5", "Launch notepad")
	; +6::_windowSwitcher.Launch("calendar"), showOverlay("Esc, +6", "Launch calendar")

	q::_windowSwitcher.Switch("toggl"), showOverlay("Esc, q", "Switch to toggl")
	+q::_windowSwitcher.Switch("toggl"), showOverlay("Esc, +q", "Launch toggl")

	; w::_windowSwitcher.Switch("itunes"), showOverlay("Esc, w", "Switch to itunes")
	; +w::_windowSwitcher.Switch("itunes"), showOverlay("Esc, +w", "Launch itunes")
	
	e::_windowSwitcher.Switch("todoist_firefox"), showOverlay("Esc, e", "Switch to todoist (Web)")
	+e::_windowSwitcher.Switch("todoist_firefox"), showOverlay("Esc, +e", "Launch todoist (Web)")

	; s::_windowSwitcher.Switch("slack"), showOverlay("Esc, s", "Switch to slack")
	; +s::_windowSwitcher.Switch("slack"), showOverlay("Esc, +s", "Launch slack")s

	; s::_windowSwitcher.Switch("asana_firefox"), showOverlay("Esc, s", "Switch to asana (Web)")
	; +s::_windowSwitcher.Switch("asana_firefox"), showOverlay("Esc, +s", "Launch asana (Web)")

	; a::_windowSwitcher.Switch("station"), showOverlay("Esc, a", "Switch to station")
	; +a::_windowSwitcher.Switch("station"), showOverlay("Esc, +a", "Launch station")

	; s::_windowSwitcher.Switch("source_tree"), showOverlay("Esc, s", "Switch to source tree")
	; +s::_windowSwitcher.Switch("source_tree"), showOverlay("Esc, +s", "Launch source tree")

	; c::_windowSwitcher.Switch("calendar_firefox"), showOverlay("Esc, c", "Switch to calendar (Web)")
	; +c::_windowSwitcher.Switch("calendar_firefox"), showOverlay("Esc, +c", "Launch calendar (Web)")
#if

; #if GetKeyState("F1", "P")
; 	z::_windowQuickMinMax.MinimizeActiveWindow(), showOverlay("F1, z", "Minimize active window")
; 	x::_windowQuickMinMax.MaximizeActiveWindow(), showOverlay("F1, x", "Maximize active window")

; 	a::_windowQuickMinMax.Restore(), showOverlay("F1, a", "Restore previously minimized/maximized window")
; 	s::_windowQuickMinMax.ClearHistory(), showOverlay("F1, s", "Clear history stack")
; #if

#if IsNone()
	CapsLock & 1::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(0), showOverlay("CapsLock & 1", "Switch to desktop #1")
	CapsLock & 2::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(1), showOverlay("CapsLock & 2", "Switch to desktop #2")
	CapsLock & 3::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(2), showOverlay("CapsLock & 3", "Switch to desktop #3")
	CapsLock & 4::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(3), showOverlay("CapsLock & 4", "Switch to desktop #4")
	CapsLock & 5::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(4), showOverlay("CapsLock & 5", "Switch to desktop #5")
	CapsLock & 6::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(5), showOverlay("CapsLock & 6", "Switch to desktop #6")
	CapsLock & 7::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(6), showOverlay("CapsLock & 7", "Switch to desktop #7")
	CapsLock & 8::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(7), showOverlay("CapsLock & 8", "Switch to desktop #8")
	CapsLock & 9::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(8), showOverlay("CapsLock & 9", "Switch to desktop #9")
	CapsLock & F1::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(0), showOverlay("CapsLock & F1", "Move active window to desktop #1")
	CapsLock & F2::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(1), showOverlay("CapsLock & F2", "Move active window to desktop #2")
	CapsLock & F3::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(2), showOverlay("CapsLock & F3", "Move active window to desktop #3")
	CapsLock & F4::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(3), showOverlay("CapsLock & F4", "Move active window to desktop #4")
	CapsLock & F5::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(4), showOverlay("CapsLock & F5", "Move active window to desktop #5")
	CapsLock & F6::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(5), showOverlay("CapsLock & F6", "Move active window to desktop #6")
	CapsLock & F7::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(6), showOverlay("CapsLock & F7", "Move active window to desktop #7")
	CapsLock & F8::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(7), showOverlay("CapsLock & F8", "Move active window to desktop #8")
	CapsLock & F9::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(8), showOverlay("CapsLock & F9", "Move active window to desktop #9")

	CapsLock & a::_virtualDesktopEnhancer.SwitchToPreviousDesktopThenFocus(), showOverlay("CapsLock & a", "Switch to previous desktop")
	CapsLock & s::_virtualDesktopEnhancer.SwitchToNextDesktopThenFocus(), showOverlay("CapsLock & s", "Switch to next desktop")

	CapsLock & q::_virtualDesktopEnhancer.MoveActiveWindowToPreviousDesktopThenFocus(), showOverlay("CapsLock & q", "Move active window to previous desktop")
	CapsLock & w::_virtualDesktopEnhancer.MoveActiveWindowToNextDesktopThenFocus(), showOverlay("CapsLock & w", "Move active window to next desktop")

	CapsLock & c::_virtualDesktopEnhancer.CreateDesktop(), showOverlay("CapsLock & c", "Create a new desktop")
	CapsLock & d::_virtualDesktopEnhancer.DeleteCurrentDesktop(), showOverlay("CapsLock & d", "Delete current desktop")

	CapsLock & z::_virtualDesktopEnhancer.PinActiveWindow(), showOverlay("CapsLock & z", "Pin active window")
	CapsLock & x::_virtualDesktopEnhancer.PinActiveApp(), showOverlay("CapsLock & x", "Pin active app")

	CapsLock & e::_virtualDesktopEnhancer.GoToLastDesktop(), showOverlay("CapsLock, e", "Go to last active desktop")
#if

#if IsOnlyShift()	; Only Shift is pressed -> "Shift" window and desktop
	CapsLock & 1::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(0), showOverlay("CapsLock, Shift + 1", "Move active window and switch to desktop #1")
	CapsLock & 2::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(1), showOverlay("CapsLock, Shift + 2", "Move active window and switch to desktop #2")
	CapsLock & 3::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(2), showOverlay("CapsLock, Shift + 3", "Move active window and switch to desktop #3")
	CapsLock & 4::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(3), showOverlay("CapsLock, Shift + 4", "Move active window and switch to desktop #4")
	CapsLock & 5::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(4), showOverlay("CapsLock, Shift + 5", "Move active window and switch to desktop #5")
	CapsLock & 6::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(5), showOverlay("CapsLock, Shift + 6", "Move active window and switch to desktop #6")
	CapsLock & 7::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(6), showOverlay("CapsLock, Shift + 7", "Move active window and switch to desktop #7")
	CapsLock & 8::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(7), showOverlay("CapsLock, Shift + 8", "Move active window and switch to desktop #8")
	CapsLock & 9::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(8), showOverlay("CapsLock, Shift + 9", "Move active window and switch to desktop #9")

	CapsLock & a::_virtualDesktopEnhancer.MoveActiveWindowAndSwitchToPreviousDesktopThenFocus(), showOverlay("CapsLock, Shift + a", "Move active window and switch to previous desktop")
	CapsLock & s::_virtualDesktopEnhancer.MoveActiveWindowAndSwitchToNextDesktopThenFocus(), showOverlay("CapsLock, Shift + s", "Move active window and switch to next desktop")

	CapsLock & z::_virtualDesktopEnhancer.UnpinActiveWindow(), showOverlay("CapsLock, Shift + z", "Unpin active window")
	CapsLock & x::_virtualDesktopEnhancer.UnpinActiveApp(), showOverlay("CapsLock, Shift + x", "Unpin active app")
#if

#if IsOnlyCtrl()
	; CapsLock & a::_virtualDesktopEnhancer.MoveAllWindowToNewDesktop(), showOverlay("CapsLock, Ctrl + a", "Move all windows to new desktop")
	; CapsLock & z::_virtualDesktopEnhancer.ToggleWindowPinning(), showOverlay("CapsLock, Ctrl + z", "Toggle window pinning")
	; CapsLock & x::_virtualDesktopEnhancer.ToggleAppPinning(), showOverlay("CapsLock, Ctrl + x", "Toggle app pining")
#if

#If IsNone()
	; ~MButton & z::_windowQuickMinMax.MinimizeActiveWindow(), showOverlay("~MButton & z", "Minimize active window")
	~MButton & x::_windowQuickMinMax.MaximizeActiveWindow(), showOverlay("~MButton & x", "Maximize active window")

	~LButton & Left::Mouse.MoveHorizontal(-1)
	~LButton & Right::Mouse.MoveHorizontal(1)
	~LButton & Up::Mouse.MoveVertical(-1)
	~LButton & Down::Mouse.MoveVertical(1)
#if

#If IsOnlyCtrl()
	~MButton & z::_windowQuickMinMax.MinimizeWindowUnderMouse(), showOverlay("~MButton & Ctrl + z", "Minimize window under mouse")
	~MButton & x::_windowQuickMinMax.MaximizeWindowUnderMouse(), showOverlay("~MButton & Ctrl + x", "Maximize window under mouse")

	~LButton & Left::Mouse.MoveHorizontal(-10)
	~LButton & Right::Mouse.MoveHorizontal(10)
	~LButton & Up::Mouse.MoveVertical(-10)
	~LButton & Down::Mouse.MoveVertical(10)
#if

#if IsOnlyShift()
	~MButton & z::_windowQuickMinMax.Restore(), showOverlay("~MButton & Shift + z", "Restore previously minimized/maximized window")
	~MButton & x::_windowQuickMinMax.ClearHistory(), showOverlay("~MButton & Shift + x", "Clear history stack")
#if

; Numpad =============
#Include devices/34KeysNumpad.ahk

; Mouse ==============
#Include devices/MXMaster3.ahk

; Keyboard ============
#Include devices/MXKeys.ahk

showOverlay(label, description)
{
	global _enableOverlay
	global _overlay
	if (_enableOverlay)
	{
		_overlay.Show(HumanizeHotkey(label), description)
	}
}

; # Win
; ! Alt
; ^ Ctrl
; + Shift