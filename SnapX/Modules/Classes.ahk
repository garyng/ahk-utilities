class SizePosition
{
	__New(x="?", y="?", w="?", h="?", r="?", b="?", xo="?", yo="?")
	{
		this.x := x != "?" ? x : 0
		this.l := x != "?" ? x : 0
		this.y := y != "?" ? y : 0
		this.t := y != "?" ? y : 0
		this.w := w != "?" ? w : r != "?" ? r - x : 0
		this.h := h != "?" ? h : b != "?" ? b - y : 0
		this.r := r != "?" ? r : w != "?" ? x + w : 0
		this.b := b != "?" ? b : h != "?" ? y + h : 0
		this.cx := x != "?" && this.w ? x + this.w / 2 : 0
		this.cy := y != "?" && this.h ? y + this.h / 2 : 0
		this.xo := xo != "?" ? xo : 0
		this.yo := yo != "?" ? yo : 0
	}
}

class SnapMonitor
{
	__New(monitorId)
	{
		this.id := monitorId
		
		SysGet, monArea, Monitor, % monitorId
		this.area := new SizePosition(monAreaLeft, monAreaTop, , , monAreaRight, monAreaBottom)
		
		SysGet, monWorkArea, MonitorWorkArea, % monitorId
		this.workarea := new SizePosition(monWorkAreaLeft, monWorkAreaTop, , , monWorkAreaRight, monWorkAreaBottom, monWorkAreaLeft - monAreaLeft, monWorkAreaTop - monAreaTop)
	}
}

class SnapWindow
{
	__New(hwnd)
	{
		this.handle := hwnd
		
		this.position := new SizePosition(0, 0)
		this.snapped := 0
		this.grid := { left:0, top:0, width:0, height:0 }
		this.restoredpos := { left:0.0, top:0.0, width:0.0, height:0.0 } ; in percentage of monitor
	}
	
	updatePosition()
	{
;		WinGetPos, winX, winY, winW, winH, % "ahk_id " this.handle
		GetWindowPlacement(this.handle, wp) ; use this instead of WinGetPos in case the window is maximized when this is called
		WinGetPosEx(this.handle, , , , , xOffset, yOffset)
		this.position := new SizePosition(wp.rcNormalPosition.left, wp.rcNormalPosition.top, , , wp.rcNormalPosition.right, wp.rcNormalPosition.bottom, xOffset, yOffset)
	}
}

class WINDOWPLACEMENT
{
	; UINT, UINT, UINT, POINT, POINT, RECT
	__New(length, flags, showCmd, ptMinPosition, ptMaxPosition, rcNormalPosition)
	{
		this.length := length
		this.flags := flags
		this.showCmd := showCmd
		this.ptMinPosition := ptMinPosition
		this.ptMaxPosition := ptMaxPosition
		this.rcNormalPosition := rcNormalPosition
	}
}

class tagPOINT
{
	; LONG, LONG
	__New(x, y)
	{
		this.x := x
		this.y := y
	}
}

class _RECT
{
	; LONG, LONG, LONG, LONG
	__New(left, top, right, bottom)
	{
		this.left := left
		this.top := top
		this.right := right
		this.bottom := bottom
	}
}

class Operation
{
	static None            := 0
	static Minimized       := 1
	static Restored        := 2
	static Snapped         := 3
	static Moved           := 4
	static RestoredSnapped := 5
	static Maximized       := 6
}

class EVENT
{
	static MIN := 0x00000001
	static MAX := 0x7FFFFFFF
	
	class SYSTEM
	{
		static MOVESIZESTART := 0x000A
		static MOVESIZEEND   := 0x000B
	}
}

class WINEVENT
{
	OUTOFCONTEXT   := 0x0000
	SKIPOWNTHREAD  := 0x0001
	SKIPOWNPROCESS := 0x0002
	INCONTEXT      := 0x0004
}

class SizeOf
{
	static UInt         := 32 // 8
	static Int          := 32 // 8
	static Long         := SizeOf.Int
	static Point        := SizeOf.Long * 2
	static Rect         := SizeOf.Long * 4
	static Short        := 16 // 8
	static Variant_Bool := SizeOf.Short
}