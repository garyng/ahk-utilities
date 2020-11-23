layer2ShowOverlay(description)
{
    showOverlay("F14 + " . A_ThisHotkey, description)
}

#If IsHolding("F14")

=::UpdateTrayIcon(2), layer2ShowOverlay("Change to layer 2")
^=::return
!=::return

NumpadSub::_windowManager.MinimizeActiveWindow(), layer2ShowOverlay("Minimize active window")
^NumpadSub::_windowManager.ShrinkActiveWindow(), layer2ShowOverlay("Shrink active window")
!NumpadSub::return

NumpadMult::_virtualDesktopEnhancer.PinActiveWindow(), layer2ShowOverlay("Pin active window")
^NumpadMult::_virtualDesktopEnhancer.UnpinActiveWindow(), layer2ShowOverlay("Unpin active window")
!NumpadMult::return

NumpadDiv::_virtualDesktopEnhancer.PinActiveApp(), layer2ShowOverlay("Pin active app")
^NumpadDiv::_virtualDesktopEnhancer.UnpinActiveApp(), layer2ShowOverlay("Unpin active app")
!NumpadDiv::return

NumpadAdd::_windowManager.ResizeAndCenterActiveWindow(), layer2ShowOverlay("Resize and center active window")
^NumpadAdd::_windowManager.ExpandActiveWindow(), layer2ShowOverlay("Expand active window")
!NumpadAdd::return

NumpadEnter::_windowManager.ToggleActiveWindow(), layer2ShowOverlay("Toggle active window state")
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

Numpad6::_virtualDesktopEnhancer.SwitchToNextDesktopThenFocus(), layer2ShowOverlay("Switch to next desktop")
^Numpad6::_virtualDesktopEnhancer.MoveActiveWindowToNextDesktopThenFocus(), layer2ShowOverlay("Move active window to next desktop")
!Numpad6::_virtualDesktopEnhancer.MoveActiveWindowAndSwitchToNextDesktopThenFocus(), layer2ShowOverlay("Move active window and switch to next desktop")

Numpad5::_virtualDesktopEnhancer.CreateDesktop(), layer2ShowOverlay("Create a new desktop")
^Numpad5::_virtualDesktopEnhancer.DeleteCurrentDesktop(), layer2ShowOverlay("Delete current desktop")
!Numpad5::return

Numpad4::_virtualDesktopEnhancer.SwitchToPreviousDesktopThenFocus(), layer2ShowOverlay("Switch to previous desktop")
^Numpad4::_virtualDesktopEnhancer.MoveActiveWindowToPreviousDesktopThenFocus(), layer2ShowOverlay("Move active window to previous desktop")
!Numpad4::_virtualDesktopEnhancer.MoveActiveWindowAndSwitchToPreviousDesktopThenFocus(), layer2ShowOverlay("Move active window and switch to previous desktop")

Numpad3::_windowManager.MoveActiveWindowToMonitor(2), layer2ShowOverlay("Move active window to monitor 3")
^Numpad3::return
!Numpad3::return

Numpad2::_windowManager.MoveActiveWindowToMonitor(1), layer2ShowOverlay("Move active window to monitor 2")
^Numpad2::return
!Numpad2::return

Numpad1::_windowManager.MoveActiveWindowToMonitor(0), layer2ShowOverlay("Move active window to monitor 1")
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

Left::_tss.MoveCurrentToNotGood(), layer1ShowOverlay("Move currently playing to not good list")
^Left::return
!Left::return

Right::_tss.MoveCurrentToGood(), layer1ShowOverlay("Move currently playing to good list")
^Right::return
!Right::return

1::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(0), layer2ShowOverlay("Switch to desktop #1")
^1::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(0), layer2ShowOverlay("Move active window to desktop #1")
!1::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(0), layer2ShowOverlay("Move active window and switch to desktop #1")

2::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(1), layer2ShowOverlay("Switch to desktop #2")
^2::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(1), layer2ShowOverlay("Move active window to desktop #2")
!2::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(1), layer2ShowOverlay("Move active window and switch to desktop #2")

3::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(2), layer2ShowOverlay("Switch to desktop #3")
^3::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(2), layer2ShowOverlay("Move active window to desktop #3")
!3::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(2), layer2ShowOverlay("Move active window and switch to desktop #3")

4::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(3), layer2ShowOverlay("Switch to desktop #4")
^4::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(3), layer2ShowOverlay("Move active window to desktop #4")
!4::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(3), layer2ShowOverlay("Move active window and switch to desktop #4")

5::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(4), layer2ShowOverlay("Switch to desktop #5")
^5::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(4), layer2ShowOverlay("Move active window to desktop #5")
!5::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(4), layer2ShowOverlay("Move active window and switch to desktop #5")

6::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(5), layer2ShowOverlay("Switch to desktop #6")
^6::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(5), layer2ShowOverlay("Move active window to desktop #6")
!6::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(5), layer2ShowOverlay("Move active window and switch to desktop #6")

7::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(6), layer2ShowOverlay("Switch to desktop #7")
^7::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(6), layer2ShowOverlay("Move active window to desktop #7")
!7::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(6), layer2ShowOverlay("Move active window and switch to desktop #7")

8::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(7), layer2ShowOverlay("Switch to desktop #8")
^8::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(7), layer2ShowOverlay("Move active window to desktop #8")
!8::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(7), layer2ShowOverlay("Move active window and switch to desktop #8")

9::_virtualDesktopEnhancer.SwitchToDesktopNThenFocus(8), layer2ShowOverlay("Switch to desktop #9")
^9::_virtualDesktopEnhancer.MoveActiveWindowToDesktopNThenFocus(8), layer2ShowOverlay("Move active window to desktop #9")
!9::_virtualDesktopEnhancer.MoveActiveWindowThenSwitchToDesktopNAndFocus(8), layer2ShowOverlay("Move active window and switch to desktop #9")

#if