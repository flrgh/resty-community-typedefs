---@meta

---@class resty.ada.utils
local utils = {}

---@return string|nil
function utils.ada_string_to_lua(result) end

---@param result any
---@return string[]
function utils.ada_strings_to_lua(result) end

---@param ada_owned_string resty.ada.lib.ada_owned_string
---@return string
function utils.ada_owned_string_to_lua(ada_owned_string) end

---@param port string|integer
---@return string
function utils.port_to_string(port) end

return utils
