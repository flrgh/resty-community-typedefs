---@meta

--- High performance match IP address for OpenResty Lua.
--- https://github.com/api7/lua-resty-ipmatcher/
---
---@class resty.ipmatcher
local ipmatcher = {}


do
  ---@class resty.ipmatcher.matcher : table
  local matcher = {}


  --- Returns a `true` if the IP exists within any of the specified IP list.
  --- Returns a `false` if the IP doesn't exist within any of the specified IP list.
  --- Returns `false` and an error message with an invalid IP address.
  ---
  --- ```lua
  --- local ok, err = ip:match("127.0.0.1")
  --- ```
  ---@param  ip      string
  ---@return boolean matched
  ---@return string? error
  function matcher:match(ip) end


  --- Returns a `true` if the binary format IP exists within any of the specified IP list.
  ---
  --- Returns `nil` and an error message with an invalid binary IP address.
  ---
  --- ```lua
  --- local ok, err = ip:match_bin(ngx.var.binary_remote_addr)
  --- ```
  ---
  ---@param  ip      string
  ---@return boolean matched
  ---@return string? error
  function matcher:match_bin(ip) end
end


--- Create a new IP matcher.
---
--- The `ips` is a array table, like `{ip1, ip2, ip3, ...}`,
--- each element in the array is a string IP address.
---
--- ```lua
--- local ip, err = ipmatcher.new({"127.0.0.1", "192.168.0.0/16"})
--- ```
---
--- Returns `nil` and error message if failed to create new `ipmatcher` instance.
---
--- It supports any CIDR format for IPv4 and IPv6.
---
--- ```lua
--- local ip, err = ipmatcher.new({
---         "127.0.0.1", "192.168.0.0/16",
---         "::1", "fe80::/16",
---     })
--- ```
---@param  ips                      string[]
---@return resty.ipmatcher.matcher? matcher
---@return string?                  error
function ipmatcher.new(ips) end


do
  ---@class resty.ipmatcher.matcher_with_values : table
  local matcher = {}

  --- When the IP matches, the value associated with the matched IP/CIDR is returned.
  ---
  --- ```lua
  --- local value, err = ip:match("127.0.0.1")
  --- ```
  ---@param  ip      string
  ---@return any     value
  ---@return string? error
  function matcher:match(ip) end

  --- When the IP matches, the value associated with the matched IP/CIDR is returned.
  ---
  --- ```lua
  --- local value, err = ip:match_bin(ngx.var.binary_remote_addr)
  --- ```
  ---@param  ip      string
  ---@return any     value
  ---@return string? error
  function matcher:match_bin(ip) end
end


--- Create  new IP matcher with values associated with each cidr.
---
--- The `ips` is a hash table, like `{[ip1] = val1, [ip2] = val2, ...}`,
--- each key in the hash is a string IP address.
---
--- When the `matcher` is created by `new_with_value`, calling `match` or `match_bin`
--- on it will return the corresponding value of matched CIDR range instead of `true`.
---
--- ```lua
--- local ip, err = ipmatcher.new_with_value({
---     ["127.0.0.1"] = {info = "a"},
---     ["192.168.0.0/16"] = {info = "b"},
--- })
--- local data, err = ip:match("192.168.0.1")
--- print(data.info) -- the value is "b"
--- ```
---
--- Returns `nil` and error message if failed to create new `ipmatcher` instance.
---
--- It supports any CIDR format for IPv4 and IPv6.
---
--- ```lua
--- local ip, err = ipmatcher.new_with_value({
---     ["127.0.0.1"] = {info = "a"},
---     ["192.168.0.0/16"] = {info = "b"},
---     ["::1"] = 1,
---     ["fe80::/32"] = "xx",
--- })
--- ```
---
--- If the ip address can be satified by multiple CIDR ranges, the returned value
--- is undefined (depended on the internal implementation). For instance,
---
--- ```lua
--- local ip, err = ipmatcher.new_with_value({
---     ["192.168.0.1"] = {info = "a"},
---     ["192.168.0.0/16"] = {info = "b"},
--- })
--- local data, err = ip:match("192.168.0.1")
--- print(data.info) -- the value can be "a" or "b"
--- ```
---
---@param  ips                                 table<string, any>
---@return resty.ipmatcher.matcher_with_values matcher
---@return string?                             error
function ipmatcher.new_with_value(ips) end


--- Tries to parse an IPv4 address to a host byte order FFI uint32_t type integer.
---
--- Returns a `false` if the ip is not a valid IPv4 address.
---@param  ip  string
---@return any result
function ipmatcher.parse_ipv4(ip) end


--- Tries to parse an IPv6 address to a table with four host byte order FFI uint32_t
--- type integer.  The given IPv6 address can be wrapped by square brackets
--- like `[::1]`.
---
--- Returns a `false` if the ip is not a valid IPv6 address.
---@param  ip          string
---@return any|boolean result
function ipmatcher.parse_ipv6(ip) end


return ipmatcher
