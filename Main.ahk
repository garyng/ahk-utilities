#InstallKeybdHook
#UseHook
#SingleInstance Force
#Persistent
#Warn
#NoEnv

#WinActivateForce

DetectHiddenWindows, On
SetBatchLines -1

#Include Externals.ahk
#Include Functions.ahk
; Prompt.ahk is used by multiple scripts - must load this first
#Include Prompt.ahk
#Include WindowSwitcher.ahk
#Include KeyLister.ahk
#Include VirtualDesktopEnhancer.ahk

RunExternals()

lister := new KeyLister(A_ScriptFullPath, A_WorkingDir "\SnapX\SnapX.ahk")
windowSwitcher := new WindowSwitcher()
virtualDesktopEnhancer := new VirtualDesktopEnhancer()

^+!R::Reload	;#; Reload script

:*:!!d::	;#; Type datetime
	TypeDateTime()
	return

!F1::ToggleActiveWindowAlwaysOnTop()	;#; Toggle active window always on top
!WheelDown::DecreaseTransparencyOfWindowUnderMouse()	;#; Decrease the transparency of window under mouse
!WheelUp::IncreaseTransparencyOfWindowUnderMouse()	;#; Increase the transparency of window under mouse
!F2::ResetTransparencyOfWindowUnderMouse()	;#; Reset the transparency of window under mouse

#F1::lister.Show()	;#; List all hotkeys and hotstrings
; add new entries in WindowsSwticher
; - On Esc:: ;#; 
#if GetKeyState("Esc", "P")
	F1::windowSwitcher.Switch("xyplorer")	;#; Switch to xyplorer
	F2::windowSwitcher.Switch("firefox")	;#; Switch to firefox
	F3::windowSwitcher.Switch("onenote")	;#; Switch to onenote
	F4::windowSwitcher.Switch("gitkraken")	;#; Switch to gitkraken
	F5::windowSwitcher.Switch("sublime")	;#; Switch to sublime
	F6::windowSwitcher.Switch("keepass")	;#; Switch to keepass

	+F1::windowSwitcher.Launch("xyplorer")
	+F2::windowSwitcher.Launch("firefox")
	+F3::windowSwitcher.Launch("onenote")
	+F4::windowSwitcher.Launch("gitkraken")
	+F5::windowSwitcher.Launch("sublime")
	+F6::windowSwitcher.Launch("keepass")

	1::windowSwitcher.Switch("visualstudio")	;#; Switch to visual studio
	2::windowSwitcher.Switch("todoist")	;#; Switch to todoist
	3::windowSwitcher.Switch("cmder")	;#; Switch to cmder
	4::windowSwitcher.Switch("vscode")	;#; Switch to vscode
	5::windowSwitcher.Switch("notepad")	;#; Switch to notepad

	+1::windowSwitcher.Launch("visualstudio")
	+2::windowSwitcher.Launch("todoist")
	+3::windowSwitcher.Launch("cmder")
	+4::windowSwitcher.Launch("vscode")
	+5::windowSwitcher.Launch("notepad")
#if
; - On Esc:: ;#;

#if !GetKeyState("Shift", "P") && !GetKeyState("Ctrl", "P")
	CapsLock & 1::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(0)	;#; Switch to desktop #1
	CapsLock & 2::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(1)	;#; Switch to desktop #2
	CapsLock & 3::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(2)	;#; Switch to desktop #3
	CapsLock & 4::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(3)	;#; Switch to desktop #4
	CapsLock & 5::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(4)	;#; Switch to desktop #5
	CapsLock & 6::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(5)	;#; Switch to desktop #6
	CapsLock & 7::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(6)	;#; Switch to desktop #7
	CapsLock & 8::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(7)	;#; Switch to desktop #8
	CapsLock & 9::virtualDesktopEnhancer.SwitchToDesktopNThenFocus(8)	;#; Switch to desktop #9
	CapsLock & F1::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(0)	;#; Move active window to desktop #1
	CapsLock & F2::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(1)	;#; Move active window to desktop #2
	CapsLock & F3::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(2)	;#; Move active window to desktop #3
	CapsLock & F4::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(3)	;#; Move active window to desktop #4
	CapsLock & F5::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(4)	;#; Move active window to desktop #5
	CapsLock & F6::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(5)	;#; Move active window to desktop #6
	CapsLock & F7::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(6)	;#; Move active window to desktop #7
	CapsLock & F8::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(7)	;#; Move active window to desktop #8
	CapsLock & F9::virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(8)	;#; Move active window to desktop #9

	CapsLock & a::virtualDesktopEnhancer.SwitchToPreviousDesktopThenFocus()	;#; Switch to previous dekstop
	CapsLock & s::virtualDesktopEnhancer.SwitchToNextDesktopThenFocus()	;#; Switch to next dekstop

	CapsLock & q::virtualDesktopEnhancer.MoveActiveWindowToPreviousDekstopThenFocus()	;#; Move active window and switch to next dekstop
	CapsLock & w::virtualDesktopEnhancer.MoveActiveWindowToNextDekstopThenFocus()	;#; Move active window and switch to next dekstop

	CapsLock & c::virtualDesktopEnhancer.CreateDesktop()	;#; Create a new desktop
	CapsLock & d::virtualDesktopEnhancer.DeleteCurrentDesktop()	;#; Delete current dekstop

	CapsLock & z::virtualDesktopEnhancer.PinActiveWindow()	;#; Pin active window
	CapsLock & x::virtualDesktopEnhancer.PinActiveApp()	;#; Pin active app
#if

; - On Shift:: ;#; 	
#if GetKeyState("Shift", "P") && !GetKeyState("Ctrl", "P")	; Only Shift is pressed -> "Shift" window and dekstop
	CapsLock & 1::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(0)	;#; Move active window and switch to desktop #1 
	CapsLock & 2::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(1)	;#; Move active window and switch to desktop #2 
	CapsLock & 3::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(2)	;#; Move active window and switch to desktop #3 
	CapsLock & 4::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(3)	;#; Move active window and switch to desktop #4 
	CapsLock & 5::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(4)	;#; Move active window and switch to desktop #5 
	CapsLock & 6::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(5)	;#; Move active window and switch to desktop #6 
	CapsLock & 7::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(6)	;#; Move active window and switch to desktop #7 
	CapsLock & 8::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(7)	;#; Move active window and switch to desktop #8 
	CapsLock & 9::virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(8)	;#; Move active window and switch to desktop #9 

	CapsLock & a::virtualDesktopEnhancer.MoveActiveWindowAndSwitchToPreviousDesktopThenFocus()	;#; Switch to previous dekstop
	CapsLock & s::virtualDesktopEnhancer.MoveActiveWindowAndSwitchToNextDesktopThenFocus()	;#; Switch to next dekstop

	CapsLock & z::virtualDesktopEnhancer.UnpinActiveWindow()	;#; Unpin active window
	CapsLock & x::virtualDesktopEnhancer.UnpinActiveApp()	;#; Unpin active app	
#if
; - On Shift:: ;#; 

; - On Ctrl:: ;#; 
#if !GetKeyState("Shift", "P") && GetKeyState("Ctrl", "P")	; Only Ctrl is pressed
	CapsLock & z::virtualDesktopEnhancer.ToggleWindowPinning()	;#; Toggle window pinning
	CapsLock & x::virtualDesktopEnhancer.ToggleAppPinning()	;#; Toggle app pining
#if
; - On Ctrl:: ;#; 

~WheelUp::virtualDesktopEnhancer.TaskbarScrollUp()
~WheelDown::virtualDesktopEnhancer.TaskbarScrollDown()