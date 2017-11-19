#InstallKeybdHook
#SingleInstance Force
#Persistent
#Warn
#NoEnv
SetBatchLines -1

#Include Externals.ahk
#Include Functions.ahk
; Prompt.ahk is used by multiple scripts - must load this first
#Include Prompt.ahk
#Include WindowSwitcher.ahk
#Include DesktopSwitcher.ahk
#Include KeyLister.ahk

RunExternals()

lister := new KeyLister(A_ScriptFullPath, A_WorkingDir "\SnapX\SnapX.ahk")
windowSwitcher := new WindowSwitcher()
desktopSwitcher := new DesktopSwitcher()

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

CapsLock & 1::desktopSwitcher.switchDesktopByNumber(1)	;#; Switch to desktop #1
CapsLock & 2::desktopSwitcher.switchDesktopByNumber(2)	;#; Switch to desktop #2
CapsLock & 3::desktopSwitcher.switchDesktopByNumber(3)	;#; Switch to desktop #3
CapsLock & 4::desktopSwitcher.switchDesktopByNumber(4)	;#; Switch to desktop #4
CapsLock & 5::desktopSwitcher.switchDesktopByNumber(5)	;#; Switch to desktop #5
CapsLock & 6::desktopSwitcher.switchDesktopByNumber(6)	;#; Switch to desktop #6
CapsLock & 7::desktopSwitcher.switchDesktopByNumber(7)	;#; Switch to desktop #7
CapsLock & 8::desktopSwitcher.switchDesktopByNumber(8)	;#; Switch to desktop #8
CapsLock & 9::desktopSwitcher.switchDesktopByNumber(9)	;#; Switch to desktop #9
CapsLock & s::desktopSwitcher.switchToNextDesktop()	;#; Switch to next desktop
CapsLock & a::desktopSwitcher.switchToPreviousDesktop()	;#; Switch to previous desktop
CapsLock & c::desktopSwitcher.createVirtualDesktop()	;#; Create a new desktop
CapsLock & d::desktopSwitcher.deleteVirtualDesktop()	;#; Delete current dekstop