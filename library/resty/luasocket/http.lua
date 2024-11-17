---@meta

--- load a version of resty-http using luasocket as a fallback
--- this enables http requests in the "init" phase where cosockets
--- are unavailable.
---
--- **NOTE**: the socket compatibility is not sturdy enough to have the http-client
--- make multiple requests over the same connection. So after each request create
--- a new http client and do not re-use it.
---
--- **NOTE**: see section [Important notes](../topics/manual.md.html#Important_notes) in the manual for limitations.
---
---```lua
--- -- usage in the init phase (or other phases were co-sockets are unavailable)
--- local httpc = require "resty.luasocket.http"
--- local res, err = httpc:request_uri("http://example.com/helloworld", {
---   method = "POST",
---   body = "a=1&b=2",
---   headers = {
---       ["Content-Type"] = "application/x-www-form-urlencoded",
---   },
--- })
---```
---
---@module 'resty.http'
local http
return http
