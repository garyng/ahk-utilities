#Include Prompt.ahk

class WindowSwitcher
{
	; _windows
	; _prompt
	__New()
	{
		this._prompt := new Prompt()
		this._windows := {}
		; add new entries
		this._windows["notepad"] := new Window("ahk_class Notepad", "notepad.exe")
		; this will alt-tab when firefox is active
		; this._windows["firefox"] := new AltTabWindow("MozillaWindowClass", "firefox.exe")
		this._windows["firefox"] := new Window("ahk_class MozillaWindowClass", "C:\\Program Files\\Mozilla Firefox\\firefox.exe")
		this._windows["xyplorer"] := new Window("ahk_class ThunderRT6FormDC", "XYplorer.exe")
		this._windows["explorer"] := new Window("ahk_class CabinetWClass", "explorer.exe")
		; need to use ahk_exe for chrome as other electron apps also uses chrome (which has the same ahk_class)
		this._windows["chrome"] := new Window("ahk_exe chrome.exe", "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe --high-dpi-support=1 --force-device-scale-factor=1")
		this._windows["gitkraken"] := new Window("ahk_exe gitkraken.exe", "C:\\Users\\GaryNg\\AppData\\Local\\gitkraken\\Update.exe --processStart ""gitkraken.exe""", "gitkraken.exe")
		this._windows["onenote"] := new Window("ahk_exe onenote.exe", "onenote.exe")
		this._windows["visualstudio"] := new Window("ahk_exe devenv.exe", "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Enterprise\\Common7\\IDE\\devenv.exe")
		; todoist is a Windows 10 app, need to be launched by its ApplicationUserModelId
		this._windows["todoist"] := new Window("Todoist: To-Do List and Task Manager ahk_class ApplicationFrameWindow","explorer.exe shell:AppsFolder\88449BC3.TodoistTo-DoListTaskManager_71ef4824z52ta!App")
		this._windows["cmder"] := new Window("ahk_class VirtualConsoleClass ahk_exe ConEmu64.exe", "D:\Tools\cmder\Cmder.exe")
		this._windows["vscode"] := new Window("ahk_exe Code.exe", "C:\\Users\\GaryNg\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe")
		this._windows["sublime"] := new Window("ahk_exe sublime_text.exe", "C:\\Program Files\\Sublime Text 3\\sublime_text.exe")
		this._windows["keepass"] := new Window("ahk_exe KeePass.exe", "C:\\Program Files (x86)\\KeePass\\KeePass.exe")
		this._windows["calendar"] := new FuzzyMatchWindow("Calendar ahk_class ApplicationFrameWindow","explorer.exe shell:AppsFolder\microsoft.windowscommunicationsapps_8wekyb3d8bbwe!microsoft.windowslive.calendar")
		this._windows["wt"] := new Window("ahk_exe WindowsTerminal.exe", "C:\\Users\\GaryNg\\AppData\\Local\\Microsoft\\WindowsApps\\wt.exe")

		; ahk_class is not used because slide show uses different class name (screenclass) compared to the main program (PPTFrameClass)
		this._windows["powerpoint"] := new Window("ahk_exe POWERPNT.EXE", "C:\\Program Files\\Microsoft Office\\root\\Office16\\POWERPNT.EXE")
		this._windows["toggl"] := new Window("ahk_exe TogglDesktop.exe", "C:\\Users\\GaryNg\\AppData\\Local\\TogglDesktop\\TogglDesktop.exe")
		this._windows["itunes"] := new Window("ahk_class iTunes", "C:\\Program Files\\iTunes\\iTunes.exe")

		this._windows["todoist_firefox"] := new FuzzyMatchWindow("Todoist ahk_exe firefox.exe", "C:\\Program Files\\Mozilla Firefox\\firefox.exe https://en.todoist.com/")
		this._windows["asana_firefox"] := new FuzzyMatchWindow("Asana ahk_exe firefox.exe", "C:\\Program Files\\Mozilla Firefox\\firefox.exe https://app.asana.com/")
		this._windows["slack"] := new Window("ahk_exe slack.exe", "C:\\Users\\GaryNg\\AppData\\Local\\slack\\slack.exe")
		this._windows["station"] := new Window("ahk_exe Station.exe", "C:\\Users\\GaryNg\\AppData\\Local\\browserX\\Station.exe")
		this._windows["source_tree"] := new Window("ahk_exe SourceTree.exe", "C:\\Users\\GaryNg\\AppData\\Local\\SourceTree\\SourceTree.exe")

		this._windows["calendar_firefox"] := new FuzzyMatchWindow("Multimedia University ahk_exe firefox.exe", "C:\\Program Files\\Mozilla Firefox\\firefox.exe https://calendar.google.com/calendar/b/1/r/day")
		this._windows["fork"] := New Window("ahk_exe fork.exe", "C:\\Users\\GaryNg\\AppData\\Local\\Fork\\fork.exe")
		this._windows["datagrip"] := New Window("ahk_exe datagrip64.exe", "C:\\Users\\GaryNg\\AppData\\Local\\JetBrains\\Toolbox\\apps\\datagrip\\ch-0\\201.8538.4\\bin\\datagrip64.exe")
		
		this._windows["tasks"] := new HwndMatchWindow("tasks", "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe --high-dpi-support=1 --force-device-scale-factor=1")
		this._windows["local"] := new HwndMatchWindow("local", "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe --high-dpi-support=1 --force-device-scale-factor=1")
		this._windows["placeholder1"] := new HwndMatchWindow("placeholder1", "")
		this._windows["ccmp_vs"] := new Window("xyz ahk_exe devenv.exe", "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Enterprise\\Common7\\IDE\\devenv.exe")
		this._windows["ccmp_vscode"] := new FuzzyMatchWindow("ccmp - ahk_exe Code.exe", "C:\\Users\\GaryNg\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe")
		this._windows["tickets_vscode"] := new FuzzyMatchWindow("tickets - ahk_exe Code.exe", "C:\\Users\\GaryNg\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe")
		this._windows["ccmp_wt"] := new HwndMatchWindow("ccmp wt", "C:\\Users\\GaryNg\\AppData\\Local\\Microsoft\\WindowsApps\\wt.exe")

	}

