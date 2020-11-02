; ,-----------. ,---------------.
; |  7|  8|  9| |Esc|Tab|  =|Bsp|
; `-----------' `---------------'
; ,-----------. ,---------------.
; |  4|  5|  6| | 00|  /|  *|  -|
; |-----------| |---------------|
; |  1|  2|  3| |Kp7|Kp8|Kp9|   |
; `-----------' |-----------|  +|
;               |Kp4|Kp5|Kp6|   |
;     ,---.     |---------------|
;     |Up |     |Kp1|Kp2|Kp3|   |
; ,-----------. |-----------|Ent|
; |Lef|Dow|Rig| |  Kp0  |  .|   |
; `-----------' `---------------'

UpdateTrayIcon(layer)
{
    global _layerConfig
    if (layer > 9)
    {
        layer := "9+"
    }

    Menu, Tray, Tip, % "Layer " . layer
    iconFileName := A_ScriptDir . "\icons\layers\layer-" . layer . ".png"

    if (FileExist(iconFileName))
    {
        Menu, Tray, Icon, % iconFileName
    }
    _layerConfig.Write("current", layer)
}

LoadLayerTrayIcon()
{
    global _layerConfig
    layer := _layerConfig.Read("current")
    UpdateTrayIcon(layer)
}

#Include, devices\numpad\Layer1.ahk
#Include, devices\numpad\Layer2.ahk
#Include, devices\numpad\Layer3.ahk
#Include, devices\numpad\Layer4.ahk