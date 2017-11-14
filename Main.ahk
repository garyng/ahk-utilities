#InstallKeybdHook
#SingleInstance Force
#Persistent
#Warn
#NoEnv

#Include Externals.ahk
#Include Functions.ahk
#Include WindowSwitcher.ahk

RunExternals()

switcher := new WindowSwitcher()

; Reload script
^+!R::Reload

; Type datetime
:*:!!d::
	TypeDateTime()
	return

!F1::ToggleActiveWindowAlwaysOnTop()
!WheelDown::DecreaseTransparencyOfWindowUnderMouse()
!WheelUp::IncreaseTransparencyOfWindowUnderMouse()
!F2::ResetTransparencyOfWindowUnderMouse()

; add new entries in WindowsSwticher
#1::switcher.Switch("xyplorer")
#2::switcher.Switch("firefox")
#3::switcher.Switch("onenote")
#4::switcher.Switch("gitkraken")
#5::switcher.Switch("chrome")

CapsLock & 1::switcher.Switch("visualstudio")
CapsLock & 2::switcher.Switch("todoist")
; todoist
; sublimetext
; cmder
; notepad