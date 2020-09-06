F17::MButton
F19::goForward()
F20::goBack()
; F21::_closeMonitorListener.Fire()

F22::AltTabAndMenu
#If IsMultitaskingViewExists()
	; alt key will remain pressed while inside the multitasking view
	!F22::AltTabMenuDismiss
	WheelUp::ShiftAltTab	
	WheelDown::AltTab
#if

F23::Send !{tab}
^F23::Send !{esc}

F24::windowQuickMinMax.MinimizeActiveWindow(), showOverlay("F24", "Minimize active window")
+F24::windowQuickMinMax.Restore(), showOverlay("+F24", "Restore previously minimized/maximized window")
^F24::windowQuickMinMax.MaximizeActiveWindow(), showOverlay("^F24", "Maximize active window")

#if GetKeyState("F18", "P")	; mapped to G11
	F24::virtualDesktopEnhancer.SwitchToPreviousDesktopThenFocus(), showOverlay("F18, F24", "Switch to previous dekstop")
	F23::virtualDesktopEnhancer.SwitchToNextDesktopThenFocus(), showOverlay("F18, F23", "Switch to next dekstop")

	F21::virtualDesktopEnhancer.CreateDesktop(), showOverlay("F18, F21", "Create a new desktop")
	F20::virtualDesktopEnhancer.DeleteCurrentDesktop(), showOverlay("F18, F20", "Delete current dekstop")

	F19::Send ^+{Escape}
#if