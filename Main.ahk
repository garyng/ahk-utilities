#InstallKeybdHook
#SingleInstance Force
#Persistent
#Warn

#Include, HotStrings.ahk

; Toggle Always on top + Transparency
!F1::	; Alt + F1
	WinGet, activeWindow, ID, A
	WinGet, style, ExStyle, ahk_id %activeWindow%
	if (style & 0x8)	; 0x8 WX_EX_TOPMOST
	{
		WinSet, AlwaysOnTop, off, ahk_id %activeWindow%
		WinSet, Transparent, 255, ahk_id %activeWindow%
	}
	else
	{
		WinSet, AlwaysOnTop, on, ahk_id %activeWindow%
		WinSet, Transparent, 200, ahk_id %activeWindow%
	}
	return

; Decrease transparency of window under mouse
!WheelDown::
	MouseGetPos,,, windowUnderMouse
	WinGet, transparency, Transparent, ahk_id %windowUnderMouse%
	transparency -= 10
	transparency := transparency < 100 ? 100 : transparency
	WinSet, Transparent, %transparency%, ahk_id %windowUnderMouse%
	return

; Increase transparency of window under mouse
!WheelUp::
	MouseGetPos,,, windowUnderMouse
	WinGet, transparency, Transparent, ahk_id %windowUnderMouse%
	transparency += 10	; weird 
	WinSet, Transparent, %transparency%, ahk_id %windowUnderMouse%
	return

; Reset transparency of window under mouse
!F2::
	MouseGetPos,,, windowUnderMouse
	WinSet, Transparent, 255, ahk_id %windowUnderMouse%
	return