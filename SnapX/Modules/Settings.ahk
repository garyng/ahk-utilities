class Settings
{
	;@Ahk2Exe-SetName SnapX
	static programTitle := "SnapX"
	;@Ahk2Exe-SetDescription Replacement for Windows/Aero Snap
	static programDescription := "Replacement for Windows/Aero Snap"
	
	_debug := 0
	debug[fromIniFile = false]
	{
		get
		{
			return this._debug
		}
		set
		{
			if (value != this._debug)
			{
				this._debug := value
				if (!fromIniFile)
				{
					this.writeSetting("debug", "Settings")
				}
			}
			return this._debug
		}
	}
	
	_horizontalSections := -1
	horizontalSections[fromIniFile = false]
	{
		get
		{
			return this._horizontalSections
		}
		set
		{
			if (value != this._horizontalSections)
			{
				this._horizontalSections := value
				if (!fromIniFile)
				{
					this.writeSetting("horizontalSections", "Settings")
				}
			}
			return this._horizontalSections
		}
	}
	
	_verticalSections := -1
	verticalSections[fromIniFile = false]
	{
		get
		{
			return this._verticalSections
		}
		set
		{
			if (value != this._verticalSections)
			{
				this._verticalSections := value
				if (!fromIniFile)
				{
					this.writeSetting("verticalSections", "Settings")
				}
			}
			return this._verticalSections
		}
	}
	
	__New()
	{
		this.iniFile := this.programTitle ".ini"
		this.logFile := this.programTitle ".log"
		
		firstRun := false
		
		IfNotExist % this.iniFile
		{
			firstRun := true
			
			FileAppend, % ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`n", % this.iniFile
			FileAppend, % ";; Make sure to reload " this.programTitle " after editing this file directly (right-click tray menu > Reload).`n", % this.iniFile
			FileAppend, % ";; Alternatively, use the SnapX Settings GUI to make changes (right-click tray menu > Settings).`n", % this.iniFile
			FileAppend, % ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;`n", % this.iniFile
		}
		
		this.readSetting("debug", "Settings", this._debug)
		
		this.readSetting("horizontalSections", "Settings", this._horizontalSections)
		if (this.horizontalSections < 2)
		{
			this.horizontalSections := 4
		}
		
		this.readSetting("verticalSections", "Settings", this._verticalSections)
		if (this.verticalSections < 1)
		{
			this.verticalSections := 2
		}

		if (firstRun)
		{
			MsgBox, , % "Thank you for using " this.programTitle, % "This is your first time running " this.programTitle ", by Ben Allred.`n`nYou are running with the recommended default settings.`nYou can change your settings via the Settings option in the tray menu."
			new HelpGui(this)
		}
	}
	
	readSetting(varName, section, default)
	{
		IniRead, tmp, % this.iniFile, % section, % varName, % default
		this[varName](true) := tmp
	}
	
	writeSetting(varName, section)
	{
		IniWrite, % this[varName], % this.iniFile, % section, % varName
	}
}