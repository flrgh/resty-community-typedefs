---@meta

--- Socket compatibility module to enable the init-phase, by falling back to LuaSocket.
--- Forked from [lua-resty-socket](https://github.com/thibaultcha/lua-resty-socket).
--
--- ### Copyright
---
--- (c) 2016-2019 Thibault Charbonnier, 2021-2024 Thijs Schreijer
---
--- ### License
---
--- MIT, see `LICENSE.md`.
---
---@class resty.luasocket
---
---@field luasocket_mt resty.luasocket.proxy_mt
---@field _VERSION     string
local luasocket = {}

---@class resty.luasocket.proxy_mt
local proxy_mt

---@class resty.luasocket.tcp : ngx.socket.tcp

--- creates a tcp socket compatible with `ngx.socket.tcp`. The socket will fall back to
--- LuaSocket where cosockets are not supported.
---
---@return resty.luasocket.tcp
function luasocket.tcp() end

--- forces LuaSocket use for a specific phase.
--- An override for the automatic phase/socket-type detection. This setting is
--- a module global setting.
---
---```lua
--- local sock = require "resty.luasocket"
--- local old_setting = sock.force_luasocket("timer", true)
--- -- do something
--- sock.force_luasocket("timer", old_setting)
--- ```
---
---@param phase ngx.phase.name|string
---@param force? bool|nil
---@return bool previous # the previous setting for this phase
function luasocket.force_luasocket(phase, force) end

--- disables LuaSocket use for a specific phase.
--- An override for the automatic phase/socket-type detection. This setting is
--- a module global setting.
---
---```lua
--- local sock = require "resty.luasocket"
--- local old_setting = sock.disable_luasocket("init", true)
--- -- do something
--- sock.disable_luasocket("init", old_setting)
---```
---
---@param phase ngx.phase.name|string
---@param disable? bool|nil # set to `true` to disable, or `false/nil` to enable
---@return bool previous # the previous setting for this phase
function luasocket.disable_luasocket(phase, disable) end

---@class resty.luasocket.luasec_defaults : table
---
---@field protocol? string
---@field key?      any
---@field cert?     any
---@field cert?     any
---@field cafile?   string
---@field options?  string[]

--- Sets the luasec defaults for tls connections. See `get_luasec_defaults`.
--- The options will be (deep)copied, so safe to reuse the table. These settings
--- are module global setting.
---
---@param defaults resty.luasocket.luasec_defaults
function luasocket.set_luasec_defaults(defaults) end

--- Returns a copy of the defaults table. The "`_fields`"" meta field lists the
--- known fields. The options will be (deep)copied, so safe to reuse/modify the table.
---
---```lua
--- -- Setting the CAfile, to enable TLS verification.
--- local config = resty_luasocket.get_luasec_defaults()
--- config.cafile = "/path/to/my/cafile"
--- resty_luasocket.set_luasec_defaults(config)
---```
---@return resty.luasocket.luasec_defaults defaults
function luasocket.get_luasec_defaults() end

return luasocket
