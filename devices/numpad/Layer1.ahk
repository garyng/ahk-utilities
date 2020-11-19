layer1ShowOverlay(description)
{
    showOverlay("F13` + " . A_ThisHotkey, description)
}

#If IsHolding("F13")

BackSpace::UpdateTrayIcon(1), layer1ShowOverlay("Change to layer 1")
^BackSpace::
    Run *RunAs "iisreset.exe"
	showOverlay("!F1", "Reset IIS")
	return
!BackSpace::return

NumpadSub::_windowSwitcher.Switch("slack"), layer1ShowOverlay("Switch to slack")
^NumpadSub::_windowSwitcher.Launch("slack"), layer1ShowOverlay("Launch slack")
!NumpadSub::return

NumpadMult::_windowSwitcher.Switch("ccmp_vs"), layer1ShowOverlay("Switch to ccmp visual studio")
^NumpadMult::_windowSwitcher.Launch("ccmp_vs"), layer1ShowOverlay("Launch ccmp visual studio")
!NumpadMult::return

NumpadDiv::_windowSwitcher.Switch("visualstudio"), layer1ShowOverlay("Switch to visual studio")
^NumpadDiv::_windowSwitcher.Launch("visualstudio"), layer1ShowOverlay("Launch visual studio")
!NumpadDiv::return

NumpadAdd::_windowSwitcher.Switch("tasks"), layer1ShowOverlay("Switch to tasks")
^NumpadAdd::_windowSwitcher.Reset("tasks"), layer1ShowOverlay("Reset tasks")
!NumpadAdd::_windowSwitcher.Launch("chrome"), layer1ShowOverlay("Launch chrome")

NumpadEnter::_windowSwitcher.Switch("local"), layer1ShowOverlay("Switch to local")
^NumpadEnter::_windowSwitcher.Reset("local"), layer1ShowOverlay("Reset local")
!NumpadEnter::_windowSwitcher.Launch("chrome"), layer1ShowOverlay("Launch chrome")

Numpad9::_windowSwitcher.Switch("ccmp_vscode"), layer1ShowOverlay("Switch to ccmp vscode")
^Numpad9::_windowSwitcher.Launch("ccmp_vscode"), layer1ShowOverlay("Launch ccmp vscode")
!Numpad9::return

Numpad8::_windowSwitcher.Switch("tickets_vscode"), layer1ShowOverlay("Switch to tickets")
^Numpad8::_windowSwitcher.Launch("tickets_vscode"), layer1ShowOverlay("Launch tickets")
!Numpad8::return

Numpad7::_windowSwitcher.Switch("vscode"), layer1ShowOverlay("Switch to vscode")
^Numpad7::_windowSwitcher.Launch("vscode"), layer1ShowOverlay("Launch vscode")
!Numpad7::return

Numpad6::_windowSwitcher.Switch("ccmp_wt"), layer1ShowOverlay("Switch to terminal")
^Numpad6::_windowSwitcher.Launch("ccmp_wt"), layer1ShowOverlay("Launch terminal")
!Numpad6::return

Numpad5::_windowSwitcher.Switch("wt"), layer1ShowOverlay("Switch to terminal")
^Numpad5::_windowSwitcher.Launch("wt"), layer1ShowOverlay("Launch terminal")
!Numpad5::return

Numpad4::_windowSwitcher.Switch("postman"), layer1ShowOverlay("Switch to postman")
^Numpad4::_windowSwitcher.Launch("postman"), layer1ShowOverlay("Launch postman")
!Numpad4::return

Numpad3::_windowSwitcher.Switch("datagrip"), layer1ShowOverlay("Switch to datagrip")
^Numpad3::_windowSwitcher.Reset("datagrip"), layer1ShowOverlay("Reset datagrip")
!Numpad3::return

Numpad2::_windowSwitcher.Switch("obsidian"), layer1ShowOverlay("Switch to obsidian")
^Numpad2::_windowSwitcher.Launch("obsidian"), layer1ShowOverlay("Launch obsidian")
!Numpad2::return

Numpad1::_windowSwitcher.Switch("linqpad"), layer1ShowOverlay("Switch to linqpad")
^Numpad1::_windowSwitcher.Launch("linqpad"), layer1ShowOverlay("Launch obsidian")
!Numpad1::return

NumpadDot::_windowSwitcher.Launch("chrome"), layer1ShowOverlay("Launch chrome")
^NumpadDot::return
!NumpadDot::return

Numpad0::_windowSwitcher.Switch("fork"), layer1ShowOverlay("Switch to fork")
^Numpad0::_windowSwitcher.Launch("fork"), layer1ShowOverlay("Launch fork")
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