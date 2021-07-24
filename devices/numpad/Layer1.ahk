layer1ShowOverlay(description)
{
    showOverlay("F13` + " . A_ThisHotkey, description)
}

#If IsHolding("F13")

BackSpace::UpdateTrayIcon(1), layer1ShowOverlay("Change to layer 1")
^BackSpace::return
!BackSpace::return

NumpadSub::return
^NumpadSub::return
!NumpadSub::return

NumpadMult::return
^NumpadMult::return
!NumpadMult::return

NumpadDiv::return
^NumpadDiv::return
!NumpadDiv::return

NumpadAdd::return
^NumpadAdd::return
!NumpadAdd::return

NumpadEnter::return
^NumpadEnter::return
!NumpadEnter::return

Numpad9::return
^Numpad9::return
!Numpad9::return

Numpad8::return
^Numpad8::return
!Numpad8::return

Numpad7::return
^Numpad7::return
!Numpad7::return

Numpad6::return
^Numpad6::return
!Numpad6::return

Numpad5::return
^Numpad5::return
!Numpad5::return

Numpad4::return
^Numpad4::return
!Numpad4::return

Numpad3::return
^Numpad3::return
!Numpad3::return

Numpad2::return
^Numpad2::return
!Numpad2::return

Numpad1::return
^Numpad1::return
!Numpad1::return

NumpadDot::return
^NumpadDot::return
!NumpadDot::return

Numpad0::return
^Numpad0::return
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

3::return
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
Media_Prev::
    if (IsMultitaskingViewExists()) {
        ; close the AltTab window
        SendInput {AltUp}
    } else {
        ; activate the AltTab window
        SendInput {AltDown}{Tab}
    }
    return
WheelLeft::
    if (IsMultitaskingViewExists()) {
        ; cycle backwards
        SendInput {AltDown}{ShiftDown}{Tab}{ShiftUp}
    } else {
        _virtualDesktopEnhancer.SwitchToPreviousDesktopThenFocus()
        layer1ShowOverlay("Switch to previous desktop")
    }
    return
WheelRight::
    if (IsMultitaskingViewExists()) {
        ; cycle forward
        SendInput {AltDown}{Tab}
    } else {
        _virtualDesktopEnhancer.SwitchToNextDesktopThenFocus()
        layer1ShowOverlay("Switch to next desktop")
    }
    return

Media_Next::return
WheelUp::return
WheelDown::return

#if