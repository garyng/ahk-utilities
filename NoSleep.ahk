SetTimer, MoveMouse, % 9 * 60 * 1000

MoveMouse()
{
    global _overlay

    if (A_TimeIdle < 10 * 60 * 1000 
        Or !WinExist("A")) ; check whether the computer is locked
    {
        return
    }

    _overlay.Show("Drank coffee")
    MouseMove, 1, 0, 0, R
    MouseMove, -1, 0, 0, R
}