---@meta


--- lua-resty-jit-uuid https://github.com/thibaultcha/lua-resty-jit-uuid
---
---@class resty.jit-uuid
---
---@field _VERSION string
---
local uuid = {}


--- Seed the random number generator.
---
--- Under the hood, this function calls `math.randomseed`.
--- It makes sure to use the most appropriate seeding technique for
--- the current environment, guaranteeing a unique seed.
---
--- To guarantee unique UUIDs, you must have correctly seeded
--- the Lua pseudo-random generator (with `math.randomseed`).
--- You are free to seed it any way you want, but this function
--- can do it for you if you'd like, with some added guarantees.
---
---```lua
--- local uuid = require 'resty.jit-uuid'
--- uuid.seed()
---```
---
---```nginx
--- # in ngx_lua, seed in the init_worker context:
--- init_worker_by_lua {
---   local uuid = require 'resty.jit-uuid'
---   uuid.seed()
--- }
---```
---
---@param seed? number # A seed to use. If none given, will generate one trying to use the most appropriate technique.
---@return number seed # the seed given to `math.randomseed`
function uuid.seed(seed) end

--- Validate a string as a UUID.
---
--- To be considered valid, a UUID must be given in its canonical
--- form (hexadecimal digits including the hyphen characters).
--- This function validates UUIDs disregarding their generation algorithm,
--- and in a case-insensitive manner, but checks the variant field.
---
--- Use JIT PCRE if available in OpenResty or fallbacks on Lua patterns.
---
---```lua
--- local uuid = require 'resty.jit-uuid'
---
--- uuid.is_valid 'cbb297c0-a956-486d-ad1d-f9bZZZZZZZZZ' --> false
--- uuid.is_valid 'cbb297c0-a956-486d-dd1d-f9b42df9465a' --> false (invalid variant)
--- uuid.is_valid 'cbb297c0a956486dad1df9b42df9465a'     --> false (no dashes)
--- uuid.is_valid 'cbb297c0-a956-486d-ad1d-f9b42df9465a' --> true
---```
---
---@param str string # String to verify
---@return boolean valid
function uuid.is_valid(str) end


--- Generate a v4 UUID.
---
--- v4 UUIDs are created from randomly generated numbers.
--
---```lua
--- local uuid = require 'resty.jit-uuid'
---
--- local u1 = uuid()             ---> __call metamethod
--- local u2 = uuid.generate_v4()
---```
---
---@return string uuid
function uuid.generate_v4() end


---@alias resty.jit-uuid.factory.v5 fun(string):string


--- Instantiate a v5 UUID factory.
---
--- Creates a closure generating namespaced v5 UUIDs.
---
---```lua
--- local uuid = require 'resty.jit-uuid'
---
--- local fact = assert(uuid.factory_v5('e6ebd542-06ae-11e6-8e82-bba81706b27d'))
---
--- local u1 = fact('hello')
--- ---> 4850816f-1658-5890-8bfd-1ed14251f1f0
---
--- local u2 = fact('foobar')
--- ---> c9be99fc-326b-5066-bdba-dcd31a6d01ab
---```
---
---@param namespace string # (must be a valid UUID according to `is_valid`)
---
---@return resty.jit-uuid.factory.v5? factory
---@return string?                    error
function uuid.factory_v5(namespace) end


--- Generate a v5 UUID.
---
--- v5 UUIDs are created from a namespace and a name (a UUID and a string).
--- The same name and namespace result in the same UUID. The same name and
--- different namespaces result in different UUIDs, and vice-versa.
--- The resulting UUID is derived using SHA-1 hashing.
---
--- This is a sugar function which instanciates a short-lived v5 UUID factory.
--- It is an expensive operation, and intensive generation using the same
--- namespaces should prefer allocating their own long-lived factory with
--- `factory_v5`.
---
---```lua
--- local uuid = require 'resty.jit-uuid'
---
--- local u = uuid.generate_v5('e6ebd542-06ae-11e6-8e82-bba81706b27d', 'hello')
--- ---> 4850816f-1658-5890-8bfd-1ed14251f1f0
---```
---
---@param namespace string # (must be a valid UUID according to `is_valid`)
---@param name      string
---
---@return string?  uuid
---@return string? error
function uuid.generate_v5(namespace, name) end


---@alias resty.jit-uuid.factory.v3 fun(string):string


--- Instantiate a v3 UUID factory.
---
--- Creates a closure generating namespaced v3 UUIDs.
---
---```lua
--- local uuid = require 'resty.jit-uuid'
---
--- local fact = assert(uuid.factory_v3('e6ebd542-06ae-11e6-8e82-bba81706b27d'))
---
--- local u1 = fact('hello')
--- ---> 3db7a435-8c56-359d-a563-1b69e6802c78
---
--- local u2 = fact('foobar')
--- ---> e8d3eeba-7723-3b72-bbc5-8f598afa6773
---```
---
---@param namespace string # (must be a valid UUID according to `is_valid`)
---
---@return resty.jit-uuid.factory.v3? factory
---@return string?                    error
function uuid.factory_v3(namespace) end


--- Generate a v3 UUID.
---
--- v3 UUIDs are created from a namespace and a name (a UUID and a string).
--- The same name and namespace result in the same UUID. The same name and
--- different namespaces result in different UUIDs, and vice-versa.
--- The resulting UUID is derived using MD5 hashing.
---
--- This is a sugar function which instanciates a short-lived v3 UUID factory.
--- It is an expensive operation, and intensive generation using the same
--- namespaces should prefer allocating their own long-lived factory with
--- `factory_v3`.
---
---```lua
--- local uuid = require 'resty.jit-uuid'
---
--- local u = uuid.generate_v3('e6ebd542-06ae-11e6-8e82-bba81706b27d', 'hello')
--- ---> 3db7a435-8c56-359d-a563-1b69e6802c78
---```
---
---@param namespace string # (must be a valid UUID according to `is_valid`)
---@param name      string
---
---@return string?  uuid
---@return string? error
function uuid.generate_v3(namespace, name) end


return uuid
