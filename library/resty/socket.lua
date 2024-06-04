---@meta

--- # lua-resty-socket
---
--- https://github.com/thibaultcha/lua-resty-socket
---
--- cosocket/LuaSocket automatic compatibility module for lua-resty modules wanting
--- to be compatible with plain Lua or OpenResty's `init` context.
---
--- The use case for this library is: you are developing a lua-resty module relying
--- on cosockets, but you want it to also be usable in OpenResty's `init` context
--- or even in plain Lua. This module aims at always providing your library with
--- sockets that will be compatible in the current context, saving you time and
--- effort, and extending LuaSocket's API to match that of cosockets, allowing you
--- to always write your code as if you were in a cosocket-compatible OpenResty
--- context.
---
--- ### Features
---
--- * Allows your lua-resty modules to automatically use cosockets/LuaSocket
--- * Provides `sslhandshake` proxy when using LuaSocket, with a dependency on
---   LuaSec
--- * Does not get blocked to using LuaSocket in further contexts if loaded in the
---   ngx_lua `init` (easy mistake to make)
--- * Memoizes underlying socket methods for performance
--- * Outputs a warning log for your users when spawning a socket using LuaSocket
---   while in OpenResty
---
--- ### Motivation
---
--- The aim of this module is to provide an automatic fallback to LuaSocket when
--- [ngx_lua]'s cosockets are not available. That is:
--- - When not used in ngx_lua
--- - In ngx_lua contexts where cosockets are not supported (`init`, `init_worker`,
--- etc...)
---
--- When falling back to LuaSocket, it provides you with shims for cosocket-only
--- functions such as `getreusedtimes`, `setkeepalive` etc...
---
--- It comes handy when one is developing a module/library that aims at being
--- either compatible with both ngx_lua **and** plain Lua, **or** in ngx_lua
--- contexts such as `init`.
---
--- ### Important note
---
--- The use of LuaSocket inside ngx_lua is **very strongly** discouraged due to its
--- blocking nature. However, it is fine to use it in the `init` context where
--- blocking is not considered harmful.
---
--- In the future, only the `init` phase will allow falling back to LuaSocket.
---
--- It currently only support TCP sockets.
---
--- ## Usage
---
--- All of the available functions follow the same prototype as the cosocket API,
--- allowing this example to run in any ngx_lua context or outside ngx_lua
--- altogether:
--- ```lua
--- local socket = require 'resty.socket'
--- local sock = socket.tcp()
---
--- getmetatable(sock) == socket.luasocket_mt ---> true/false depending on underlying socket
---
--- sock:settimeout(1000) ---> 1000ms translated to 1s if LuaSocket
---
--- sock:getreusedtimes(...) ---> 0 if LuaSocket
---
--- sock:setkeepalive(...) ---> calls close() if LuaSocket
---
--- sock:sslhandshake(...) ---> LuaSec dependency if LuaSocket
--- ```
---
--- As such, one can write a module relying on TCP sockets such as:
--- ```lua
--- local socket = require 'resty.socket'
---
--- local _M = {}
---
--- function _M.new()
---   local sock = socket.tcp() -- similar to ngx.socket.tcp()
---
---   return setmetatable({
---     sock = sock
---   }, {__index = _M})
--- end
---
--- function _M:connect(host, port)
---   local ok, err = self.sock:connect(host, port)
---   if not ok then
---     return nil, err
---   end
---
---   local times, err = self.sock:getreusedtimes() -- cosocket API
---   if not times then
---     return nil, err
---   elseif times == 0 then
---     -- handle connection
---   end
--- end
---
--- return _M
--- ```
---
--- The user of such a module could use it in contexts with cosocket support, or
--- in the `init` phase of ngx_lua, with little effort from the developer.
---
--- ### Requirements
---
--- **As long as sockets are created in contexts with support for cosockets, this
--- module will never require LuaSocket nor LuaSec.**
---
--- - LuaSocket (only if sockets are created where cosockets don't exist)
--- - LuaSec (only if the fallbacked socket attempts to perform an SSL handshake)
---
---@class resty.socket : table
---
---@field luasocket_mt table
---@field _VERSION     string
local socket = {}


---@return ngx.socket.tcp socket
function socket.tcp() end


---@param phase string
---@param force boolean
function socket.force_luasocket(phase, force) end


---@param phase   string
---@param disable boolean
function socket.disable_luasocket(phase, disable) end


return socket
