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
    __New(timeout := 150)
    {
        this._map := { 0: [""], 1: [""], 2: ["Ctrl"], 3: ["Alt"], 4: ["Ctrl", "Alt", "Shift"] }
        this._state := { }
        this._timeout := timeout
    }

    Tap(wk, keys, max)
    {
        if (!this._state.HasKey(keys))
        {
            this._state[keys] := new TamState(wk, keys, max)
        }

        ; todo: is it possible to ignore repeaated key?
        state := this._state[keys]
        state.Count += 1
        this.ResetTimer(state)
        this.OnEachTap(state)
    }

    OnEachTap(state)
    {
        ; when the current tap count == max,
        ; do the action and reset
        if (state.IsMaxCount())
        {
            this.OnReset(state)
        }
    }

    ; reset timer and rebind function
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
        ; on timeout
        ; do the action and reset
        this.OnReset(state)
    }

    OnReset(state)
    {
        keys := state.keys
        mods := this._map[state.Count]
        ; wrap the key in all the specified modifiers
        For idx, mod in mods {
            mod := mods[A_Index]
            keys := this.Wrap(keys, mod)
        }

        keys := this.Wrap(keys, state.Wk)

        SendInput % keys

        state.Count := 0
        state.TimerOff()
    }

    ; wk = wrapping key
    Wrap(key, wk)
    {
        if (wk)
        {
            return "{" . wk . " down}" . key . "{" . wk . " up}"
        } else {
            return key
        }
    }
}