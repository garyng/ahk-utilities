class Overlay
{
    _guiConfig := {}
    __New()
	{
		this._guiConfig.Background := "202020"
        this._guiConfig.Foreground := "white"
        this._guiConfig.FontSize := 10
        this._guiConfig.FontName := "Consolas"
        this._guiConfig.Transparency := 200
		this._guiConfig.Timeout := -1000	; must be negative to ensure the timer is launched once only
	}

    _monitorGuisMap := [[]]

    Show(texts*)
    {
        count := this.getMonitorCount()
        Loop, %count%
        {
			index := A_Index
            hwnd := this.guiCreate(texts)

			if (!this._monitorGuisMap[index]) ; if the element is uninitialized
			{
				this._monitorGuisMap[index] := []
			}
            guis := this._monitorGuisMap[index]
			
			Gui, Show, x0 y-3000 NoActivate

            this.placeGuiBottomLeft(index, hwnd)

            WinGetPos,,,, height, ahk_id %hwnd%
            this.shiftGuis(guis, 0, -height)

			guiIndex := guis.Push(hwnd)

            this.guiSetupDestroyCallback(hwnd, guis, guiIndex, this._guiConfig.Timeout)

            WinSet, Transparent, % this._guiConfig.Transparency, ahk_id %hwnd%
        }
    }

    ; negative number for only launching once
	guiSetupDestroyCallback(hwnd, guis, guiIndex, timeout)
	{
		callback := ObjBindMethod(this, "guiDestroy", hwnd, guis, guiIndex)
		SetTimer % callback, % timeout
	}

    guiDestroy(hwnd, guis, guiIndex)
	{
		Gui, %hwnd%:Destroy
		guis.RemoveAt(guiIndex)
	}

    shiftGuis(guisList, offsetX, offsetY)
	{
		SetWinDelay, 0
		for index, hwnd in guisList
		{
			WinGetPos, x, y,,, ahk_id %hwnd%
			x += offsetX
			y += offsetY
			WinMove, ahk_id %hwnd%, , %x%, %y%
		}
		SetWinDelay, 100
	}

    placeGuiBottomLeft(monitorIndex, hwnd)
	{
		SetWinDelay, 0	; default 100ms
		SysGet, workspace, MonitorWorkArea, % monitorIndex
		SysGet, name, Monitorname, % monitorIndex

		WinGetPos, x, y, width, height, ahk_id %hwnd%	; get current gui dimension

		offset := 50	; extract this to config?
		; position gui at the bottom left
		newX := workspaceLeft + offset
		newY := workspaceBottom - height - offset

		WinMove, ahk_id %hwnd%, , %newX%, %newY%
		
		SetWinDelay, 100		

	}

    guiCreate(texts)
    {
		; first line	second line
		; 				line
		; 				line
		; 				line

        Gui, New
		Gui, -Caption +ToolWindow +LastFound +AlwaysOnTop +Hwndhwnd
		Gui, %hwnd%:Default
		Gui, Color, % this._guiConfig.Background
		Gui, Font, % "c" . this._guiConfig.Foreground

		for index, text in texts
		{
			if (index == texts.MinIndex())
			{
				Gui, Font, % "bold s" . this._guiConfig.FontSize, % this._guiConfig.FontName
				Gui, Add, Text, Center , % text
			}
			else if (index == texts.MinIndex() + 1)
			{
				Gui, Font, % "norm s" . this._guiConfig.FontSize, % this._guiConfig.FontName
				Gui, Add, Text, Center x+m , % text	; place on the right of the previous
			}
			else
			{
				Gui, Font, % "norm s" . this._guiConfig.FontSize, % this._guiConfig.FontName
				Gui, Add, Text, Center xp y+m, % text	; place below the previous
			}
		}
		return hwnd
    }

    getMonitorCount()
	{
		SysGet, count, 80	; SM_CMONITORS
		return count
	}
}