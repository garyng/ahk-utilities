SetTimer, MoveMouse, % 4 * 60 * 1000

MoveMouse()
{
    global _overlay
    FormatTime, current, , dd/MM/yyyy HH:mm:ss
    if (A_TimeIdle > 7 * 60 * 1000 
        And WinExist("A")) ; only when computer is not locked
    {
        _overlay.Show("Drank coffee")
        FileAppend, %current%: drank coffee`n, logs.txt
        MouseMove, 1, 0, 0, R
        MouseMove, -1, 0, 0, R
    }
    else
    {
        FileAppend, %current%: didnt drink coffee idle: %A_TimeIdle%`n, logs.txt
    }   
}

