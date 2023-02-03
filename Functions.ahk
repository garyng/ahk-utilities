TypeDateTime()
{
    FormatTime, current, , dd/MM/yyyy HH:mm:ss
	SendInput %current%
}

TypeShortDate()
{
    FormatTime, current, , ddMMyyyy
	SendInput %current%
}

TypeFileDate()
{
	FormatTime, current, , yyyy-MM-dd_
	SendInput, %current%
}

TypeFileDateTime()
{
	FormatTime, current, , yyyy-MM-ddTHH.mm.ss_
	SendInput, %current%
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

TypeCustIdQuery()
{
	text := "SELECT * `nFROM t_cust_location WHERE cust_id = " . Clipboard
	SendInput %text%
}

TypeJira()
{
	text := "https://jira.cheetahmail.com/browse/" . Clipboard
	SendInput %text%
}

TypeZettelkastenUid()
{
	FormatTime, current, , yyyyMMddHHmmss
	SendInput %current%
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
	; replace all '+' to 'Shift +' first
	label := RegExReplace(label, "\+(?!\s)", "Shift + ")

	replacement := {}
	replacement["~"] := ""
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

RestartExplorer()
{
	; ref: https://www.autohotkey.com/boards/viewtopic.php?t=81252


	; WM_USER+436
	; same as "Exit Explorer" when Ctrl + Shift + Right click on taskbar
	; ref: https://stackoverflow.com/a/10438722/1023180
	PostMessage, 0x5B4, 0, 0,, ahk_class Shell_TrayWnd

	WinGet, pid, PID, ahk_class Progman
	WinGet, explorerPath, ProcessPath, ahk_pid %pid%
	Process, WaitClose, %pid%, 15
	if (!ErrorLevel)
	{
		Run, %explorerPath%
	}	
}