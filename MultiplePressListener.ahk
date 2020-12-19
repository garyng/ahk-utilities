class MultiplePressListener
{
    __New(targetCount, onTriggeredFunc, timeout := 700)
    {
        this._targetCount := targetCount
        this._count := 0

        this._onTriggeredFunc := onTriggeredFunc
        this._timeout := timeout
        this._onTimeout := ObjBindMethod(this, "onTimeout")
    }

    Fire()
    {
        If (this._count > 0)
        {
            this._count += 1
            return
        }
        this._count := 1

        ; SetTimer requires a plain variable reference
        ; Reference: https://autohotkey.com/docs/commands/SetTimer.htm#ExampleClass
        timeoutFunc := this._onTimeout
        SetTimer % timeoutFunc, % this._timeout

        ; todo: trigger when new count is equal to target count
        ; todo: handle interruption?
    }

    onTimeout()
    {
        timeoutFunc := this._onTimeout
        SetTimer, % timeoutFunc, Off

        If (this._count >= this._targetCount)
        {
            this._onTriggeredFunc.Call()
        }

        this._count := 0
    }
}