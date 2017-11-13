class Tray
{
	initIcon()
	{
		Menu, Tray, Icon, Resources\SnapX.ico
		Menu, Tray, NoStandard
	}

	__New(settings, build, snapper)
	{
		this.settings := settings
		this.build := build
		this.snapper := snapper

		this.InitIcon()

		aboutMethod := ObjBindMethod(this, "tray_About")
		Menu, Tray, Add, % this.settings.programTitle, % aboutMethod

		Menu, Tray, Add, &About, % aboutMethod

		Menu, Tray, Add

		helpMethod := ObjBindMethod(this, "tray_Help")
		Menu, Tray, Add, &Help, % helpMethod

		settingsMethod := ObjBindMethod(this, "tray_Settings")
		Menu, Tray, Add, &Settings, % settingsMethod

		reloadMethod := ObjBindMethod(this, "tray_Reload")
		Menu, Tray, Add, &Reload, % reloadMethod

		suspendMethod := ObjBindMethod(this, "tray_Suspend")
		Menu, Tray, Add, S&uspend, % suspendMethod

		exitMethod := ObjBindMethod(this, "tray_Exit")
		Menu, Tray, Add, E&xit, % exitMethod
		
		Menu, Tray, Icon, % this.settings.programTitle, Resources\SnapX.ico
		Menu, Tray, Icon, &About, Resources\About.ico
		Menu, Tray, Icon, &Help, Resources\Help.ico
		Menu, Tray, Icon, &Settings, Resources\Settings.ico
		Menu, Tray, Icon, &Reload, Resources\Reload.ico
		Menu, Tray, Icon, S&uspend, Resources\Suspend.ico
		Menu, Tray, Icon, E&xit, Resources\Exit.ico
	
		Menu, Tray, Default, % this.settings.programTitle
		Menu, Tray, Tip, % this.settings.programTitle
	}

	tray_Noop(itemName, itemPos, menuName)
	{
	}

	tray_About(itemName, itemPos, menuName)
	{
		new AboutGui(this.settings, this.build)
	}

	tray_Help(itemName, itemPos, menuName)
	{
		new HelpGui(this.settings)
	}

	tray_Settings(itemName, itemPos, menuName)
	{
		new SettingsGui(this.settings, this.snapper)
	}

	tray_Reload(itemName, itemPos, menuName)
	{
		Reload
	}

	tray_Suspend(itemName, itemPos, menuName)
	{
		Suspend, Toggle
		
		if (A_IsSuspended)
		{
			Menu, Tray, Rename, S&uspend, Res&ume
			Menu, Tray, Icon, Res&ume, Resources\Resume.ico
			Menu, Tray, Icon, Resources\SnapX_Suspended.ico, , 1
		}
		else
		{
			Menu, Tray, Rename, Res&ume, S&uspend
			Menu, Tray, Icon, S&uspend, Resources\Suspend.ico
			Menu, Tray, Icon, Resources\SnapX.ico, , 0
		}
	}

	tray_Exit(itemName, itemPos, menuName)
	{
		ExitApp
	}
}