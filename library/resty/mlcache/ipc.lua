---@meta

---@class resty.mlcache.ipc
---
---@field dict ngx.shared.DICT
---@field pid number
---@field idx integer
---@field callbacks table<string, resty.mlcache.ipc.callbacks>
local ipc = {}


---
-- Create a new IPC object.
---
---@param shm string
---@param debug? boolean
---@return resty.mlcache.ipc? ipc
---@return string? error
function ipc.new(shm, debug) end


---
-- Subscribe to a channel.
--
---@param channel string
---@param cb resty.mlcache.ipc.callback
function ipc:subscribe(channel, cb) end


---
-- IPC Event callback
--
---@alias resty.mlcache.ipc.callback fun(data:string)

---@alias resty.mlcache.ipc.callbacks resty.mlcache.ipc.callback[]


---
-- Broadcast a message
--
---@param channel string
---@param data string
---@return boolean? ok
---@return string? error
function ipc:broadcast(channel, data) end


---
-- Poll for new events/data.
--
---@param timeout? number
---@return boolean? ok
---@return string? error
function ipc:poll(timeout) end


return ipc
