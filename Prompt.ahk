class Prompt
{
    ; _backgroundColor
    ; _textColor
    ; _fontSize
    ; _font
    ; _transparency
    ; _centerText

    __New(backgroundColor := 202020, textColor := "White", fontSize := 10, font := "Consolas", transparency := 200, centerText := true)
    {
        this._backgroundColor := backgroundColor
        this._textColor := textColor
        this._fontSize := fontSize
        this._font := font
        this._transparency := transparency
        this._centerText := centerText
    }

    Prompt(text)
    {
        Gui, -Caption +ToolWindow +LastFound +AlwaysOnTop
		Gui, Color, % this._backgroundColor
		Gui, Font, % "c" this._textColor
		Gui, Font, % "s" this._fontSize, % this._font
        Gui, Add, Text, % this._centerText ? "+Center" : "" , % text
		WinSet, Transparent, % this._transparency
		Gui, Show, y0
		Input, userInput, L1
		Gui, Destroy
        return userInput
    }

    ; Return true if user input match
    PromptMatchInput(text, match)
    {
        return this.Prompt(text) = match
    }

    ; Return true if user input is space
    ; `n[Space to `action`] will be appended to the text
    PromptMatchSpace(text, action)
    {
        return this.PromptMatchInput(text . "`n[Space to " . action . "]", " ")
    }

    Show(text)
    {
        Gui, New
        Gui, -Caption +ToolWindow +LastFound +AlwaysOnTop +Hwndhwnd
        Gui, %hwnd%:Default
		Gui, Color, % this._backgroundColor
		Gui, Font, % "c" this._textColor
		Gui, Font, % "s" this._fontSize, % this._font
        Gui, Add, Text, % this._centerText ? "+Center" : "" , % text
		WinSet, Transparent, % this._transparency
		Gui, Show, y0 NoActivate

        callback := ObjBindMethod(this, "destroyGui", hwnd)
        SetTimer, % callBack, -1000
    }
    
    destroyGui(hwnd)
    {
        Gui, %hwnd%:Destroy
    }
}