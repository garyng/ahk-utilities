; List all hotkeys and hotstrings
class KeyLister
{
    ; _prompt
    ; _allHotStrings
    ; _allHotKeys
    __New(files*)
    {
        this._prompt := new Prompt(,,9,,,false)
        this._allHotStrings := ""
        this._allHotKeys := ""
        this.Parse(files)
    }

    Parse(files)
    {
        For index, file in files
        {
            hotStrings := ""
            hotKeys := ""
            this.ParseFile(file, hotStrings, hotKeys)
            this._allHotKeys .= hotKeys "`n"
            this._allHotStrings .= hotStrings "`n"
        }
    }

    ParseFile(file, ByRef hotStrings, ByRef hotKeys)
    {
        Loop, Read, %file%
        {
            line := A_LoopReadLine
            ; to avoid this line being parsed 
            If (not (InStr(line, "::") 
                        and InStr(line, ";#;")))
            {
                Continue
            }
            labelAndDesc := StrSplit(line, "::") 
            label := labelAndDesc[1]
            desc := StrSplit(labelAndDesc[2], ";#;")[2]


            if (this.IsHotString(label))
            {
                hotStrings .= this.Pad(this.HumanizeHotstring(label)) . desc . "`n"
            }
            else
            {
                hotKeys .= this.Pad(this.HumanizeHotkey(label)) . desc . "`n"
            }
        }
    }


    HumanizeHotstring(label)
    {
        label := RegExReplace(label, ":.*:")
        return label
    }

    HumanizeHotkey(label)
    {
        replacement := {}
        replacement["~"] := ""
        replacement["#"] := "Win-"
        replacement["!"] := "Alt-"
        replacement["^"] := "Ctrl-"
        replacement["+"] := "Shift-"
        replacement[" &"] := ","
        For search, replace in replacement
        {
            label := StrReplace(label, search, replace)
        }
        return label
    }

    IsHotString(label)
    {
        return SubStr(label, 1, 1) = ":"
    }

    Pad(text)
    {
        return SubStr(text " --------------------", 1, 20)
    }
    
    Show()
    {
        
        Gui, -Caption +ToolWindow +LastFound +AlwaysOnTop
		Gui, Color, 202020
		Gui, Font, cWhite
        Gui, Font, s11, Consolas
        Gui, Add, Text, % "+Center", % "-- All Hotkeys and Hotstrings --"
		Gui, Font, s9, Consolas
        Gui, Add, Text,, % this._allHotKeys this._allHotStrings
		WinSet, Transparent, 200
		Gui, Show, y0
		Input, userInput, L1
		Gui, Destroy
        return userInput
    }
}