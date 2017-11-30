#Include Prompt.ahk
#Include lib\VirtualDesktopAccessor.ahk

#HotkeyInterval 20
#MaxHotkeysPerInterval 20000	; Require as we have a hotkey listening on mouse scroll
#WinActivateForce

class VirtualDesktopEnhancer
{
    ; _onVirtualDesktopChangedMessageHandler
    ; _focusAfterSwitching
    ; _prompt
    _primaryTaskbarId := 0
    _secondaryTaskbarId := 0    ; taskbar on another monitor


    __New()
    {
        this._onVirtualDesktopChangedMessageHandler := ObjBindMethod(this, "OnVirtualDesktopChangedMessageHandler")
        this._prompt := new Prompt()
        this._virtualDesktopAccessor := new VirtualDesktopAccessor()
        this.init()
    }

    init()
    {
        this.registerOnVirtualDesktopChangedMessageHandler()
        ; setup icon?
    }

    registerOnVirtualDesktopChangedMessageHandler()
    {
        DetectHiddenWindows, On
        hwnd := WinExist("ahk_pid " . DllCall("GetCurrentProcessId","Uint"))
        hwnd += 0x1000 << 32
        this._virtualDesktopAccessor.RegisterPostMessageHook(hwnd, 0x1400 + 30)        
        
        OnMessage(0x1400 + 30, this._onVirtualDesktopChangedMessageHandler)
        DetectHiddenWindows, Off
    }

    OnVirtualDesktopChangedMessageHandler(wParam, lParam, msg, hwnd)
    {
        this.onDesktopChangedHandler(lParam)
    }

; =============================
; Public interface
; =============================

    ; 0-index
    SwitchToDesktopNThenFocus(index)
    {
        this._focusAfterSwitching := true        
        this._virtualDesktopAccessor.GoToDesktopNumber(index)
    }

    MoveActiveWindowToDesktopNThenFocus(index)
    {
        this.moveActiveWindowToDesktopN(index)
        this.focus()
    }

    MoveActiveWindowThenSwitchToDesktopNAndFocus(index)
    {
        this.moveActiveWindowToDesktopN(index)
        this.switchToDesktopNThenFocus(index)
    }

    SwitchToNextDesktopThenFocus()
    {
        this.switchToDesktopNThenFocus(this.getNextDesktopIndex())
    }

    SwitchToPreviousDesktopThenFocus()
    {
        this.switchToDesktopNThenFocus(this.getPreviousDesktopIndex())
    }

    MoveActiveWindowToNextDekstopThenFocus()
    {
        this.moveActiveWindowToDesktopN(this.getNextDesktopIndex())
        this.focus()
    }

    MoveActiveWindowToPreviousDekstopThenFocus()
    {
        this.moveActiveWindowToDesktopN(this.getPreviousDesktopIndex())
        this.focus()
    }

    MoveActiveWindowAndSwitchToNextDesktopThenFocus()
    {
        index := this.getNextDesktopIndex()
        this.moveActiveWindowToDesktopN(index)
        this.switchToDesktopNThenFocus(index)
    }

    MoveActiveWindowAndSwitchToPreviousDesktopThenFocus()
    {
        index := this.getPreviousDesktopIndex()
        this.moveActiveWindowToDesktopN(index)
        this.switchToDesktopNThenFocus(index)
    }

    TaskbarScrollUp()
    {
        if (this.isMouseHoveringTaskbar())
        {
            this.SwitchToPreviousDesktopThenFocus()
        }
    }

    TaskbarScrollDown()
    {
        if (this.isMouseHoveringTaskbar())
        {
            this.SwitchToNextDesktopThenFocus()
        }
    }

    CreateDesktop()
    {
        Send, #^d
    }

    DeleteCurrentDesktop()
    {
        if (not (this._prompt.PromptMatchSpace("Remove current desktop?", "remove")))
        {
            return
        }
        Send, #^{F4}
    }

    PinActiveWindow()
    {
        id := this.getActiveWindowId()
        title := this.getActiveWindowTitle()
        this.pinWindow(id)
        this.showNotificationForPinning(title)
    }

    UnpinActiveWindow()
    {
        id := this.getActiveWindowId()
        title := this.getActiveWindowTitle()
        this.unpinWindow(id)
        this.showNotificationForUnpinning(title)
    }

    ToggleWindowPinning()
    {
        id := this.getActiveWindowId()
        title := this.getActiveWindowTitle()
        If (this.isWindowPinned(id))
        {
            this.unpinWindow(id)
            this.showNotificationForUnpinning(title)
        }
        else
        {
            this.pinWindow(id)
            this.showNotificationForPinning(title)
        }
    }

