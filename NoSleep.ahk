SetTimer, MoveMouse, % 3 * 60 * 1000

MoveMouse()
{
    global _overlay
    FormatTime, current, , dd/MM/yyyy HH:mm:ss
    if (A_TimeIdle > 7 * 60 * 1000 
        And WinExist("A")) ; only when computer is not locked
    {
        _overlay.Show("Drank coffee")
        MouseMove, 1, 0, 0, R
        MouseMove, -1, 0, 0, R
    }
}

