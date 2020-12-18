class TamState
{
    __New(wk, keys, max)
    {
        this.Wk := wk
        this.Count := 0
        this.Max := max
        this.Keys := keys
        ; this.Timer := 
    }

    IsMaxCount()
    {
        return this.Count == this.Max
    }

    TimerOff()
    {
        if (this.Timer)
        {
            oldFunc := this.Timer
            SetTimer, % oldFunc, Off
        }
        
        this.Timer := ""
    }
}

class TapAutoMod
{
    __New()
    {
        this._map := { 0: "", 1: "", 2: "Ctrl", 3: "Alt", 4: "Shift", 5: "LWin" }
        this._state := { }
        this._timeout := 300
    }

    Tap(wk, keys, max)
    {
        if (!this._state.HasKey(keys))
        {
            this._state[keys] := new TamState(wk, keys, max)
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
        }
    }

    ResetTimer(state)
    {
        state.TimerOff()

        func := ObjBindMethod(this, "OnTimeout", state)
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
        mod := this._map[state.Count]
        keys := this.Wrap(this.Wrap(state.keys, mod), state.Wk)

        SendInput % keys

        state.Count := 0
        state.TimerOff()
    }

    Down(key)
    {
        return "{" . key . " down}"
    }

    Up(key)
    {
        return "{" . key . " up}"
    }

    ; wk = wrapping key
    Wrap(key, wk)
    {
        if (wk)
        {
            return this.Down(wk) . key . this.Up(wk)
        } else {
            return key
        }
    }
}