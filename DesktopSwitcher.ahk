; Adapted from https://github.com/pmb6tz/windows-desktop-switcher
class DesktopSwitcher
{
    _desktopCount := 2        ; Windows starts with 2 desktops at boot
    _currentDesktop := 1      ; Desktop count is 1-indexed (Microsoft numbers them this way)
    
    __New()
    {
        this._prompt := new Prompt()
        this.mapDesktopsFromRegistry()
    }

    ;
    ; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
    ; Current desktop UUID appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
    ; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
    ;
    mapDesktopsFromRegistry() {
        ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
        IdLength := 32
        SessionId := this.getSessionId()
        if (SessionId) {
            RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%SessionId%\VirtualDesktops, CurrentVirtualDesktop
            if (CurrentDesktopId) {
                IdLength := StrLen(CurrentDesktopId)
            }
        }

        ; Get a list of the UUIDs for all virtual desktops on the system
        RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
        if (DesktopList) {
            DesktopListLength := StrLen(DesktopList)
            ; Figure out how many virtual desktops there are
            this._desktopCount := DesktopListLength / IdLength
        }
        else {
            this._desktopCount := 1
        }

        ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
        i := 0
        while (CurrentDesktopId and i < this._desktopCount) {
            StartPos := (i * IdLength) + 1
            DesktopIter := SubStr(DesktopList, StartPos, IdLength)

            ; Break out if we find a match in the list. If we didn't find anything, keep the
            ; old guess and pray we're still correct :-D.
            if (DesktopIter = CurrentDesktopId) {
                this._currentDesktop := i + 1
                break
            }
            i++
        }
    }

    ;
    ; This functions finds out ID of current session.
    ;
    getSessionId()
    {
        ProcessId := DllCall("GetCurrentProcessId", "UInt")
        if ErrorLevel {
            return
        }
        SessionId := 0

        DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
        if ErrorLevel {
            return
        }
        return SessionId
    }

    ;
    ; This function switches to the desktop number provided.
    ;
    switchDesktopByNumber(targetDesktop)
    {
        SetKeyDelay, 75
        ; Re-generate the list of desktops and where we fit in that. We do this because
        ; the user may have switched desktops via some other means than the script.
        this.mapDesktopsFromRegistry()

        ; Don't attempt to switch to an invalid desktop
        if (targetDesktop > this._desktopCount || targetDesktop < 1) {
            return
        }

        ; Go right until we reach the desktop we want
        while(this._currentDesktop < targetDesktop) {
            Send ^#{Right}
            this._currentDesktop++
        }

        ; Go left until we reach the desktop we want
        while(this._currentDesktop > targetDesktop) {
            Send ^#{Left}
            this._currentDesktop--
        }
        SetKeyDelay, -1

        this._prompt.Show("Desktop #" targetDesktop)
    }

    switchToNextDesktop()
    {
        this.switchDesktopByNumber(this._currentDesktop + 1)
    }
    switchToPreviousDesktop()
    {
        this.switchDesktopByNumber(this._currentDesktop - 1)
    }

    ;
    ; This function creates a new virtual desktop and switches to it
    ;
    createVirtualDesktop()
    {
        Send, #^d
        this._desktopCount++
        this._currentDesktop := this._desktopCount
    }

    ;
    ; This function deletes the current virtual desktop
    ;
    deleteVirtualDesktop()
    {
        if (not (this._prompt.Prompt("Remove current desktop?`n[Space to remove]") = " "))
        {
            return
        }
        Send, #^{F4}
        this._desktopCount--
        this._currentDesktop--
    }
}