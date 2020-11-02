layer2ShowOverlay(description)
{
    showOverlay("F14 + " . A_ThisHotkey, description)
}

#If IsHolding("F14")

=::UpdateTrayIcon(2), layer2ShowOverlay("Change to layer 2")
^=::return
!=::return

^BackSpace::return
!BackSpace::return

^Tab::return
!Tab::return

^Escape::return
!Escape::return

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

#if