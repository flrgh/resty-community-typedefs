---@meta

--- Lua HTTP client cosocket driver for [OpenResty](http://openresty.org/) / [ngx_lua](https://github.com/openresty/lua-nginx-module).
---
--- See: https://github.com/ledgetech/lua-resty-http/
---@class resty.http
local http = {}


--- Creates the HTTP connection object.
---
--- In case of failures, returns nil and a string describing the error.
---
---@return resty.http.client? client
---@return string?            error
function http.new() end


---@class resty.http.client
---@field sock ngx.socket.tcp
---@field keepalive boolean
local client = {}


---@class resty.http.connect.opts
---
---@field scheme?                string            # scheme to use, or nil for unix domain socket
---@field host                   string            # target host, or path to a unix domain socket
---@field port?                  number            # port on target host, will default to `80` or `443` based on the scheme
---
---@field pool?                  string            # custom connection pool name. Option as per [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsockconnect), except that the default will become a pool name constructed using the SSL / proxy properties, which is important for safe connection reuse. When in doubt, leave it blank!
---@field pool_size?             number            # option as per [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsockconnect)
---@field backlog?               number            # option as per [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsockconnect)
---
---@field proxy_opts?            resty.http.proxy.opts # sub-table, defaults to the global proxy options set, see [set_proxy_options](#set_proxy_options).
---
---@field ssl_reused_session     any               # option as per [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsocksslhandshake)
---@field ssl_verify             boolean           # option as per [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsocksslhandshake), except that it defaults to `true`.
---@field ssl_server_name?       string            # option as per [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsocksslhandshake)
---@field ssl_send_status_req?   any               # option as per [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsocksslhandshake)
---@field ssl_client_cert        ffi.cdata*        # will be passed to `tcpsock:setclientcert()`.
---@field ssl_client_priv_key    ffi.cdata*


--- Attempts to connect to the web server while incorporating the following activities:
---
--- - TCP connection
--- - SSL handshake
--- - HTTP proxy configuration
---
--- In doing so it will create a distinct connection pool name that is safe to use with SSL and / or proxy based connections, and as such this syntax is strongly recommended over the original (now deprecated) [TCP only connection syntax](#TCP-only-connect).
---
---@param  options resty.http.connect.opts
---@return boolean ok
---@return string? err
---@return any?    ssl_session
function client:connect(options) end

http.connect = client.connect


--- Sets the socket timeout (in ms) for subsequent operations. See [set_timeouts](#set_timeouts) below for a more declarative approach.
---@param time number
function client:set_timeout(time) end


--- Sets the connect timeout threshold, send timeout threshold, and read timeout threshold, respectively, in milliseconds, for subsequent socket operations (connect, send, receive, and iterators returned from receiveuntil).
---@param connect_timeout? number
---@param send_timeout? number
---@param read_timeout? number
function client:set_timeouts(connect_timeout, send_timeout, read_timeout) end


--- Either places the current connection into the pool for future reuse, or closes the connection. Calling this instead of [close](#close) is "safe" in that it will conditionally close depending on the type of request. Specifically, a `1.0` request without `Connection: Keep-Alive` will be closed, as will a `1.1` request with `Connection: Close`.
---
--- In case of success, returns `1`. In case of errors, returns `nil, err`. In the case where the connection is conditionally closed as described above, returns `2` and the error string `connection must be closed`, so as to distinguish from unexpected errors.
---
--- See [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive) for parameter documentation.
---
---@param  max_idle_timeout number
---@param  pool_size        number
---@return boolean          ok
---@return string?          error
function client:set_keepalive(max_idle_timeout, pool_size) end


--- Configure an HTTP proxy to be used with this client instance. The `opts` table expects the following fields:
---
--- * `http_proxy`: an URI to a proxy server to be used with HTTP requests
--- * `http_proxy_authorization`: a default `Proxy-Authorization` header value to be used with `http_proxy`, e.g. `Basic ZGVtbzp0ZXN0`, which will be overriden if the `Proxy-Authorization` request header is present.
--- * `https_proxy`: an URI to a proxy server to be used with HTTPS requests
--- * `https_proxy_authorization`: as `http_proxy_authorization` but for use with `https_proxy` (since with HTTPS the authorisation is done when connecting, this one cannot be overridden by passing the `Proxy-Authorization` request header).
--- * `no_proxy`: a comma separated list of hosts that should not be proxied.
---
--- Note that this method has no effect when using the deprecated [TCP only connect](#TCP-only-connect) connection syntax.
---
---@param opts resty.http.proxy.opts
function client:set_proxy_options(opts) end


---@class resty.http.proxy.opts : table
---
---@field http_proxy?               string # an URI to a proxy server to be used with HTTP requests
---@field http_proxy_authorization? string # a default `Proxy-Authorization` header value to be used with `http_proxy`, e.g. `Basic ZGVtbzp0ZXN0`, which will be overriden if the `Proxy-Authorization` request header is present.
---
---@field https_proxy?               string # an URI to a proxy server to be used with HTTPS requests
---@field https_proxy_authorization? string # as `http_proxy_authorization` but for use with `https_proxy` (since with HTTPS the authorisation is done when connecting, this one cannot be overridden by passing the `Proxy-Authorization` request header).
---
---@field no_proxy? string # a comma separated list of hosts that should not be proxied.


--- Get connection reuse count.
--- [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsockgetreusedtimes).
---@return number? times
---@return string? error
function client:get_reused_times() end


--- Close the connection.
--- See [OpenResty docs](https://github.com/openresty/lua-nginx-module#tcpsockclose).
---@return boolean ok
---@return string? error
function client:close() end

http.close = client.close

---@alias resty.http.body_reader fun(buffer_size:number): string, string


---@class resty.http.request.params
---
---@field version? number       # HTTP version number. Defaults to `1.1`.
---@field method?  string       # HTTP method string. Defaults to `GET`.
---@field path?    string       # path string. Defaults to `/`.
---@field query?   string|table # query string, presented as either a literal string or Lua table
---@field headers? table        # table of request headers
---@field body?    string|string[]|function # request body as a string, a table of strings, or an iterator function yielding strings until nil when exhausted. Note that you must specify a `Content-Length` for the request body, or specify `Transfer-Encoding: chunked` and have your function implement the encoding. See also: [get_client_body_reader](#get_client_body_reader)).


---@class resty.http.response
---
---@field status        number                 # status code
---@field reason        string                 # status reason phrase.
---@field headers       table                  # table of headers. Multiple headers with the same field name will be presented as a table of values.
---@field has_body      boolean                # boolean flag indicating if there is a body to be read.
---@field body_reader   resty.http.body_reader # iterator function for reading the body in a streaming fashion.
local response = {}


--- Reads the entire response body into a string.
---@return string? body
---@return string? error
function response:read_body() end


--- Merge any trailers underneath the headers, after reading the body.
function response:read_trailers() end


--- Sends an HTTP request over an already established connection. Returns a `res` table or `nil` and an error message.
---
---
---@param  params               resty.http.request.params
---@return resty.http.response? res
---@return string?              error
function client:request(params) end


---@class resty.http.request_uri.response
---@field status  number # The status code.
---@field headers table  # A table of headers.
---@field body    string # The entire response body as a string.


---@class resty.http.request_uri.params : resty.http.connect.opts, resty.http.request.params
---@field keepalive?         boolean # Set to `false` to disable keepalives and immediately close the connection. Defaults to `true`.
---@field keepalive_timeout? number  # The maximal idle timeout (ms). Defaults to `lua_socket_keepalive_timeout`.
---@field keepalive_pool?    number  # The maximum number of connections in the pool. Defaults to `lua_socket_pool_size`.


--- Single-shot request interface.
---
--- Since this method performs an entire end-to-end request, options specified in the `params` can include anything found in both `connect()` and `request()` documented above.
---
--- Note also that fields `path`, and `query`, in `params` will override relevant components of the `uri` if specified (`scheme`, `host`, and `port` will always be taken from the `uri`).
---
---
---@param  uri                              string
---@param  params                           resty.http.request_uri.params
---@return resty.http.request_uri.response? res
---@return string?                          error
function client:request_uri(uri, params) end


--- Perform multiple requests.
---
--- This method works as per the `request()` method above, but `params` is instead a nested table of parameter tables.
---
--- Each request is sent in order, and `responses` is returned as a table of response handles. For example:
---
---```lua
---  local responses = client:request_pipeline({
---      { path = "/b" },
---      { path = "/c" },
---      { path = "/d" },
---  })
---
---  for _, r in ipairs(responses) do
---      if not r.status then
---          ngx.log(ngx.ERR, "socket read error")
---          break
---      end
---
---      ngx.say(r.status)
---      ngx.say(r:read_body())
---  end
---```
---
--- Due to the nature of pipelining, no responses are actually read until you attempt to use the response fields (status / headers etc). And since the responses are read off in order, you must read the entire body (and any trailers if you have them), before attempting to read the next response.
---
--- Note this doesn't preclude the use of the streaming response body reader. Responses can still be streamed, so long as the entire body is streamed before attempting to access the next response.
---
--- Be sure to test at least one field (such as status) before trying to use the others, in case a socket read error has occurred.
---
---@param  params                resty.http.request.params[]
---@return resty.http.response[] responses
function client:request_pipeline(params) end


---@class resty.http.parsed_uri : table
---@field [1] string  # scheme
---@field [2] string  # host
---@field [3] number  # port
---@field [4] string  # path
---@field [5] string? # query


--- This is a convenience function allowing one to more easily use the generic interface, when the input data is a URI.
---
--- As of version `0.10`, the optional `query_in_path` parameter was added, which specifies whether the querystring is to be included in the `path` return value, or separately as its own return value. This defaults to `true` in order to maintain backwards compatibility. When set to `false`, `path` will only include the path, and `query` will contain the URI args, not including the `?` delimiter.
---
---@param  uri                   string
---@param  query_in_path?        boolean
---@return resty.http.parsed_uri parsed
function client:parse_uri(uri, query_in_path) end


http.parse_uri = client.parse_uri


--- Returns an iterator function which can be used to read the downstream client request body in a streaming fashion.
---
--- You may also specify an optional default chunksize (default is `65536`), or an already established socket in
--- place of the client request.
---
--- Example:
---
---```lua
---  local req_reader = client:get_client_body_reader()
---  local buffer_size = 8192
---
---  repeat
---      local buffer, err = req_reader(buffer_size)
---      if err then
---          ngx.log(ngx.ERR, err)
---          break
---      end
---
---      if buffer then
---          -- process
---      end
---  until not buffer
---```
---
--- This iterator can also be used as the value for the body field in request params, allowing one to stream the request body into a proxied upstream request.
---
---```lua
---  local client_body_reader, err = client:get_client_body_reader()
---
---  local res, err = client:request({
---      path = "/helloworld",
---      body = client_body_reader,
---  })
---```
---@param  chunksize? number
---@param  sock?      ngx.socket.tcp
---@return resty.http.body_reader
function client:get_client_body_reader(chunksize, sock) end


--- Connect to an http proxy.
---
--- Calling this method manually is no longer necessary since it is incorporated within `connect()`. It is retained for now for compatibility with users of the older TCP only connect syntax.
---
--- Attempts to connect to the web server through the given proxy server. The method accepts the following arguments:
---
--- If an error occurs during the connection attempt, this method returns `nil` with a string describing the error. If the connection was successfully established, the method returns `1`.
---
--- There's a few key points to keep in mind when using this api:
---
--- * If the scheme is `https`, you need to perform the TLS handshake with the remote server manually using the `ssl_handshake()` method before sending any requests through the proxy tunnel.
--- * If the scheme is `http`, you need to ensure that the requests you send through the connections conforms to [RFC 7230](https://tools.ietf.org/html/rfc7230) and especially [Section 5.3.2.](https://tools.ietf.org/html/rfc7230#section-5.3.2) which states that the request target must be in absolute form. In practice, this means that when you use `send_request()`, the `path` must be an absolute URI to the resource (e.g. `http://example.com/index.html` instead of just `/index.html`).
---
---@deprecated
---
---@param proxy_uri string             # Full URI of the proxy server to use (e.g. `http://proxy.example.com:3128/`). Note: Only `http` protocol is supported.
---@param scheme    "http"|"https" # The protocol to use between the proxy server and the remote host. If `https` is specified as the scheme, `connect_proxy()` makes a `CONNECT` request to establish a TCP tunnel to the remote host through the proxy server.
---@param host      string             # The hostname of the remote host to connect to.
---@param port      number             # The port of the remote host to connect to.
---@param proxy_authorization? string  # The `Proxy-Authorization` header value sent to the proxy server via `CONNECT` when the `scheme` is `https`.
---
---@return boolean ok
---@return string? error
function client:connect_proxy(proxy_uri, scheme, host, port, proxy_authorization) end


--- Calling this method manually is no longer necessary since it is incorporated within connect.
--- It is retained for now for compatibility with users of the older TCP only connect syntax.
---
--- See [OpenResty docs](https://github.com/openresty/lua-nginx-module#ngxsockettcp).
---
---@deprecated
---
---@param  session any
---@param  host    string
---@param  verify  boolean
---@return any?    session
---@return string? error
function client:ssl_handshake(session, host, verify) end


--- Performs a request using the current client request arguments, effectively proxying to the connected upstream.
--- The request body will be read in a streaming fashion, according to `request_body_chunk_size`.
---
---@deprecated
---
---@param  request_body_chunk_size number
---@return resty.http.response?    res
---@return string?                 error
function client:proxy_request(request_body_chunk_size) end


--- Sets the current response based on the given `res`.
--- Ensures that hop-by-hop headers are not sent downstream, and will read the response according to `chunksize`.
---
---@deprecated
---
---@param res        resty.http.response
---@param chunksize? number
function client:proxy_response(res, chunksize) end


return http
