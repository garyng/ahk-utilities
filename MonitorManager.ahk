/*
:title:     bug.n/monitormanager
:copyright: (c) 2019 by joten <https://github.com/joten>
:license:   GNU General Public License version 3
This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
*/

class MonitorManager 
{
    __New() 
    {
        ;; enum _PROCESS_DPI_AWARENESS
        PROCESS_DPI_UNAWARE := 0
        PROCESS_SYSTEM_DPI_AWARE := 1
        PROCESS_PER_MONITOR_DPI_AWARE := 2
        ; DllCall("SHcore\SetProcessDpiAwareness", "UInt", PROCESS_PER_MONITOR_DPI_AWARE)
        ;; InnI: Get per-monitor DPI scaling factor (https://www.autoitscript.com/forum/topic/189341-get-per-monitor-dpi-scaling-factor/?tab=comments#comment-1359832)
        DPI_AWARENESS_CONTEXT_UNAWARE := -1
        DPI_AWARENESS_CONTEXT_SYSTEM_AWARE := -2
        DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE := -3
        DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2 := -4
        DllCall("User32\SetProcessDpiAwarenessContext", "UInt" , DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2)
        ;; pneumatic: -DPIScale not working properly (https://www.autohotkey.com/boards/viewtopic.php?p=241869&sid=abb2db983d2b3966bc040c3614c0971e#p241869)

        ptr := A_PtrSize ? "Ptr" : "UInt"
        this.Monitors := []
        DllCall("EnumDisplayMonitors", ptr, 0, ptr, 0, ptr, RegisterCallback("MonitorEnumProc", "", 4, &this), "UInt", 0)
        ;; Solar: SysGet incorrectly identifies monitors (https://autohotkey.com/board/topic/66536-sysget-incorrectly-identifies-monitors/)
    }
}

MonitorEnumProc(hMonitor, hdcMonitor, lprcMonitor, dwData) 
{
    this := Object(A_EventInfo)
    ;; Helgef: Allow RegisterCallback with BoundFunc objects (https://www.autohotkey.com/boards/viewtopic.php?p=235243#p235243)
    this.Monitors.push(New Monitor(hMonitor))

    return 1
}

class Monitor 
{
    __New(handle) 
    {
        this.Handle := handle
        this.WorkArea := this.GetWorkArea()
        
        dpi := this.GetDpiForMonitor()
        this.DpiX := dpi.x
        this.DpiY := dpi.y
        this.ScaleX := this.DpiX / 96
        this.ScaleY := this.DpiY / 96
    }

    GetDpiForMonitor() 
    {
        ;; enum _MONITOR_DPI_TYPE
        MDT_EFFECTIVE_DPI := 0
        MDT_ANGULAR_DPI := 1
        MDT_RAW_DPI := 2
        MDT_DEFAULT := MDT_EFFECTIVE_DPI
        ptr := A_PtrSize ? "Ptr" : "UInt"
        dpiX := dpiY := 0
        DllCall("SHcore\GetDpiForMonitor", ptr, this.handle, "Int", MDT_DEFAULT, "UInt*", dpiX, "UInt*", dpiY)

        return {x: dpiX, y: dpiY}
    }
    ;; InnI: Get per-monitor DPI scaling factor (https://www.autoitscript.com/forum/topic/189341-get-per-monitor-dpi-scaling-factor/?tab=comments#comment-1359832)

    GetWorkArea()
    {
        VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
        if (DllCall("GetMonitorInfo", "Ptr", this.Handle, "Ptr", &monitorInfo))
        {
            ; monitorLeft   := NumGet(monitorInfo,  4, "Int")
            ; monitorTop    := NumGet(monitorInfo,  8, "Int")
            ; monitorRight  := NumGet(monitorInfo, 12, "Int")
            ; monitorBottom := NumGet(monitorInfo, 16, "Int")

            workLeft      := NumGet(monitorInfo, 20, "Int")
            workTop       := NumGet(monitorInfo, 24, "Int")
            workRight     := NumGet(monitorInfo, 28, "Int")
            workBottom    := NumGet(monitorInfo, 32, "Int")
            ; isPrimary     := NumGet(monitorInfo, 36, "Int") & 1
            
            return new Rect_(workLeft, workTop, workRight, workBottom)
        }
    }
}