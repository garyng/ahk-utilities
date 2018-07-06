TypeDateTime()
{
    FormatTime, current, , dd/MM/yyyy HH:mm:ss
	SendInput %current%
}

TypeGitClone()
{
	text := AppendWithClipboardContent("git clone ")
	SendInput %text%
}

TypeMarkdownImageTag()
{
	text := "{Raw}![](" . Clipboard . ")"
	SendInput %text%
}

TypeClipboard()
{
	text := Clipboard
	SendInput %text%
}

TypeRandomNumber()
{
	Random, num
	SendInput %num%
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

HumanizeHotkey(label)
{
	replacement := {}
	replacement["~"] := ""
	replacement["+"] := "Shift + "	
	replacement["#"] := "Win + "
	replacement["!"] := "Alt + "
	replacement["^"] := "Ctrl + "
	replacement[" &"] := ","
	For search, replace in replacement
	{
		label := StrReplace(label, search, replace)
	}
	return label
}

AppendWithClipboardContent(text)
{
	return text . Clipboard
}

AskIfTurnOffMonitor()
{
	_prompt := new Prompt()	
	If (_prompt.PromptMatchSpace("Turn off monitor?", "turn off"))
	{
		TurnOffMonitor()
		return true
	}
	return false
}

TurnOffMonitor()
{
	DllCall("LockWorkStation")
	; 0x112 = WM_SYSCOMMAND
	; 0xF170 = SC_MONITORPOWER
	SendMessage 0x112, 0xF170, 2, , Program Manager
}

ScrollLeft()
{
	ControlGetFocus, control, A
	Loop, 10 {	
		PostMessage, 0x114, 0, 0, %control%, A
		; 0x114 =  WM_HSCROLL 
	}
}

ScrollRight()
{
	ControlGetFocus, control, A
	Loop, 10 {	
		PostMessage, 0x114, 1, 0, %control%, A
		; 0x114 =  WM_HSCROLL 
	}
}

DisableAltMenuAccelerator(key, upOrDown)
{
	; from Taran the Marco King https://github.com/TaranVH/2nd-keyboard/blob/master/Taran's%20Windows%20Mods/Alt_menu_acceleration_DISABLER.ahk
	SendInput {%key% %upOrDown%}
	SendInput {SC0E8 %upOrDown%}
	KeyWait %key%
}

goBack()
{
	If (WinActive("ahk_exe Station.exe"))
	{
		SendInput ^[
		return
	}
	If (WinActive("ahk_exe devenv.exe"))
	{
		; go back to last cursor position
		SendInput ^-
		return
	}
	If (WinActive("ahk_exe Code.exe"))
	{
		SendInput {Browser_Back}
		return
	}
	SendInput !{Left}
}

goForward()
{
	If (WinActive("ahk_exe Station.exe"))
	{
		SendInput ^]
		return
	}
	If (WinActive("ahk_exe devenv.exe"))
	{
		; go to the next cursor position
		SendInput ^+-
		return
	}
	If (WinActive("ahk_exe Code.exe"))
	{
		SendInput {Browser_Forward}
		return
	}
	SendInput !{Right}
}