layer2ShowOverlay(description)
{
    showOverlay("F14 + " . A_ThisHotkey, description)
}

#If IsHolding("F14")

=::UpdateTrayIcon(2), layer2ShowOverlay("Change to layer 2")
^=::return
!=::return

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

Numpad3::_virtualDesktopEnhancer.SwitchToNextDesktopThenFocus(), layer2ShowOverlay("Switch to next desktop")
^Numpad3::return
!Numpad3::return

Numpad2::_virtualDesktopEnhancer.CreateDesktop(), layer2ShowOverlay("Create a new desktop")
^Numpad2::_virtualDesktopEnhancer.DeleteCurrentDesktop(), layer2ShowOverlay("Delete current desktop")
!Numpad2::return

Numpad1::_virtualDesktopEnhancer.SwitchToPreviousDesktopThenFocus(), layer2ShowOverlay("Switch to previous desktop")
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

1::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(0), layer2ShowOverlay("Switch to desktop #1")
^1::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(0), layer2ShowOverlay("Move active window to desktop #1")
!1::return

2::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(1), layer2ShowOverlay("Switch to desktop #2")
^2::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(1), layer2ShowOverlay("Move active window to desktop #2")
!2::return

3::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(2), layer2ShowOverlay("Switch to desktop #3")
^3::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(2), layer2ShowOverlay("Move active window to desktop #3")
!3::return

4::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(3), layer2ShowOverlay("Switch to desktop #4")
^4::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(3), layer2ShowOverlay("Move active window to desktop #4")
!4::return

5::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(4), layer2ShowOverlay("Switch to desktop #5")
^5::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(4), layer2ShowOverlay("Move active window to desktop #5")
!5::return

6::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(5), layer2ShowOverlay("Switch to desktop #6")
^6::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(5), layer2ShowOverlay("Move active window to desktop #6")
!6::return

7::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(6), layer2ShowOverlay("Switch to desktop #7")
^7::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(6), layer2ShowOverlay("Move active window to desktop #7")
!7::return

8::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(7), layer2ShowOverlay("Switch to desktop #8")
^8::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(7), layer2ShowOverlay("Move active window to desktop #8")
!8::return

9::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(8), layer2ShowOverlay("Switch to desktop #9")
^9::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(8), layer2ShowOverlay("Move active window to desktop #9")
!9::return

#if