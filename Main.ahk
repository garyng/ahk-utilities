#InstallKeybdHook
#SingleInstance Force
#Persistent
#Warn
#NoEnv
SetBatchLines -1

#Include Externals.ahk
#Include Functions.ahk
#Include Prompt.ahk
#Include WindowSwitcher.ahk
#Include KeyLister.ahk

RunExternals()

lister := new KeyLister(A_ScriptFullPath, A_WorkingDir "\SnapX\SnapX.ahk")
switcher := new WindowSwitcher()

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
#1::switcher.Switch("xyplorer")	;#; Switch to xyplorer
#2::switcher.Switch("firefox")	;#; Switch to firefox
#3::switcher.Switch("onenote")	;#; Switch to onenote
#4::switcher.Switch("gitkraken")	;#; Switch to gitkraken
#5::switcher.Switch("sublime")	;#; Switch to sublime
#6::switcher.Switch("keepass")	;#; Switch to keepass

#+1::switcher.Launch("xyplorer")
#+2::switcher.Launch("firefox")
#+3::switcher.Launch("onenote")
#+4::switcher.Launch("gitkraken")
#+5::switcher.Launch("sublime")
#+6::switcher.Launch("keepass")

CapsLock & 1::switcher.Switch("visualstudio")	;#; Switch to visual studio
CapsLock & 2::switcher.Switch("todoist")	;#; Switch to todoist
CapsLock & 3::switcher.Switch("cmder")	;#; Switch to cmder
CapsLock & 4::switcher.Switch("vscode")	;#; Switch to vscode
CapsLock & 5::switcher.Switch("notepad")	;#; Switch to notepad

#if GetKeyState("Shift", "P")
CapsLock & 1::switcher.Launch("visualstudio")
CapsLock & 2::switcher.Launch("todoist")
CapsLock & 3::switcher.Launch("cmder")
CapsLock & 4::switcher.Launch("vscode")
CapsLock & 5::switcher.Launch("notepad")
#if