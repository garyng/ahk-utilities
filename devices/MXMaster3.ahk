; F17::
; F18::
; F19::
; F20::
; F21::
; F22::
; F23::
; F24::
; F24::_windowQuickMinMax.MinimizeActiveWindow(), showOverlay("F24", "Minimize active window")
; +F24::_windowQuickMinMax.Restore(), showOverlay("+F24", "Restore previously minimized/maximized window")
; ^F24::_windowQuickMinMax.MaximizeActiveWindow(), showOverlay("^F24", "Maximize active window")

F24::AltTabAndMenu
#If IsMultitaskingViewExists()
	; alt key will remain pressed while inside the multitasking view
	!F24::AltTabMenuDismiss
	WheelUp::ShiftAltTab	
	WheelDown::AltTab
#if