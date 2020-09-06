_homeEndKeyRemapListener := new MultiplePressListener(4, Func("ToggleHomeEndKeyRemap"), 700)

#if !_enableHomeEndKeyRemap
	ins::_homeEndKeyRemapListener.Fire()
#if

#if _enableHomeEndKeyRemap
	; remap ins key to end key
	; F12 key to home key
	; Volume Down to F12 (Fn + F12 = Volume Down)
	; Ctrl + Volume Down to Volume Down	
	F12::home
	ins::end
	Volume_Down::F12
	^Volume_Down::Volume_Down
#if

ToggleHomeEndKeyRemap()
{
	global _enableHomeEndKeyRemap
	_enableHomeEndKeyRemap := !_enableHomeEndKeyRemap
	if (_enableHomeEndKeyRemap)
	{
		overlay.Show("ins *4", "Enable Home && End key remapping")
	}
}