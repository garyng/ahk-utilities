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
; - On Esc:: ;#; 
#if GetKeyState("Esc", "P")	
	F1::switcher.Switch("xyplorer")	;#; Switch to xyplorer
	F2::switcher.Switch("firefox")	;#; Switch to firefox
	F3::switcher.Switch("onenote")	;#; Switch to onenote
	F4::switcher.Switch("gitkraken")	;#; Switch to gitkraken
	F5::switcher.Switch("sublime")	;#; Switch to sublime
	F6::switcher.Switch("keepass")	;#; Switch to keepass

	+F1::switcher.Launch("xyplorer")
	+F2::switcher.Launch("firefox")
	+F3::switcher.Launch("onenote")
	+F4::switcher.Launch("gitkraken")
	+F5::switcher.Launch("sublime")
	+F6::switcher.Launch("keepass")

	1::switcher.Switch("visualstudio")	;#; Switch to visual studio
	2::switcher.Switch("todoist")	;#; Switch to todoist
	3::switcher.Switch("cmder")	;#; Switch to cmder
	4::switcher.Switch("vscode")	;#; Switch to vscode
	5::switcher.Switch("notepad")	;#; Switch to notepad

	+1::switcher.Launch("visualstudio")
	+2::switcher.Launch("todoist")
	+3::switcher.Launch("cmder")
	+4::switcher.Launch("vscode")
	+5::switcher.Launch("notepad")
#if
; - On Esc:: ;#;