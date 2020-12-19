; remap Home, End, Del, Insert ==========
Volume_Up::Del
Ins::Home
Del::End
; Home::Ins
; End::Del

TamF20(max, hotkey := "")
{
    global _tam
    hotkey := hotkey ? hotkey : "{" . A_ThisHotkey . "}"
    _tam.Tap("F20", hotkey, max)
}

; remap numpad =============
Numpad0::TamF20(4)
Numpad1::TamF20(4)
Numpad2::TamF20(4)
Numpad3::TamF20(4)
Numpad4::TamF20(4)
Numpad5::TamF20(4)
Numpad6::TamF20(4)
Numpad7::TamF20(4)
Numpad8::TamF20(4)
Numpad9::TamF20(4)
NumpadDiv::TamF20(4)
NumpadMult::TamF20(4)
NumpadAdd::TamF20(4)
NumpadSub::TamF20(4)
NumpadEnter::TamF20(4)
NumpadDot::TamF20(4)
; scan codes are from https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0
; top left button on numpad
SC05B::TamF20(4, "{NumpadLeft}")
; top right button on numpad
SC05D::TamF20(4, "{NumpadRight}")