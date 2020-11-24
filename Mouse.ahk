class Mouse
{
    MoveHorizontal(delta)
    {
        this.Move(delta, 0)
    }

    MoveVertical(delta)
    {
        this.Move(0, delta)
    }

    Move(deltaX, deltaY)
    {
        MouseGetPos, mouseX, mouseY
        MouseMove, mouseX + deltaX, mouseY + deltaY, 0
    }

    MoveToPrimaryScreenCenter()
    {
        CoordMode, Mouse, Screen
        MouseMove, A_ScreenWidth / 2, A_ScreenHeight / 2, 0
        CoordMode, Mouse
        Send {Ctrl}
    }
}