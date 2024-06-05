---@meta

--- # lua-resty-ada
---
--- https://github.com/bungle/lua-resty-ada
---
--- **lua-resty-ada** implements a LuaJIT FFI bindings to Ada — WHATWG-compliant and fast URL parser.
---
--- ## Status
---
--- This library is considered production ready.
---
--- ## Synopsis
---
--- ```lua
--- local ada = require("resty.ada")
---
--- local url = assert(ada.parse("https://www.7‑Eleven.com:1234/Home/../Privacy/Montréal"))
---
--- print(tostring(url))
--- -- prints: https://www.xn--7eleven-506c.com:1234/Privacy/Montr%C3%A9al
---
--- print(tostring(url:clear_port())) -- there are many more methods
--- -- prints: https://www.xn--7eleven-506c.com/Privacy/Montr%C3%A9al
---
--- -- There is also a static API
---
--- print(ada.get_href("https://www.7‑Eleven.com:1234/Home/../Privacy/Montréal"))
--- -- prints: https://www.xn--7eleven-506c.com:1234/Privacy/Montr%C3%A9al
---
--- print(ada.clear_port("https://www.7‑Eleven.com:1234/Home/../Privacy/Montréal"))
--- -- prints: https://www.xn--7eleven-506c.com/Privacy/Montr%C3%A9al
--- ```
---
---@class resty.ada
---
---@field _VERSION string
---
---@field search resty.ada.search
local ada = {}

---@class resty.ada.url.components : resty.ada.lib.ada_url_components
---
---@field protocol_end   integer|nil
---@field username_end   integer|nil
---@field host_start     integer|nil
---@field host_end       integer|nil
---@field port           integer|nil
---@field pathname_start integer|nil
---@field search_start   integer|nil
---@field hash_start     integer|nil

---@param url string
---@return resty.ada.url? parsed
---@return string?        error
function ada.parse(url) end

---@param url  string
---@param base string
---@return resty.ada.url? parsed
---@return string?        error
function ada.parse_with_base(url, base) end

---@param url string
---@return boolean
function ada.is_valid(url) end

---@param url any
---@return boolean
function ada.can_parse(url) end

---@param url any
---@param base any
---@return boolean
function ada.can_parse_with_base(url, base) end

---@param url string
---@param base string
---@return resty.ada.url.components
function ada.get_components_with_base(url, base) end

