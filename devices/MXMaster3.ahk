F17::
; F18::
; F19::
; F20::
; F21::

F22::AltTabAndMenu
#If IsMultitaskingViewExists()
	; alt key will remain pressed while inside the multitasking view
	!F22::AltTabMenuDismiss
	WheelUp::ShiftAltTab	
	WheelDown::AltTab
#if

; F23::

F24::windowQuickMinMax.MinimizeActiveWindow(), showOverlay("F24", "Minimize active window")
+F24::windowQuickMinMax.Restore(), showOverlay("+F24", "Restore previously minimized/maximized window")
^F24::windowQuickMinMax.MaximizeActiveWindow(), showOverlay("^F24", "Maximize active window")