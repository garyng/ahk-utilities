; remap Home, End, Del, Insert ==========
Volume_Up::Del
Ins::Home
Del::End
; Home::Ins
; End::Del

; remap numpad =============
Numpad0::SendInput {F15}{Numpad0}
Numpad1::SendInput {F15}{Numpad1}
Numpad2::SendInput {F15}{Numpad2}
Numpad3::SendInput {F15}{Numpad3}
Numpad4::SendInput {F15}{Numpad4}
Numpad5::SendInput {F15}{Numpad5}
Numpad6::SendInput {F15}{Numpad6}
Numpad7::SendInput {F15}{Numpad7}
Numpad8::SendInput {F15}{Numpad8}
Numpad9::SendInput {F15}{Numpad9}
NumpadDiv::SendInput {F15}{NumpadDiv}
NumpadMult::SendInput {F15}{NumpadMult}
NumpadAdd::SendInput {F15}{NumpadAdd}
NumpadSub::SendInput {F15}{NumpadSub}
NumpadEnter::SendInput {F15}{NumpadEnter}
NumpadDot::SendInput {F15}{NumpadDot}
; scan codes are from https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0
; top left button on numpad
SC05B::SendInput {Ctrl}{F15}{NumpadLeft}
; top right button on numpad
SC05D::SendInput {Shift}{F15}{NumpadRight}