	Switch(name)
	{
		win := this._windows[name]
		
		if (!win.Exist() and this.ConfirmLaunch(name))
		{
			win.Launch()
			Sleep, 500
		}
		win.Switch()
	}

	Reset(name)
	{
		win := this._windows[name]
		win.Reset()
	}

	Launch(name)
	{
		win := this._windows[name]
		if (this.ConfirmLaunch(name))
		{
			win.Launch()
		}
	}

	ConfirmLaunch(name)
	{
		return this._prompt.PromptMatchSpace("Launch " . name . "?", "launch")
	}
}

class Window
{
	; _identifier
	; _filePath
	; _groupName
	; _lastActiveHwnd

	; by default `identifier` uses ahk_class
	__New(identifier, filePath)
	{
		this._identifier := identifier
		this._filePath := filePath
		this.InitGroup()
	}

	InitGroup()
	{
		; remove all illegal characters
		this._groupName := RegExReplace(this._identifier, "[_\\\.\*\?\+\[\{\|\(\)\^\$\""\s\:\-]")  . "_group"
		GroupAdd, % this._groupName , % this._identifier
	}

	Exist()
	{
		return this.GetHwnd() != 0
	}

	Launch()
	{
		Run % this._filePath
	}

	Switch()
	{
		hwnd := this.GetHwnd()

		if (this.IsActive(hwnd))
		{
			if (this.GetGroupCount() == 1)
			{
				this.MinimizeActiveWindow(hwnd)

				; Minimizing window wont lost focus
				WinActivate, % "ahk_id" . this._lastActiveHwnd
			}
			else
			{
				this.CycleActiveWindows()
			}
		}
		else
		{
			this._lastActiveHwnd := WinExist("A")

			this.ActivateWindow()
		}
	}

	Reset()
	{
		; noop, only used for HwndWindow
	}

	GetGroupCount()
	{
		WinGet, itemsCount, Count, % "ahk_group " . this._groupName
		return itemsCount
	}

	MinimizeActiveWindow(hwnd)
	{
		WinMinimize % "ahk_id " . hwnd
	}

	CycleActiveWindows()
	{
		; default behaviour when there is active window is to cycle through all windows 
		GroupActivate % this._groupName, R
	}

	ActivateWindow()
	{
		WinActivate % this._identifier
	}

	GetHwnd()
	{
		return WinExist(this._identifier)
	}

	IsActive(hwnd)
	{
		return WinActive("ahk_id " . hwnd)
	}

}

class AltTabWindow extends Window
{
	; can be used for chrome/firefox
	; create new class and override the function to suite your own needs
	CycleActiveWindows()
	{
		Send % "^{tab}"
	}
}

class FuzzyMatchWindow extends Window
{
	GetGroupCount()
	{
		SetTitleMatchMode 2

		WinGet, itemsCount, Count, % "ahk_group " . this._groupName

		SetTitleMatchMode 1

		return itemsCount
	}

	ActivateWindow()
	{
		SetTitleMatchMode 2

		WinActivate % this._identifier

		SetTitleMatchMode 1
	}

	GetHwnd()
	{
		SetTitleMatchMode 2 ; A window's title can contain WinTitle anywhere inside it to be a match. 
		result := WinExist(this._identifier)
		SetTitleMatchMode 1
		return result		
	}
}

class HwndMatchWindow extends Window
{
	__New(name, filePath)
	{
		this._config := new Config("hwnd-" . name)
		this._name := name
		this._prompt := new Prompt()
		this.Load()
		base.__New(this._identifier, filePath)
	}

	Load()
	{
		identifier := this._config.Read("identifier")
		if (WinExist(identifier))
		{
			this._identifier := identifier
		}
		else
		{
			this.Reset()
		}
	}

	Save()
	{
		this._config.Write("identifier", this._identifier)
	}

	Reset()
	{
		this._identifier := ""
		this.Save()
	}

	Switch()
	{
		this.SetIdentifier()
		base.Switch()
	}

	SetIdentifier()
	{
		if (this._identifier)
		{
			return
		}
		
		WinGet, hwnd, ID, A
		WinGet, pid, PID, A
		WinGet, exe, ProcessName, A
		text := "Set " . this._name . " to " . hwnd . "?`n" . exe . ", " . pid
		
		if (!this._prompt.PromptMatchInput(text, " "))
		{
			return
		}

		this._identifier := "ahk_id " . hwnd
		this.InitGroup()
		this.Save()
	}

	Launch()
	{
		this.Reset()
		base.Launch()
	}

	Exist()
	{
		if (!this._identifier) 
		{
			return True
		}
		return base.Exist()
	}
}