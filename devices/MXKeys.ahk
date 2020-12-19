; remap Home, End, Del, Insert ==========
Volume_Up::Del
Ins::Home
Del::End
; Home::Ins
; End::Del

TamF15(max, hotkey := "")
{
    global _tam
    hotkey := hotkey ? hotkey : "{" . A_ThisHotkey . "}"
    _tam.Tap("F15", hotkey, max)
}

; remap numpad =============
Numpad0::TamF15(4)
Numpad1::TamF15(4)
Numpad2::TamF15(4)
Numpad3::TamF15(4)
Numpad4::TamF15(4)
Numpad5::TamF15(4)
Numpad6::TamF15(4)
Numpad7::TamF15(4)
Numpad8::TamF15(4)
Numpad9::TamF15(4)
NumpadDiv::TamF15(4)
NumpadMult::TamF15(4)
NumpadAdd::TamF15(4)
NumpadSub::TamF15(4)
NumpadEnter::TamF15(4)
NumpadDot::TamF15(4)
; scan codes are from https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0
; top left button on numpad
SC05B::TamF15(4, "{NumpadLeft}")
; top right button on numpad
SC05D::TamF15(4, "{NumpadRight}")