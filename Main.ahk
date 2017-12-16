#InstallKeybdHook
#UseHook
#SingleInstance Force
#Persistent
#Warn
#NoEnv

DetectHiddenWindows, On
SetBatchLines -1

#Include Externals.ahk
#Include Functions.ahk

#Include WindowSwitcher.ahk
#Include VirtualDesktopEnhancer.ahk
#Include WindowQuickMinMax.ahk
#Include Overlay.ahk
#Include ModifierKeysDetector.ahk

RunExternals()
windowSwitcher := new WindowSwitcher()
virtualDesktopEnhancer := new VirtualDesktopEnhancer()
windowQuickMinMax := new WindowQuickMinMax()
overlay := new Overlay()
_enableOverlay := true

^+!R::Reload

:*:!!d::
	TypeDateTime()
	return
:*:!!gc::
	TypeGitClone()
	return

!F1::ToggleActiveWindowAlwaysOnTop(), showOverlay("!F1", "Toggle active window always on top")

#if !WinActive("ahk_exe Illustrator.exe")
	!WheelDown::DecreaseTransparencyOfWindowUnderMouse(),showOverlay("!WheelDown", "Decrease the transparency of window under mouse")
	!WheelUp::IncreaseTransparencyOfWindowUnderMouse(), showOverlay("!WheelUp", "Increase the transparency of window under mouse")
#if

!F2::ResetTransparencyOfWindowUnderMouse(), showOverlay("!F2", "Reset the transparency of window under mouseole")
#F1::_enableOverlay := !_enableOverlay, overlay.Show(HumanizeHotkey("#F1"), "Toogle overlay visibility to " . (_enableOverlay ? "true" : "false"))

#if GetKeyState("Esc", "P")
	F1::windowSwitcher.Switch("xyplorer"), showOverlay("Esc, F1", "Switch to xyplorer")
	F2::windowSwitcher.Switch("firefox"), showOverlay("Esc, F2", "Switch to firefox")
	F3::windowSwitcher.Switch("onenote"), showOverlay("Esc, F3", "Switch to onenote")
	F4::windowSwitcher.Switch("gitkraken"), showOverlay("Esc, F4", "Switch to gitkraken")
	F5::windowSwitcher.Switch("sublime"), showOverlay("Esc, F5", "Switch to sublime")
	F6::windowSwitcher.Switch("keepass"), showOverlay("Esc, F6", "Switch to keepass")

	+F1::windowSwitcher.Launch("xyplorer"), showOverlay("Esc, +F1", "Launch xyplorer")
	+F2::windowSwitcher.Launch("firefox"), showOverlay("Esc, +F2", "Launch firefox")
	+F3::windowSwitcher.Launch("onenote"), showOverlay("Esc, +F3", "Launch onenote")
	+F4::windowSwitcher.Launch("gitkraken"), showOverlay("Esc, +F4", "Launch gitkraken")
	+F5::windowSwitcher.Launch("sublime"), showOverlay("Esc, +F5", "Launch sublime")
	+F6::windowSwitcher.Launch("keepass"), showOverlay("Esc, +F6", "Launch keepass")

	1::windowSwitcher.Switch("visualstudio"), showOverlay("Esc, 1", "Switch to visual studio")
	2::windowSwitcher.Switch("todoist"), showOverlay("Esc, 2", "Switch to todoist")
	3::windowSwitcher.Switch("cmder"), showOverlay("Esc, 3", "Switch to cmder")
	4::windowSwitcher.Switch("vscode"), showOverlay("Esc, 4", "Switch to vscode")
	5::windowSwitcher.Switch("notepad"), showOverlay("Esc, 5", "Switch to notepad")
	6::windowSwitcher.Switch("calendar"), showOverlay("Esc, 6", "Switch to calendar")

	+1::windowSwitcher.Launch("visualstudio"), showOverlay("Esc, +1", "Launch visual studio")
	+2::windowSwitcher.Launch("todoist"), showOverlay("Esc, +2", "Launch todoist")
	+3::windowSwitcher.Launch("cmder"), showOverlay("Esc, +3", "Launch cmder")
	+4::windowSwitcher.Launch("vscode"), showOverlay("Esc, +4", "Launch vscode")
	+5::windowSwitcher.Launch("notepad"), showOverlay("Esc, +5", "Launch notepad")
	+6::windowSwitcher.Launch("calendar"), showOverlay("Esc, +6", "Launch calendar")
#if

