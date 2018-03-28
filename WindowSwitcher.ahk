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
		; need to use ahk_exe for chrome as other electron apps also uses chrome (which has the same ahk_class)
		this._windows["chrome"] := new AltTabWindow("ahk_exe chrome.exe", "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe --high-dpi-support=1 --force-device-scale-factor=1")
		this._windows["gitkraken"] := new Window("ahk_exe gitkraken.exe", "C:\\Users\\GaryNg\\AppData\\Local\\gitkraken\\Update.exe --processStart ""gitkraken.exe""", "gitkraken.exe")
		this._windows["onenote"] := new Window("ahk_exe onenote.exe", "onenote.exe")
		this._windows["visualstudio"] := new Window("ahk_exe devenv.exe", "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Enterprise\\Common7\\IDE\\devenv.exe")
		; todoist is a Windows 10 app, need to be launched by its ApplicationUserModelId
		this._windows["todoist"] := new Window("Todoist: To-Do List and Task Manager ahk_class ApplicationFrameWindow","explorer.exe shell:AppsFolder\88449BC3.TodoistTo-DoListTaskManager_71ef4824z52ta!App")
		this._windows["cmder"] := new Window("ahk_class VirtualConsoleClass ahk_exe ConEmu64.exe", "D:\Tools\cmder\Cmder.exe")
		this._windows["vscode"] := new Window("ahk_exe Code.exe", "C:\\Program Files\\Microsoft VS Code\\Code.exe")
		this._windows["sublime"] := new Window("ahk_exe sublime_text.exe", "C:\\Program Files\\Sublime Text 3\\sublime_text.exe")
		this._windows["keepass"] := new Window("ahk_exe KeePass.exe", "C:\\Program Files (x86)\\KeePass\\KeePass.exe")
		this._windows["calendar"] := new FuzzyMatchWindow("Calendar ahk_class ApplicationFrameWindow","explorer.exe shell:AppsFolder\microsoft.windowscommunicationsapps_8wekyb3d8bbwe!microsoft.windowslive.calendar")

		; ahk_class is not used because slide show uses different class name (screenclass) compared to the main program (PPTFrameClass)
		this._windows["powerpoint"] := new Window("ahk_exe POWERPNT.EXE", "C:\\Program Files\\Microsoft Office\\root\\Office16\\POWERPNT.EXE")
		this._windows["toggl"] := new Window("ahk_exe TogglDesktop.exe", "C:\\Users\\GaryNg\\AppData\\Local\\TogglDesktop\\TogglDesktop.exe")
		this._windows["itunes"] := new Window("ahk_class iTunes", "C:\\Program Files\\iTunes\\iTunes.exe")

		this._windows["todoist_firefox"] := new FuzzyMatchWindow("Todoist ahk_exe firefox.exe", "C:\\Program Files\\Mozilla Firefox\\firefox.exe https://en.todoist.com/")
		this._windows["asana_firefox"] := new FuzzyMatchWindow("Asana ahk_exe firefox.exe", "C:\\Program Files\\Mozilla Firefox\\firefox.exe https://app.asana.com/")
		this._windows["slack"] := new Window("ahk_exe slack.exe", "C:\\Users\\GaryNg\\AppData\\Local\\slack\\slack.exe")
		this._windows["station"] := new Window("ahk_exe Station.exe", "C:\\Users\\GaryNg\\AppData\\Local\\browserX\\Station.exe")
	}

	Switch(name)
	{
		window := this._windows[name]
		
		if (!window.Exist() and this.ConfirmLaunch(name))
		{
			window.Launch()
		}
		window.Switch()
	}

	Launch(name)
	{
		window := this._windows[name]
		if (this.ConfirmLaunch(name))
		{
			window.Launch()
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
		; remove all illegal characters
		this._groupName := RegExReplace(identifier, "[_\\\.\*\?\+\[\{\|\(\)\^\$\""\s\:\-]")  . "_group"
		this.InitGroup()
	}

	InitGroup()
	{
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