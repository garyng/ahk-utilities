; remap Home, End, Del, Insert ==========
Volume_Up::Del
Ins::Home
Del::End
; Home::Ins
; End::Del

TamF12(max, hotkey := "")
{
    global _tam
    hotkey := hotkey ? hotkey : "{" . A_ThisHotkey . "}"
    _tam.Tap("F12", hotkey, max)
}

TamBare(max, hotkey := "")
{
    global _tam
    hotkey := hotkey ? hotkey : "{" . A_ThisHotkey . "}"
    _tam.Tap("", hotkey, max)
}

; remap numpad =============
Numpad0::TamF12(4)
Numpad1::TamF12(4)
Numpad2::TamF12(4)
Numpad3::TamF12(4)
Numpad4::TamF12(4)
Numpad5::TamF12(4)
Numpad6::TamF12(4)
Numpad7::TamF12(4)
Numpad8::TamF12(4)
Numpad9::TamF12(4)
NumpadDiv::TamF12(4)
NumpadMult::TamF12(4)
NumpadAdd::TamF12(4)
NumpadSub::TamF12(4)
NumpadEnter::TamF12(4)
NumpadDot::TamF12(4)
; scan codes are from https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0
; top left button on numpad
SC05B::TamF12(4, "{NumpadLeft}")
; top right button on numpad
SC05D::TamF12(4, "{NumpadRight}")

; other mappings =============
F5::TamBare(4)