#if IsNone()
	CapsLock & 1::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(0), showOverlay("CapsLock & 1", "Switch to desktop #1")
	CapsLock & 2::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(1), showOverlay("CapsLock & 2", "Switch to desktop #2")
	CapsLock & 3::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(2), showOverlay("CapsLock & 3", "Switch to desktop #3")
	CapsLock & 4::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(3), showOverlay("CapsLock & 4", "Switch to desktop #4")
	CapsLock & 5::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(4), showOverlay("CapsLock & 5", "Switch to desktop #5")
	CapsLock & 6::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(5), showOverlay("CapsLock & 6", "Switch to desktop #6")
	CapsLock & 7::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(6), showOverlay("CapsLock & 7", "Switch to desktop #7")
	CapsLock & 8::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(7), showOverlay("CapsLock & 8", "Switch to desktop #8")
	CapsLock & 9::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(8), showOverlay("CapsLock & 9", "Switch to desktop #9")
	CapsLock & F1::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(0), showOverlay("CapsLock & F1", "Move active window to desktop #1")
	CapsLock & F2::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(1), showOverlay("CapsLock & F2", "Move active window to desktop #2")
	CapsLock & F3::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(2), showOverlay("CapsLock & F3", "Move active window to desktop #3")
	CapsLock & F4::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(3), showOverlay("CapsLock & F4", "Move active window to desktop #4")
	CapsLock & F5::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(4), showOverlay("CapsLock & F5", "Move active window to desktop #5")
	CapsLock & F6::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(5), showOverlay("CapsLock & F6", "Move active window to desktop #6")
	CapsLock & F7::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(6), showOverlay("CapsLock & F7", "Move active window to desktop #7")
	CapsLock & F8::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(7), showOverlay("CapsLock & F8", "Move active window to desktop #8")
	CapsLock & F9::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(8), showOverlay("CapsLock & F9", "Move active window to desktop #9")

	CapsLock & a::virtualDesktopEnhancer.SwitchToPreviousDesktopThenFocus(), showOverlay("CapsLock & a", "Switch to previous dekstop")
	CapsLock & s::virtualDesktopEnhancer.SwitchToNextDesktopThenFocus(), showOverlay("CapsLock & s", "Switch to next dekstop")

	CapsLock & q::virtualDesktopEnhancer.MoveActiveWindowToPreviousDekstopThenFocus(), showOverlay("CapsLock & q", "Move active window and switch to next dekstop")
	CapsLock & w::virtualDesktopEnhancer.MoveActiveWindowToNextDekstopThenFocus(), showOverlay("CapsLock & w", "Move active window and switch to next dekstop")

	CapsLock & c::virtualDesktopEnhancer.CreateDesktop(), showOverlay("CapsLock & c", "Create a new desktop")
	CapsLock & d::virtualDesktopEnhancer.DeleteCurrentDesktop(), showOverlay("CapsLock & d", "Delete current dekstop")

	CapsLock & z::virtualDesktopEnhancer.PinActiveWindow(), showOverlay("CapsLock & z", "Pin active window")
	CapsLock & x::virtualDesktopEnhancer.PinActiveApp(), showOverlay("CapsLock & x", "Pin active app")
#if

#if IsOnlyShift()	; Only Shift is pressed -> "Shift" window and dekstop
	CapsLock & 1::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(0), showOverlay("CapsLock, Shift + 1", "Move active window and switch to desktop #1")
	CapsLock & 2::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(1), showOverlay("CapsLock, Shift + 2", "Move active window and switch to desktop #2")
	CapsLock & 3::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(2), showOverlay("CapsLock, Shift + 3", "Move active window and switch to desktop #3")
	CapsLock & 4::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(3), showOverlay("CapsLock, Shift + 4", "Move active window and switch to desktop #4")
	CapsLock & 5::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(4), showOverlay("CapsLock, Shift + 5", "Move active window and switch to desktop #5")
	CapsLock & 6::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(5), showOverlay("CapsLock, Shift + 6", "Move active window and switch to desktop #6")
	CapsLock & 7::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(6), showOverlay("CapsLock, Shift + 7", "Move active window and switch to desktop #7")
	CapsLock & 8::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(7), showOverlay("CapsLock, Shift + 8", "Move active window and switch to desktop #8")
	CapsLock & 9::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(8), showOverlay("CapsLock, Shift + 9", "Move active window and switch to desktop #9")

	CapsLock & a::virtualDesktopEnhancer.MoveActiveWindowAndSwitchToPreviousDesktopThenFocus(), showOverlay("CapsLock, Shift + a", "Switch to previous dekstop")
	CapsLock & s::virtualDesktopEnhancer.MoveActiveWindowAndSwitchToNextDesktopThenFocus(), showOverlay("CapsLock, Shift + s", "Switch to next dekstop")

	CapsLock & z::virtualDesktopEnhancer.UnpinActiveWindow(), showOverlay("CapsLock, Shift + z", "Unpin active window")
	CapsLock & x::virtualDesktopEnhancer.UnpinActiveApp(), showOverlay("CapsLock, Shift + x", "Unpin active app")
#if

#if IsOnlyCtrl()
	CapsLock & a::virtualDesktopEnhancer.MoveAllWindowToNewDesktop(), showOverlay("CapsLock, Ctrl + a", "Move all windows to new desktop")
	CapsLock & z::virtualDesktopEnhancer.ToggleWindowPinning(), showOverlay("CapsLock, Ctrl + z", "Toggle window pinning")
	CapsLock & x::virtualDesktopEnhancer.ToggleAppPinning(), showOverlay("CapsLock, Ctrl + x", "Toggle app pining")
#if

~WheelUp::virtualDesktopEnhancer.TaskbarScrollUp()
~WheelDown::virtualDesktopEnhancer.TaskbarScrollDown()

#If IsNone()
	~MButton & z::windowQuickMinMax.MinimizeActiveWindow(), showOverlay("~MButton & z", "Minimize active window")
	~MButton & x::windowQuickMinMax.MaximizeActiveWindow(), showOverlay("~MButton & x", "Maximize active window")
#if

#If IsOnlyCtrl()
	~MButton & z::windowQuickMinMax.MinimizeWindowUnderMouse(), showOverlay("~MButton & Ctrl + z", "Minimize window under mouse")
	~MButton & x::windowQuickMinMax.MaximizeWindowUnderMouse(), showOverlay("~MButton & Ctrl + x", "Maximize window under mouse")
#if

#if IsOnlyShift()
	~MButton & z::windowQuickMinMax.Restore(), showOverlay("~MButton & Shift + z", "Restore previously minimized/maximized window")
	~MButton & x::windowQuickMinMax.ClearHistory(), showOverlay("~MButton & Shift + x", "Clear history stack")
#if

showOverlay(label, description)
{
	global _enableOverlay
	if (_enableOverlay)
	{
		overlay.Show(HumanizeHotkey(label), description)
	}
}