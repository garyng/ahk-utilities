class Config
{
    __New(section, fileName := "config.ini")
    {
        this._section := section
        this._fileName := filename
    }

    Write(key, value) 
    {
        IniWrite % value, % this._filename, % this._section, % key
    }

    Read(key, default := "")
    {
        IniRead, out, % this._filename, % this._section, % key, % default
        return out
    }
}