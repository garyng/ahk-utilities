TypeDateTime()
{
    FormatTime, current, , dd/MM/yyyy HH:mm:ss
	Send %current%
	return
}

ToggleActiveWindowAlwaysOnTop()
{
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
}

DecreaseTransparencyOfWindowUnderMouse()
{
    MouseGetPos,,, windowUnderMouse
	WinGet, transparency, Transparent, ahk_id %windowUnderMouse%
	transparency -= 10
	transparency := transparency < 100 ? 100 : transparency
	WinSet, Transparent, %transparency%, ahk_id %windowUnderMouse%
}

IncreaseTransparencyOfWindowUnderMouse()
{
    MouseGetPos,,, windowUnderMouse
	WinGet, transparency, Transparent, ahk_id %windowUnderMouse%
	transparency += 10	; weird 
	WinSet, Transparent, %transparency%, ahk_id %windowUnderMouse%
}

ResetTransparencyOfWindowUnderMouse()
{
    MouseGetPos,,, windowUnderMouse
	WinSet, Transparent, 255, ahk_id %windowUnderMouse%
	return
}