    PinActiveApp()
    {
        id := this.getActiveWindowId()
        name := this.getActiveWindowProcessName()
        this.pinApp(id)
        this.showNotificationForPinning(name)
    }

    UnpinActiveApp()
    {
        id := this.getActiveWindowId()
        name := this.getActiveWindowProcessName()
        this.unpinApp(id)
        this.showNotificationForUnpinning(name)
    }

    ToggleAppPinning()
    {
        id := this.getActiveWindowId()
        name := this.getActiveWindowProcessName()
        If (this.isAppPinned(id))
        {
            this.unpinApp(id)
            this.showNotificationForUnpinning(name)
        }
        else
        {
            this.pinApp(id)
            this.showNotificationForPinning(name)
        }
    }



; =============================
; Helper methods
; ============================= 


    isAppPinned(windowId)
    {
        return this._virtualDesktopAccessor.IsPinnedApp(windowId)
    }

    unpinApp(windowId)
    {
        this._virtualDesktopAccessor.UnpinApp(windowId)
    }
    
    pinApp(windowId)
    {
        this._virtualDesktopAccessor.PinApp(windowId)
    }

    isWindowPinned(windowId)
    {
        return this._virtualDesktopAccessor.IsPinnedWindow(windowId)
    }

    pinWindow(windowId)
    {
        this._virtualDesktopAccessor.PinWindow(windowId)
    }

    unpinWindow(windowId)
    {
        this._virtualDesktopAccessor.UnPinWindow(windowId)
    }

    isMouseHoveringTaskbar()
    {
        if (!this._primaryTaskbarId)
        {
            WinGet, primaryTaskbarId, ID, ahk_class Shell_TrayWnd
            this._primaryTaskbarId := primaryTaskbarId
        }
        if (!this._secondaryTaskbarId)
        {
            WinGet, secondaryTaskbarId, ID, ahk_class Shell_SecondaryTrayWnd
            this._secondaryTaskbarId := secondaryTaskbarId
        }

        MouseGetPos,,,mouseHoveringId
        return ((mouseHoveringId == this._primaryTaskbarId) || (mouseHoveringId == this._secondaryTaskbarId))
    }

    onDesktopChangedHandler(index := 0)
    {
        this.focusIfRequested()        
        this.showNotificationForDesktopSwtich(index)
    }

    moveActiveWindowToDesktopN(index)
    {
        activeHwnd := this.getActiveWindowId()
        this._virtualDesktopAccessor.MoveWindowToDesktopNumber(activeHwnd, index)
    }

    focusIfRequested()
    {
        If (this._focusAfterSwitching)
        {
            this.focus()
            this._focusAfterSwitching := false
        }
    }

    ; focus the foremost window on current desktop after moving the window
    focus()
    {
        foremostWindowId := this.getForemostWindowIdOnDesktopN(this.getCurrentDesktopIndex())
        WinActivate, ahk_id %foremostWindowId%
    }

    getForemostWindowIdOnDesktopN(index)
    {
        WinGet, winIdList, List
        Loop % winIdList 
        {
            currentWindowId := % winIdList%A_Index%
            isWindowOnDesktop := this._virtualDesktopAccessor.IsWindowOnDesktopNumber(currentWindowId, index)
            if (isWindowOnDesktop)
            {
                return currentWindowId
            }
        }
    }


    getActiveWindowTitle()
    {
        WinGetTitle, title, A
        return title
    }

    getActiveWindowId()
    {
        WinGet, activeHwnd, ID, A
        return activeHwnd
    }

    getActiveWindowProcessName()
    {
        WinGet, name, ProcessName, A
        return name
    }

    getCurrentDesktopIndex()
    {
        return this._virtualDesktopAccessor.GetCurrentDesktopNumber()
    }

    getDesktopCount()
    {
        return this._virtualDesktopAccessor.GetDesktopCount()
    }

    getNextDesktopIndex()
    {
        return this.calculateDesktopIndex(+1)
    }

    getPreviousDesktopIndex()
    {
        return this.calculateDesktopIndex(-1)
    }

    calculateDesktopIndex(delta)
    {
        current := this.getCurrentDesktopIndex()
        count := this.getDesktopCount()
        newIndex := Mod(current + delta, count)
        if (newIndex < 0)
        {
            return newIndex + count
        }
        return newIndex
    }

    showNotificationForDesktopSwtich(index)
    {
        this._prompt.Show("Desktop #" . (index + 1) )
    }

    showNotificationForPinning(text)
    {
        this._prompt.Show("Pinned '" . text . "'")
    }

    showNotificationForUnpinning(text)
    {
        this._prompt.Show("Unpinned '" . text . "'")
    }
}