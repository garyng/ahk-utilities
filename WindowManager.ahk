class Rect_
{
    __New(left, top, right, bottom)
    {
        this.Left := left
        this.Top := top
        this.Right := right
        this.Bottom := bottom

        this.X := left
        this.Y := top
        this.Width := Abs(this.Right - this.Left)
        this.Height := Abs(this.Bottom - this.Top)
    }
}

class Monitors
{
    __New()
    {
        this.WorkAreas := []
    }

    GetAll()
    {
        SysGet, count, MonitorCount
        Loop, %MonitorCount%
        {
            workArea := this.Get(A_Index)
            this.WorkAreas.Push(workArea)
        }
    }

    Get(index)
    {
        SysGet, workspace, MonitorWorkArea, % index
        return new Rect_(workspaceLeft, workspaceTop, workspaceRight, workspaceBottom)
    }
}

class Window2
{
    __New(hwnd)
    {
        this._hwnd := hwnd
        this._ahkId := "ahk_id " . hwnd
    }

    Maximize()
    {
        WinMaximize, % this._ahkId
    }

    Minimize()
    {
        WinMinimize, % this._ahkId
    }

    Restore()
    {
        WinRestore, % this._ahkId
    }

    ; toggle between maximize/normal state
    Toggle()
    {
        WinGet, state, MinMax, % this._ahkId
        if (state == 0) ; normal state
        {
            this.Maximize()
        }
        else if (state == 1) ; maximized
        {
            this.Restore()
        }
    }

    ; resize window according to percentage
    Resize(width, height, moveToCenter := true, workArea := "")
    {       
        if (!workArea)
        {
            workArea := this.GetCurrentWorkAreaFromWindow(this._hwnd)
        }
        
        width := workArea.Width * width
        height := workArea.Height * height

        if (moveToCenter)
        {
            x := workArea.X + (workArea.Width - width) / 2
            y := workArea.Y + (workArea.Height - height) / 2
            WinMove, % this._ahkId, , x, y, width, height
        }
        else
        {
            WinMove, % this._ahkId, , , , width, height
        }

        ; refrehs title bar button states if window is maximized
        this.Restore()
    }

    Center()
    {
        ; todo: size is different on each monitor?
        size := this.GetWindowRect()
        workArea := this.GetCurrentWorkAreaFromWindow(this._hwnd)
        x := workArea.X + (workArea.Width - size.Width) / 2
        y := workArea.Y + (workArea.Height - size.Height) / 2

        WinMove % this._ahkId, , x, y
    }

    ; get the work area for the monitor where the window is
    GetCurrentWorkAreaFromWindow(hwnd)
    {
        ; from https://www.autohotkey.com/boards/viewtopic.php?t=15501
        ; MonitorFromWindow https://msdn.microsoft.com/en-us/library/windows/desktop/dd145064%28v=vs.85%29.aspx
        ; GetMonitorInfo https://msdn.microsoft.com/en-us/library/windows/desktop/dd144901%28v=vs.85%29.aspx
        ; MONITORINFO https://msdn.microsoft.com/en-us/library/windows/desktop/dd145065%28v=vs.85%29.aspx
        VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
        if (monitorHandle := DllCall("MonitorFromWindow", "Ptr", hwnd, "UInt", 0x2)) 
            && DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo) {

            ; monitorLeft   := NumGet(monitorInfo,  4, "Int")
            ; monitorTop    := NumGet(monitorInfo,  8, "Int")
            ; monitorRight  := NumGet(monitorInfo, 12, "Int")
            ; monitorBottom := NumGet(monitorInfo, 16, "Int")

            workLeft      := NumGet(monitorInfo, 20, "Int")
            workTop       := NumGet(monitorInfo, 24, "Int")
            workRight     := NumGet(monitorInfo, 28, "Int")
            workBottom    := NumGet(monitorInfo, 32, "Int")
            isPrimary     := NumGet(monitorInfo, 36, "Int") & 1
            
            workArea := new Rect_(workLeft, workTop, workRight, workBottom)
            return workArea
        }
    }

    GetWorkAreaByIndex(index)
    {
        SysGet, workspace, MonitorWorkArea, % index
        return new Rect_(workspaceLeft, workspaceTop, workspaceRight, workspaceBottom)
    }

    GetWindowRect()
    {
        WinGetPos, x, y, width, height, % this._ahkId
        return new Rect_(x, y, x + width, y + height)
    }

    MoveToMonitor(index)
    {
        SysGet, count, MonitorCount
        if (index >= count)
        {
            return
        }

        workArea := this.GetWorkAreaByIndex(index)
        this.Resize(0.8, 0.8, true, workArea)
    }

    Expand(inc := 40)
    {
        rect := this.GetWindowRect()
        width := rect.Width + inc
        height := rect.Height + inc
        x := rect.X - inc / 2
        y := rect.Y - inc / 2

        WinMove, % this._ahkId, , x, y, width, height
    }

    ; todo: show overlay for monitor index
}

class ActiveWindow2 extends Window2
{
    __New()
    {
        base.__New(WinExist("A"))
    }
}

class WindowManager
{
    MaximizeActiveWindow()
    {
        new ActiveWindow2().Maximize()
    }

    MinimizeActiveWindow()
    {
        new ActiveWindow2().Minimize()
    }

    RestoreActiveWindow()
    {
        new ActiveWindow2().Restore()
    }

    ToggleActiveWindow()
    {
        new ActiveWindow2().Toggle()
    }

    CenterActiveWindow()
    {
        new ActiveWindow2().Center()
    }

    ResizeAndCenterActiveWindow(width = 0.8, height = 0.8)
    {
        new ActiveWindow2().Resize(width, height, true)
    }

    MoveActiveWindowToMonitor(index)
    {
        new ActiveWindow2().MoveToMonitor(index)
    }

    ExpandActiveWindow(inc := 40)
    {
        new ActiveWindow2().Expand()
    }

    ShrinkActiveWindow(dec := 40)
    {
        new ActiveWindow2().Expand(-dec)
    }
}