#Include Prompt.ahk
#Include lib\VirtualDesktopAccessor.ahk

#HotkeyInterval 20
#MaxHotkeysPerInterval 20000	; Require as we have a hotkey listening on mouse scroll
#WinActivateForce

class VirtualDesktopEnhancer
{
    ; _onVirtualDesktopChangedMessageHandler
    ; _onExplorerRestartHandler
    ; _focusAfterSwitching
    ; _prompt
    _primaryTaskbarId := 0
    _secondaryTaskbarId := 0    ; taskbar on another monitor
    _lastDesktopIndex := -1
    
    __New()
    {
        this._onVirtualDesktopChangedMessageHandler := ObjBindMethod(this, "OnVirtualDesktopChangedMessageHandler")
        this._onExplorerRestartHandler := ObjBindMethod(this, "OnExplorerRestartHandler")
        this._prompt := new Prompt()
        this._virtualDesktopAccessor := new VirtualDesktopAccessor()
        this.init()
    }

    init()
    {
        this.registerOnVirtualDesktopChangedMessageHandler()
        this.registerOnExplorerRestartHandler()
        this.updateTrayIcon(this.getCurrentDesktopIndex())
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
        ; wParam -> old desktop index
        ; lParam -> new desktop index
        this.onDesktopChangedHandler(wParam, lParam)
    }

    registerOnExplorerRestartHandler()
    {   
        ; restart the virtual desktop accessor when Explorer.exe crashes, 
        ; or restarts (e.g. when coming from fullscreen game)
        msg := DllCall("user32\RegisterWindowMessage", "Str", "TaskbarCreated")
        OnMessage(msg, this._onExplorerRestartHandler)
    }

    OnExplorerRestartHandler()
    {
        this._virtualDesktopAccessor.RestartVirtualDesktopAccessor()
    }

; =============================
; Public interface
; =============================

    ; 0-index
    SwitchToDesktopNThenFocus(index)
    {
        currentIndex := this.getCurrentDesktopIndex()
        if (currentIndex == index) 
        { 
            return 
        }

        this._focusAfterSwitching := true
        this._virtualDesktopAccessor.GoToDesktopNumber(index)
    }

    GoToLastDesktop()
    {
        if (this._lastDesktopIndex != -1)
        {
            index := this._lastDesktopIndex
            this.SwitchToDesktopNThenFocus(index)
        }
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

    MoveActiveWindowToNextDesktopThenFocus()
    {
        this.moveActiveWindowToDesktopN(this.getNextDesktopIndex())
        this.focus()
    }

    MoveActiveWindowToPreviousDesktopThenFocus()
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

    MoveAllWindowToNewDesktop()
    {
        currentIndex := this.getCurrentDesktopIndex()
        windows := this.getAllWindowsOnDesktopN(currentIndex)
        this.CreateDesktop()
        newDesktopIndex := this.GetDesktopCount() - 1
        for index, win in windows
        {
            this._virtualDesktopAccessor.MoveWindowToDesktopNumber(win, newDesktopIndex)
        }
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

    updateTrayIcon(desktopIndex)
    {
        
        Menu, Tray, Tip, % this.GetDesktopName(desktopindex)
        ; icons start at index 1
        iconFileName := A_ScriptDir . "\icons\" . (desktopIndex + 1) . ".ico"
        if (FileExist(iconFileName))
        {
            Menu, Tray, Icon, % iconFileName
        }
        else
        {
            Menu, Tray, Icon, % A_ScriptDir . "\icons\+.ico"
        }
    }    

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

    onDesktopChangedHandler(oldIndex, newIndex)
    {
        this._lastDesktopIndex := oldIndex
        
        this.focusIfRequested()        
        this.showNotificationForDesktopSwtich(newIndex)
        this.updateTrayIcon(newIndex)
    }

    moveActiveWindowToDesktopN(index)
    {
        activeHwnd := this.getActiveWindowId()
        this._virtualDesktopAccessor.MoveWindowToDesktopNumber(activeHwnd, index)
    }   

    getAllWindowsOnDesktopN(index)
    {
        windows := []
        WinGet, winIdList, List
        Loop % winIdList
        {
            currentId := % winIdList%A_Index%
            isWindowOnDesktop := this._virtualDesktopAccessor.IsWindowOnDesktopNumber(currentId, index)
            if (isWindowOnDesktop)
            {
                windows.Push(currentId)
            }
        }
        return windows
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
        ; foremostWindowId := this.getForemostWindowIdOnDesktopN(this.getCurrentDesktopIndex())
        ; WinActivate, ahk_id %foremostWindowId%
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
        this._prompt.Show(this.GetDesktopName(index))
    }

    GetDesktopName(index)
    {
        return "Desktop #" . (index + 1)
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