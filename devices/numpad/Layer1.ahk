layer1ShowOverlay(description)
{
    showOverlay("F13` + " . A_ThisHotkey, description)
}

#If IsHolding("F13")

BackSpace::UpdateTrayIcon(1), layer1ShowOverlay("Change to layer 1")
^BackSpace::return
!BackSpace::return

NumpadSub::_windowSwitcher.Switch("xyplorer"), layer1ShowOverlay("Switch to xyplorer")
^NumpadSub::_windowSwitcher.Launch("xyplorer"), layer1ShowOverlay("Launch xyplorer")
!NumpadSub::return

NumpadMult::_windowSwitcher.Switch("visualstudio"), layer1ShowOverlay("Switch to visual studio")
^NumpadMult::_windowSwitcher.Launch("visualstudio"), layer1ShowOverlay("Launch visual studio")
!NumpadMult::return

NumpadDiv::return
^NumpadDiv::return
!NumpadDiv::return

NumpadAdd::_windowSwitcher.Switch("tasks"), layer1ShowOverlay("Switch to tasks")
^NumpadAdd::_windowSwitcher.Reset("tasks"), layer1ShowOverlay("Reset tasks")
!NumpadAdd::_windowSwitcher.Launch("firefox"), layer1ShowOverlay("Launch firefox")

NumpadEnter::return
^NumpadEnter::return
!NumpadEnter::return

Numpad9::_windowSwitcher.Switch("vscode"), layer1ShowOverlay("Switch to vscode")
^Numpad9::_windowSwitcher.Launch("vscode"), layer1ShowOverlay("Launch vscode")
!Numpad9::return

Numpad8::return
^Numpad8::return
!Numpad8::return

Numpad7::return
^Numpad7::return
!Numpad7::return

Numpad6::_windowSwitcher.Switch("wt"), layer1ShowOverlay("Switch to terminal")
^Numpad6::_windowSwitcher.Launch("wt"), layer1ShowOverlay("Launch terminal")
!Numpad6::return

Numpad5::return
^Numpad5::return
!Numpad5::return

Numpad4::return
^Numpad4::return
!Numpad4::return

Numpad3::_windowSwitcher.Switch("obsidian"), layer1ShowOverlay("Switch to obsidian")
^Numpad3::_windowSwitcher.Launch("obsidian"), layer1ShowOverlay("Launch obsidian")
!Numpad3::return

Numpad2::_windowSwitcher.Switch("notes_vscode"), layer1ShowOverlay("Switch to notes")
^Numpad2::_windowSwitcher.Launch("notes_vscode"), layer1ShowOverlay("Launch notes")
!Numpad2::return

Numpad1::return
^Numpad1::return
!Numpad1::return

NumpadDot::_windowSwitcher.Launch("firefox"), layer1ShowOverlay("Launch firefox")
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