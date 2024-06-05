---@meta

---@class resty.ada.search
local search = {}

---@alias resty.ada.search.iter.state resty.ada.lib.ada_url_search_params_entries_iter

---@alias resty.ada.search.iter.pairs fun(state: resty.ada.search.iter.state):string|nil,string|nil

---@alias resty.ada.search.iter.ipairs fun(state: resty.ada.search.iter.state):integer|nil,resty.ada.search.entry|nil

---@alias resty.ada.search.iter.each fun(state: resty.ada.search.iter.state):resty.ada.search.entry|nil

---@alias resty.ada.search.iter.keys fun(state: resty.ada.search.iter.state):string|nil

---@alias resty.ada.search.iter.values fun(state: resty.ada.search.iter.state):string|nil

---@class resty.ada.search.entry
---@field key   string
---@field value string

---@class resty.ada.search.params
local params = {}
params.__index = params

---@return resty.ada.search.params
function params:sort() end

---@param key string
---@param value string
---@return resty.ada.search.params self
function params:append(key, value) end

---@param key string
---@param value string
---@return resty.ada.search.params self
function params:set(key, value) end

---@param key string
---@return resty.ada.search.params self
function params:remove(key) end

---@param  key        string
---@return string|nil value
function params:get(key) end

---@param key string
---@param value string
---@return resty.ada.search.params self
function params:remove_value(key, value) end

---@param key string
---@return boolean
function params:has(key) end

---@param key string
---@param value string
---@return boolean
function params:has_value(key, value) end

---@param  key        string
---@return string[]
function params:get_all(key) end

---@return integer size
function params:size() end

---@return resty.ada.search.iter.pairs
---@return resty.ada.search.iter.state
function params:__pairs() end

---@return resty.ada.search.iter.ipairs
---@return resty.ada.search.iter.state
---@return integer index
function params:__ipairs() end

---@return resty.ada.search.iter.each
---@return resty.ada.search.iter.state
function params:each() end

---@return resty.ada.search.iter.keys
---@return resty.ada.search.iter.state
function params:each_key() end

---@return resty.ada.search.iter.values
---@return resty.ada.search.iter.state
function params:each_value() end

---@return string
function params:tostring() end

---@return string
function params:__tostring() end

---@return integer
function params:__len() end


---@param search string
---@return resty.ada.search.params
function search.parse(search) end

---@param search string
---@return string new
function search.sort(search) end

---@param search string
---@param key string
---@param value string
---@return string new
function search.append(search, key, value) end

---@param search string
---@param key string
---@param value string
---@return string new
function search.set(search, key, value) end

---@param search string
---@param key string
---@return string new
function search.remove(search, key) end

---@param search string
---@param key string
---@param value string
---@return string new
function search.remove_value(search, key, value) end

---@param search string
---@param key string
---@return boolean
function search.has(search, key) end

---@param search string
---@param key string
---@param value string
---@return boolean
function search.has_value(search, key, value) end

---@param  search     string
---@param  key        string
---@return string|nil value
function search.get(search, key) end

---@param  search     string
---@param  key        string
---@return string[]
function search.get_all(search, key) end

---@param  search     string
---@return integer size
function search.size(search) end

---@param search string
---@return resty.ada.search.iter.pairs
---@return resty.ada.search.iter.state
function search.pairs(search) end

---@param search string
---@return resty.ada.search.iter.ipairs
---@return resty.ada.search.iter.state
---@return integer index
function search.ipairs(search) end

---@param search string
---@return resty.ada.search.iter.each
---@return resty.ada.search.iter.state
function search.each(search) end

---@param search string
---@return resty.ada.search.iter.keys
---@return resty.ada.search.iter.state
function search.each_key(search) end

---@param search string
---@return resty.ada.search.iter.values
---@return resty.ada.search.iter.state
function search.each_value(search) end

return search
