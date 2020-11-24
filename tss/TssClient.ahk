class RestClient
{
    __New(baseUri)
    {
        this._baseUri := baseUri
    }
    
    Get(endpoint)
    {
        http := this.Open("GET", endpoint)
        result := this.Send(http)
        return JSON.Load(result)
    }

    Post(endpoint, headers := "", data := "")
    {
        http := this.Open("POST", endpoint)
        For k, v in headers {
            MsgBox % k . " : " . v
            http.SetRequestHeader(k, v)
        }
        result := this.Send(http, data)
        return JSON.Load(result)
    }

    Open(method, endpoint)
    {
        http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        uri := this._baseUri . endpoint
        http.Open(method, uri, true)
        return http
    }

    Send(http, data := "")
    {
        if (data)
        {
            http.Send(data)
        } else {
            http.Send()
        }
        ; use `true` in `Open` and call `WaitForResponse` allows the script to remain responsive
        ; https://www.autohotkey.com/docs/commands/URLDownloadToFile.htm
        http.WaitForResponse()

        return http.ResponseText
    }

}

class TssClient
{
    __New()
    {
        this._client := new RestClient("http://localhost:8123")
        this._prompt := new Prompt()
        this._loggedIn := false
    }

    Login()
    {
        response := this._client.Get("/TryLogin")
        if (response.success)
        {
            this._loggedIn := true
            return
        }

        if (this._prompt.PromptMatchSpace("Tss", "login"))
        {
            Run % response.loginUrl
        }
        this._loggedIn := true
    }

    MoveCurrentToGood()
    {
        this.Login()
        this._client.Get("/MoveCurrentToGood")
    }

    MoveCurrentToNotGood()
    {
        this.Login()
        this._client.Get("/MoveCurrentToNotGood")
    }

}