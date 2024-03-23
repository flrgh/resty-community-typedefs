---@meta

--- lua-resty-jwt
---
--- See:
---   * https://github.com/SkyLothar/lua-resty-jwt
---   * https://github.com/api7/lua-resty-jwt
---
---@class resty.jwt
---
---@field _VERSION string
local _M = {}

---@param original string
---@param is_payload? boolean
---@return string
function _M:jwt_encode(original, is_payload) end


---@param  b64_str      string
---@param  json_decode? boolean
---@param  is_payload?  boolean
---@return any?         decoded
function _M:jwt_decode(b64_str, json_decode, is_payload) end

--- Initialize the trusted certs
-- During RS256 verify, we'll make sure the cert was signed by one of these
---@param filename string
function _M.set_trusted_certs_file(filename) end


--- Set a whitelist of allowed algorithms
-- E.g., jwt:set_alg_whitelist({RS256=1,HS256=1})
--
---@param algorithms table<string, any>
function _M:set_alg_whitelist(algorithms) end

--- Returns the list of default validations that will be applied upon the verification of a jwt.
---@return table
function _M:get_default_validation_options(jwt_obj) end


--- Set a function used to retrieve the content of x5u urls
--
-- A pointer to a function. This function should be defined to accept three string parameters. First one will be the value of the 'x5u' attribute. Second one will be the value of the 'iss' attribute, would it be defined in the jwt. Third one will be the value of the 'kid' attribute, would it be defined in the jwt. This function should return the matching certificate.
---@param retriever_function fun(x5u:string, iss:string, kid:string):string
---
function _M:set_x5u_content_retriever(retriever_function) end

--- create a jwt/jwe signature from jwt_object
---@param secret_key string
---@param jwt_obj resty.jwt.object
---@return string
function _M:sign(secret_key, jwt_obj) end


---@class resty.jwt.object : table
---
---@field valid boolean
---
---@field verified boolean
---
---@field reason string
---
---@field raw_header string
---
---@field raw_payload string
---
---@field header any
---
---@field payload any
---
---@field signature string


---@param jwt_str string token
---@param secret string
---@return resty.jwt.object
function _M:load_jwt(jwt_str, secret) end


---@param secret string|function
---@param jwt_obj resty.jwt.object
---@return resty.jwt.object jwt payload or jwt object with error code
function _M:verify_jwt_obj(secret, jwt_obj, ...) end


---@param secret string|function
---@param jwt_str string
---@param ... any
---@return resty.jwt.object
function _M:verify(secret, jwt_str, ...) end


---@param encoder function
function _M:set_payload_encoder(encoder) end


---@param decoder function
function _M:set_payload_decoder(decoder) end


---@return resty.jwt
function _M.new() end


return _M