---@param url string
---@return resty.ada.url.components
function ada.get_components(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_credentials_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_credentials(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_empty_hostname_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_empty_hostname(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_hostname_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_hostname(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_non_empty_username_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_non_empty_username(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_non_empty_password_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_non_empty_password(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_port_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_port(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_password_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_password(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_hash_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_hash(url) end

---@param url string
---@param base string
---@return boolean
function ada.has_search_with_base(url, base) end

---@param url string
---@return boolean
function ada.has_search(url) end

---@param  url    string
---@param  base   string
---@return string origin
function ada.get_origin_with_base(url, base) end

---@param  url    string
---@return string origin
function ada.get_origin(url) end

---@param  url    string
---@param  base   string
---@return string href
function ada.get_href_with_base(url, base) end

---@param  url    string
---@return string href
function ada.get_href(url) end

---@param  url    string
---@param  base   string
---@return string username
function ada.get_username_with_base(url, base) end

---@param  url    string
---@return string username
function ada.get_username(url) end

---@param  url    string
---@param  base   string
---@return string password
function ada.get_password_with_base(url, base) end

---@param  url    string
---@return string password
function ada.get_password(url) end

---@param  url    string
---@param  base   string
---@return string|integer port
function ada.get_port_with_base(url, base) end

---@param  url    string
---@return string|integer port
function ada.get_port(url) end

---@param  url    string
---@param  base   string
---@return string  hash
function ada.get_hash_with_base(url, base) end

---@param  url    string
---@return string  hash
function ada.get_hash(url) end

---@param  url    string
---@param  base   string
---@return string host
function ada.get_host_with_base(url, base) end

---@param  url    string
---@return string host
function ada.get_host(url) end

---@param  url    string
---@param  base   string
---@return string hostname
function ada.get_hostname_with_base(url, base) end

---@param  url    string
---@return string hostname
function ada.get_hostname(url) end

---@param  url    string
---@param  base   string
---@return string pathname
function ada.get_pathname_with_base(url, base) end

---@param  url    string
---@return string pathname
function ada.get_pathname(url) end

---@param  url    string
---@param  base   string
---@return string|nil search
function ada.get_search_with_base(url, base) end

---@param  url    string
---@return string|nil search
function ada.get_search(url) end

---@param  url    string
---@param  base   string
---@return string protocol
function ada.get_protocol_with_base(url, base) end

---@param  url    string
---@return string protocol
function ada.get_protocol(url) end

---@param  url    string
---@param  base   string
---@return any    host_type
function ada.get_host_type_with_base(url, base) end

---@param  url    string
---@return any    host_type
function ada.get_host_type(url) end

---@param  url    string
---@param  base   string
---@return any    scheme_type
function ada.get_scheme_type_with_base(url, base) end

---@param  url    string
---@return any    scheme_type
function ada.get_scheme_type(url) end

---@param  url     string
---@param  base    string
---@param  href    string
---@return string? new
---@return string? error
function ada.set_href_with_base(url, base, href) end

---@param  url     string
---@param  href    string
---@return string? new
---@return string? error
function ada.set_href(url, href) end

---@param  url     string
---@param  base    string
---@param  host    string
---@return string? new
---@return string? error
function ada.set_host_with_base(url, base, host) end

---@param  url     string
---@param  host    string
---@return string? new
---@return string? error
function ada.set_host(url, host) end

---@param  url      string
---@param  base     string
---@param  hostname string
---@return string?  new
---@return string?  error
function ada.set_hostname_with_base(url, base, hostname) end

---@param  url      string
---@param  hostname string
---@return string?  new
---@return string?  error
function ada.set_hostname(url, hostname) end

---@param  url      string
---@param  base     string
---@param  protocol string
---@return string?  new
---@return string?  error
function ada.set_protocol_with_base(url, base, protocol) end

---@param  url      string
---@param  protocol string
---@return string?  new
---@return string?  error
function ada.set_protocol(url, protocol) end

---@param  url      string
---@param  base     string
---@param  username string
---@return string?  new
---@return string?  error
function ada.set_username_with_base(url, base, username) end

---@param  url      string
---@param  username string
---@return string?  new
---@return string?  error
function ada.set_username(url, username) end

---@param  url      string
---@param  base     string
---@param  password string
---@return string?  new
---@return string?  error
function ada.set_password_with_base(url, base, password) end

---@param  url      string
---@param  password string
---@return string?  new
---@return string?  error
function ada.set_password(url, password) end

---@param  url     string
---@param  base    string
---@param  port    string|integer
---@return string? new
---@return string? error
function ada.set_port_with_base(url, base, port) end

---@param  url     string
---@param  port    string|integer
---@return string? new
---@return string? error
function ada.set_port(url, port) end

---@param  url      string
---@param  base     string
---@param  pathname string
---@return string?  new
---@return string?  error
function ada.set_pathname_with_base(url, base, pathname) end

---@param  url      string
---@param  pathname string
---@return string?  new
---@return string?  error
function ada.set_pathname(url, pathname) end

---@param  url     string
---@param  base    string
---@param  query   string
---@return string  new
function ada.set_search_with_base(url, base, query) end

---@param  url     string
---@param  query   string
---@return string  new
function ada.set_search(url, query) end

---@param  url     string
---@param  base    string
---@param  hash    string
---@return string  new
function ada.set_hash_with_base(url, base, hash) end

---@param  url     string
---@param  hash    string
---@return string  new
function ada.set_hash(url, hash) end

---@param  url     string
---@param  base    string
---@return string  new
function ada.clear_port_with_base(url, base) end

---@param  url     string
---@return string  new
function ada.clear_port(url) end

---@param  url     string
---@param  base    string
---@return string  new
function ada.clear_search_with_base(url, base) end

---@param  url     string
---@return string  new
function ada.clear_search(url) end

---@param  url     string
---@param  base    string
---@return string  new
function ada.clear_hash_with_base(url, base) end

---@param  url     string
---@return string  new
function ada.clear_hash(url) end

---@param  url string
---@return string
function ada.idna_to_unicode(url) end

---@param  url string
---@return string
function ada.idna_to_ascii(url) end

---@param url string
---@param base string
---@return string? new
---@return string? error
function ada.search_sort_with_base(url, base) end

---@param url string
---@return string? new
---@return string? error
function ada.search_sort(url) end

---@param  url     string
---@param  base    string
---@param  key     string
---@param  value   string
---@return string? new
---@return string? error
function ada.search_append_with_base(url, base, key, value) end

---@param  url     string
---@param  key     string
---@param  value   string
---@return string? new
---@return string? error
function ada.search_append(url, key, value) end

---@param  url     string
---@param  base    string
---@param  key     string
---@param  value   string
---@return string? new
---@return string? error
function ada.search_set_with_base(url, base, key, value) end

---@param  url     string
---@param  key     string
---@param  value   string
---@return string? new
---@return string? error
function ada.search_set(url, key, value) end

---@param  url     string
---@param  base    string
---@param  key     string
---@return string? new
---@return string? error
function ada.search_remove_with_base(url, base, key) end

---@param  url     string
---@param  key     string
---@return string? new
---@return string? error
function ada.search_remove(url, key) end

---@param  url     string
---@param  base    string
---@param  key     string
---@param  value   string
---@return string? new
---@return string? error
function ada.search_remove_value_with_base(url, base, key, value) end

---@param  url     string
---@param  key     string
---@param  value   string
---@return string? new
---@return string? error
function ada.search_remove_value(url, key, value) end

---@param  url     string
---@param  base    string
---@param  key     string
---@return boolean
function ada.search_has_with_base(url, base, key) end

---@param  url     string
---@param  key     string
---@return boolean
function ada.search_has(url, key) end

---@param  url     string
---@param  base    string
---@param  key     string
---@param  value   string
---@return boolean
function ada.search_has_value_with_base(url, base, key, value) end

---@param  url     string
---@param  key     string
---@param  value   string
---@return boolean
function ada.search_has_value(url, key, value) end

---@param  url     string
---@param  base    string
---@param  key     string
---@return string? search
function ada.search_get_with_base(url, base, key) end

---@param  url     string
---@param  key     string
---@return string? search
function ada.search_get(url, key) end

---@param  url     string
---@param  base    string
---@param  key     string
---@return string[] values
function ada.search_get_all_with_base(url, base, key) end

---@param  url     string
---@param  key     string
---@return string[] values
function ada.search_get_all(url, key) end

---@param  url     string
---@param  base    string
---@return integer size
function ada.search_size_with_base(url, base) end

---@param  url     string
---@return integer size
function ada.search_size(url) end

---@param url string
---@param base string
---@return resty.ada.search.iter.pairs
---@return resty.ada.search.iter.state
function ada.search_pairs_with_base(url, base) end

---@param url string
---@return resty.ada.search.iter.pairs
---@return resty.ada.search.iter.state
function ada.search_pairs(url) end

---@param url string
---@param base string
---@return resty.ada.search.iter.ipairs
---@return resty.ada.search.iter.state
---@return integer index
function ada.search_ipairs_with_base(url, base) end

---@param url string
---@return resty.ada.search.iter.ipairs
---@return resty.ada.search.iter.state
---@return integer index
function ada.search_ipairs(url) end

---@param url string
---@param base string
---@return resty.ada.search.iter.each
---@return resty.ada.search.iter.state
function ada.search_each_with_base(url, base) end

---@param url string
---@return resty.ada.search.iter.each
---@return resty.ada.search.iter.state
function ada.search_each(url) end

---@param url string
---@param base string
---@return resty.ada.search.iter.keys
---@return resty.ada.search.iter.state
function ada.search_each_key_with_base(url, base) end

---@param url string
---@return resty.ada.search.iter.keys
---@return resty.ada.search.iter.state
function ada.search_each_key(url) end

---@param url string
---@param base string
---@return resty.ada.search.iter.values
---@return resty.ada.search.iter.state
function ada.search_each_value_with_base(url, base) end

---@param url string
---@return resty.ada.search.iter.values
---@return resty.ada.search.iter.state
function ada.search_each_value(url) end

---@class resty.ada.url
---
---@field _VERSION string
local url = {}

url.__index = url

---@return boolean
function url:is_valid() end

---@return resty.ada.url.components
function url:get_components() end

---@return boolean
function url:has_credentials() end

---@return boolean
function url:has_empty_hostname() end

---@return boolean
function url:has_hostname() end

---@return boolean
function url:has_non_empty_username() end

---@return boolean
function url:has_non_empty_password() end

---@return boolean
function url:has_port() end

---@return boolean
function url:has_password() end

---@return boolean
function url:has_hash() end

---@return boolean
function url:has_search() end

---@return string origin
function url:get_origin() end

---@return string href
function url:get_href() end

---@return string username
function url:get_username() end

---@return string password
function url:get_password() end

---@return string|integer port
function url:get_port() end

---@return string  hash
function url:get_hash() end

---@return string host
function url:get_host() end

---@return string hostname
function url:get_hostname() end

---@return string pathname
function url:get_pathname() end

---@return string|nil search
function url:get_search() end

---@return string protocol
function url:get_protocol() end

---@return any    host_type
function url:get_host_type() end

---@return any    scheme_type
function url:get_scheme_type() end

---@param  href           string
---@return resty.ada.url? self
---@return string?        error
function url:set_href(href) end

---@param  host           string
---@return resty.ada.url? self
---@return string?        error
function url:set_host(host) end

---@param  hostname       string
---@return resty.ada.url? self
---@return string?        error
function url:set_hostname(hostname) end

---@param  protocol       string
---@return resty.ada.url? self
---@return string?        error
function url:set_protocol(protocol) end

---@param  username       string
---@return resty.ada.url? self
---@return string?        error
function url:set_username(username) end

---@param  password       string
---@return resty.ada.url? self
---@return string?        error
function url:set_password(password) end

---@param  port           string|integer
---@return resty.ada.url? self
---@return string?        error
function url:set_port(port) end

---@param  pathname string
---@return resty.ada.url? self
---@return string?  error
function url:set_pathname(pathname) end

---@param  query          string
---@return resty.ada.url  self
function url:set_search(query) end

---@param  hash           string
---@return resty.ada.url  self
function url:set_hash(hash) end

---@return resty.ada.url self
function url:clear_port() end

---@return resty.ada.url self
function url:clear_search() end

---@return resty.ada.url self
function url:clear_hash() end

---@return string
function url:to_unicode() end

---@return string
function url:to_ascii() end

---@return string
function url:tostring() end

---@return string
function url:__tostring() end

---@return integer
function url:__len() end

---@return resty.ada.url self
function url:search_sort() end

---@param  key           string
---@param  value         string
---@return resty.ada.url self
function url:search_append(key, value) end

---@param  key           string
---@param  value         string
---@return resty.ada.url self
function url:search_set(key, value) end

---@param  key           string
---@return resty.ada.url self
function url:search_remove(key) end

---@param  key           string
---@param  value         string
---@return resty.ada.url self
function url:search_remove_value(key, value) end

---@param  key     string
---@return boolean
function url:search_has(key) end

---@param  key     string
---@param  value   string
---@return boolean
function url:search_has_value(key, value) end

---@param  key     string
---@return string? search
function url:search_get(key) end

---@return resty.ada.search.iter.keys
---@return resty.ada.search.iter.state
function url:search_each_key() end

---@return resty.ada.search.iter.values
---@return resty.ada.search.iter.state
function url:search_each_value() end

---@return resty.ada.search.iter.each
---@return resty.ada.search.iter.state
function url:search_each() end

---@return resty.ada.search.iter.ipairs
---@return resty.ada.search.iter.state
---@return integer index
function url:search_ipairs() end

---@return resty.ada.search.iter.pairs
---@return resty.ada.search.iter.state
function url:search_pairs() end

---@return integer size
function url:search_size() end

---@param  key      string
---@return string[] values
function url:search_get_all(key) end

return ada
