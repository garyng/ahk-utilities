layer1ShowOverlay(description)
{
    showOverlay("F13` + " . A_ThisHotkey, description)
}

runSqlInClipboard()
{
    ; replace all and run
    SendInput {ctrl down}a{ctrl up}{ctrl down}v{ctrl up}{ctrl down}a{ctrl up}{F5}
    ; SendInput {enter}^+{end}^v{F5}
}

#If IsHolding("F13")

BackSpace::UpdateTrayIcon(1), layer1ShowOverlay("Change to layer 1")
^BackSpace::return
!BackSpace::
    Run *RunAs "iisreset.exe"
	showOverlay("!F1", "Reset IIS")
	return

NumpadSub::_windowSwitcher.Switch("slack"), layer1ShowOverlay("Switch to slack")
^NumpadSub::_windowSwitcher.Launch("slack"), layer1ShowOverlay("Launch slack")
!NumpadSub::return

NumpadMult::_windowSwitcher.Switch("ccmp_vs"), layer1ShowOverlay("Switch to ccmp visual studio")
^NumpadMult::_windowSwitcher.Launch("ccmp_vs"), layer1ShowOverlay("Launch ccmp visual studio")
!NumpadMult::return

NumpadDiv::_windowSwitcher.Switch("visualstudio"), layer1ShowOverlay("Switch to visual studio")
^NumpadDiv::_windowSwitcher.Launch("visualstudio"), layer1ShowOverlay("Launch visual studio")
!NumpadDiv::return

NumpadAdd::_windowSwitcher.Switch("tasks"), layer1ShowOverlay("Switch to tasks")
^NumpadAdd::_windowSwitcher.Reset("tasks"), layer1ShowOverlay("Reset tasks")
!NumpadAdd::_windowSwitcher.Launch("chrome"), layer1ShowOverlay("Launch chrome")

NumpadEnter::_windowSwitcher.Switch("local"), layer1ShowOverlay("Switch to local")
^NumpadEnter::_windowSwitcher.Reset("local"), layer1ShowOverlay("Reset local")
!NumpadEnter::_windowSwitcher.Launch("chrome"), layer1ShowOverlay("Launch chrome")

Numpad9::_windowSwitcher.Switch("ccmp_vscode"), layer1ShowOverlay("Switch to ccmp vscode")
^Numpad9::_windowSwitcher.Launch("ccmp_vscode"), layer1ShowOverlay("Launch ccmp vscode")
!Numpad9::return

Numpad8::_windowSwitcher.Switch("tickets_vscode"), layer1ShowOverlay("Switch to tickets")
^Numpad8::_windowSwitcher.Launch("tickets_vscode"), layer1ShowOverlay("Launch tickets")
!Numpad8::return

Numpad7::_windowSwitcher.Switch("mremoteng"), layer1ShowOverlay("Switch to mRemoteNG")
^Numpad7::_windowSwitcher.Launch("mremoteng"), layer1ShowOverlay("Launch mRemoteNG")
!Numpad7::return

Numpad6::_windowSwitcher.Switch("ccmp_wt"), layer1ShowOverlay("Switch to terminal")
^Numpad6::_windowSwitcher.Launch("ccmp_wt"), layer1ShowOverlay("Launch terminal")
!Numpad6::return

Numpad5::_windowSwitcher.Switch("wt"), layer1ShowOverlay("Switch to terminal")
^Numpad5::_windowSwitcher.Launch("wt"), layer1ShowOverlay("Launch terminal")
!Numpad5::return

Numpad4::_windowSwitcher.Switch("insomnia"), layer1ShowOverlay("Switch to insomnia")
^Numpad4::_windowSwitcher.Launch("insomnia"), layer1ShowOverlay("Launch insomnia")
!Numpad4::return

Numpad3::_windowSwitcher.Switch("datagrip"), layer1ShowOverlay("Switch to datagrip")
^Numpad3::_windowSwitcher.Reset("datagrip"), layer1ShowOverlay("Reset datagrip")
!Numpad3::return

Numpad2::_windowSwitcher.Switch("obsidian"), layer1ShowOverlay("Switch to obsidian")
^Numpad2::_windowSwitcher.Launch("obsidian"), layer1ShowOverlay("Launch obsidian")
!Numpad2::return

Numpad1::_windowSwitcher.Switch("linqpad"), layer1ShowOverlay("Switch to linqpad")
^Numpad1::_windowSwitcher.Launch("linqpad"), layer1ShowOverlay("Launch obsidian")
!Numpad1::return

NumpadDot::_windowSwitcher.Launch("chrome"), layer1ShowOverlay("Launch chrome")
^NumpadDot::return
!NumpadDot::return

Numpad0::_windowSwitcher.Switch("fork"), layer1ShowOverlay("Switch to fork")
^Numpad0::_windowSwitcher.Launch("fork"), layer1ShowOverlay("Launch fork")
!Numpad0::return

Up::return
^Up::return
!Up::return

Down::return
^Down::return
!Down::return

Left::return
^Left::return
!Left::return

Right::return
^Right::return
!Right::return

1::return
^1::return
!1::return

2::return
^2::return
!2::return

3::runSqlInClipboard(), layer1ShowOverlay("Run SQL in clipboard")
^3::return
!3::return

4::return
^4::return
!4::return

5::return
^5::return
!5::return

6::return
^6::return
!6::return

7::return
^7::return
!7::return

8::return
^8::return
!8::return

9::return
^9::return
!9::return

; from https://www.autohotkey.com/docs/Hotkeys.htm#alttab
SC073::
    if (IsMultitaskingViewExists()) {
        ; close the AltTab window
        SendInput {AltUp}
    } else {
        ; activate the AltTab window
        SendInput {AltDown}{Tab}
    }
    return
!SC073::return
^SC073::return
WheelLeft::
    if (IsMultitaskingViewExists()) {
        ; cycle backwards
        SendInput {AltDown}{ShiftDown}{Tab}{ShiftUp}
    }
    return
WheelRight::
    if (IsMultitaskingViewExists()) {
        ; cycle forward
        SendInput {AltDown}{Tab}
    }
    return

SC070::_virtualDesktopEnhancer.CreateDesktop(), layer1ShowOverlay("Create a new desktop")
^SC070::_virtualDesktopEnhancer.DeleteCurrentDesktop(), layer1ShowOverlay("Delete current desktop")
!SC070::return
WheelUp::_virtualDesktopEnhancer.SwitchToPreviousDesktopThenFocus(), layer1ShowOverlay("Switch to previous desktop")
WheelDown::_virtualDesktopEnhancer.SwitchToNextDesktopThenFocus(), layer1ShowOverlay("Switch to next desktop")

#if