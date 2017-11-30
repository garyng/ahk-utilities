#Include Prompt.ahk

class WindowQuickMinMax
{
    ; _history
    ; _prompt

    __New()
    {
        this._history := {}
        this._prompt := new Prompt()
    }

    MinimizeActiveWindow()
    {
        this.Minimize(this.getActiveWindow())
    }

    MinimizeWindowUnderMouse()
    {
        this.Minimize(this.getWindowUnderMouse())
    }

    MaximizeActiveWindow()
    {
        this.Maximize(this.getActiveWindow())
    }

    MaximizeWindowUnderMouse()
    {
        this.Maximize(this.getWindowUnderMouse())
    }
    
    Minimize(windowId)
    {
        this._history.Push(windowId)
        WinMinimize, ahk_id %windowId%
    }

    Maximize(windowId)
    {
        this._history.Push(windowId)
        WinMaximize, ahk_id %windowId%
    }

    Restore()
    {
        If (this._history.Length() > 0)
        {
            lastWindowId := this._history.Pop()
            WinRestore, ahk_id %lastWindowId%
        }
    }

    ClearHistory()
    {
        If (this._prompt.PromptMatchSpace("Clear history?", "clear"))
        {
            this._history := {}
        }
    }

    getActiveWindow()
    {
        WinGet, activeHwnd, ID, A
        return activeHwnd
    }

    getWindowUnderMouse()
    {
        MouseGetPos,,,underMouseId
        return underMouseId
    }
}
