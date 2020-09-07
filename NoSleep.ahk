SetTimer, MoveMouse, 10000

MoveMouse()
{
    global _overlay

    if (A_TimeIdle < 10 * 60 * 1000)
    {
        return
    }

    _overlay.Show("Drank coffee")
    MouseMove, 1, 0, 0, R
    MouseMove, -1, 0, 0, R
}