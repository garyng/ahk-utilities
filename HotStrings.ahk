; Type datetime
:*:!!d::
	FormatTime, current, , dd/MM/yyyy HH:mm:ss
	Send %current%
	return
