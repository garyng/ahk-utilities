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

class TamState
{
    __New(keys, max)
    {
        this.Count := 0
        this.Max := max
        this.Keys := keys
        ; this.Timer := 
        ; this.Finished := false
    }

    IsMaxCount()
    {
        return this.Count == this.Max
    }
}

class TapAutoMod
{
    __New()
    {
        this._map := { 0: "", 1: "", 2: "Ctrl", 3: "Alt", 4: "Shift", 5: "LWin" }
        this._state := { "abc": 1 }
        this._timeout := 300
    }

    Test()
    {
        this._state["abc"] += 1
        MsgBox, % this._state["abc"]
    }

    Tap(keys, max)
    {
        if (!this._state.HasKey(keys))
        {
            this._state[keys] := new TamState(keys, max)
        }

        state := this._state[keys]
        state.Count += 1
        this.ResetTimer(state)
        this.OnEachTap(state)
    }

    OnEachTap(state)
    {
        if (state.IsMaxCount())
        {
            this.OnReset(state)
            ; mod := this._map[state.Count]
            ; keys := this.Down(mod) . "{" . state.Keys . "}" . this.Up(mod)
            ; SendInput % keys
            ; state.Finished := true
            ; reset timer
        }
    }

    ResetTimer(state)
    {
        func := ObjBindMethod(this, "OnTimeout", state)

        if (state.Timer)
        {
            oldFunc := state.Timer
            SetTimer, % oldFunc, Off
        }
        
        state.Timer := func
        ; negative for one-time timer
        SetTimer, % func, % -this._timeout
    }

    OnTimeout(state)
    {
        this.OnReset(state)
    }

    OnReset(state)
    {
        ; if (state.Finished)
        ; {
        ;     MsgBox, finished??
        ;     return
        ; }

        keys := "{" . state.keys "}"
        mod := this._map[state.Count]
        
        if (mod)
        {
            keys := this.Down(mod) . keys . this.Up(mod)
        }
        SendInput % keys

        ; state.Finished := true
        state.Count := 0
        ; state.Keys := keys
        if (state.Timer)
        {
            oldFunc := state.Timer
            SetTimer, % oldFunc, Off
        }
    }

    Down(key)
    {
        return "{" . key . " down}"
    }

    Up(key)
    {
        return "{" . key . " up}"
    }
}