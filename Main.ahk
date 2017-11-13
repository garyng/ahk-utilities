#InstallKeybdHook
#SingleInstance Force
#Persistent
#Warn
#NoEnv

#Include Externals.ahk
#Include Functions.ahk

RunExternals()

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