#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn   ; Enable warnings to assist with detecting common errors.
#SingleInstance force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Third-party libraries

#Include Include\WinGetPosEx.ahk
#Include Include\Const_WinUser.ahk

; SnapX modules

#Include Modules\Settings.ahk
#Include Modules\Debug.ahk
#Include Modules\Tray.ahk
#Include Modules\Functions.ahk
#Include Modules\Classes.ahk
#Include Modules\Snapper.ahk
#Include Modules\AboutGui.ahk
#Include Modules\SettingsGui.ahk
#Include Modules\HelpGui.ahk

; Startup

Tray.initIcon()

settings := new Settings()
debug := new Debug(settings)

snapper := new Snapper(settings)
tray := new Tray(settings, { version: "1.1.4" }, snapper)

#MaxThreadsBuffer On

; horizontal sizing and direction
#Left::snapper.moveWindow(0, -1, 0, 0, 0)  ; move left
#!Left::snapper.moveWindow(0, -1, 0, 0, 0) ; move left
#Right::snapper.moveWindow(0, 1, 0, 0, 0)  ; move right
#!Right::snapper.moveWindow(0, 1, 0, 0, 0) ; move right
#Up::snapper.moveWindow(0, 0, 1, 0, 0)     ; increase width
#Down::snapper.moveWindow(0, 0, -1, 0, 0)  ; decrease width

; vertical sizing and direction
#!Up::snapper.moveWindow(0, 0, 0, -1, 0)   ; move up
#!Down::snapper.moveWindow(0, 0, 0, 1, 0)  ; move down
#PgUp::snapper.moveWindow(0, 0, 0, 0, 1)   ; size height toward top
#PgDn::snapper.moveWindow(0, 0, 0, 0, -1)  ; size height toward bottom

; movement between multiple monitors
; 	sleep allows time for Windows to do the movement to the new monitor before we re-snap according to the new monitor's width/height
~#+Left::
	Sleep, 10
	snapper.moveWindow(0, 0, 0, 0, 0)
	return
~#+Right::
	Sleep, 10
	snapper.moveWindow(0, 0, 0, 0, 0)
	return