; Modifiers keys combinations
; useful for custom keys combinations

IsNone()
{
	return !IsShift() && !IsCtrl()
}

IsOnlyShift()
{
	return IsShift() && !IsCtrl()
}

IsOnlyCtrl()
{
	return !IsShift() && IsCtrl()
}

IsShift()
{
	return GetKeyState("Shift", "P")
}

IsCtrl()
{
	return GetKeyState("Ctrl", "P")
}

IsMultitaskingViewExists()
{
	return WinExist("ahk_class MultitaskingViewFrame")
}

IsHolding(keyname)
{
    return GetKeyState(keyname, "P")
}
