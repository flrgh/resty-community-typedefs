---@meta

--- This file defines "validators" to be used in validating a spec.  A "validator" is simply a function with
--- a signature that matches:
---
---   function(val, claim, jwt_json)
---
--- This function returns either true or false.  If a validator needs to give more information on why it failed,
--- then it can also raise an error (which will be used in the "reason" part of the validated jwt_obj).  If a
--- validator returns nil, then it is assumed to have passed (same as returning true) and that you just forgot
--- to actually return a value.
---
--- There is a special claim name of "__jwt" that can be used to validate the entire jwt_obj.
---
--- "val" is the value being tested.  It may be nil if the claim doesn't exist in the jwt_obj.  If the function
--- is being called for the "__jwt" claim, then "val" will contain a deep clone of the full jwt object.
---
--- "claim" is the claim that is being tested.  It is passed in just in case a validator needs to do additional
--- checks.  It will be the string "__jwt" if the validator is being called for the entire jwt_object.
---
--- "jwt_json" is a json-encoded representation of the full object that is being tested.  It will never be nil,
--- and can always be decoded using cjson.decode(jwt_json).
---
---@class resty.jwt-validators
---
---@field _VERSION string
local validators = {}


--- A "validator" is simply a function with a signature that matches:
---
---   function(val, claim, jwt_json)
---
--- This function returns either true or false.  If a validator needs to give more information on why it failed,
--- then it can also raise an error (which will be used in the "reason" part of the validated jwt_obj).  If a
--- validator returns nil, then it is assumed to have passed (same as returning true) and that you just forgot
--- to actually return a value.
---
--- There is a special claim name of "__jwt" that can be used to validate the entire jwt_obj.
---
--- "val" is the value being tested.  It may be nil if the claim doesn't exist in the jwt_obj.  If the function
--- is being called for the "__jwt" claim, then "val" will contain a deep clone of the full jwt object.
---
--- "claim" is the claim that is being tested.  It is passed in just in case a validator needs to do additional
--- checks.  It will be the string "__jwt" if the validator is being called for the entire jwt_object.
---
--- "jwt_json" is a json-encoded representation of the full object that is being tested.  It will never be nil,
--- and can always be decoded using cjson.decode(jwt_json).
---@alias resty.jwt.validator fun(val:any, claim:string, jwt_json:table):boolean



--- Returns a validator that chains the given functions together, one after another - as long as they keep passing their checks.
---@param ... resty.jwt.validator
---@return resty.jwt.validator
function validators.chain(...) end


--- Returns a validator that returns `false` if a value doesn't exist.
--- If the value exists and a `chain_function` is specified, then the value of `chain_function(val, claim, jwt_json)` will be returned, otherwise, `true` will be returned.
--- This allows for specifying that a value is both required *and* it must match some additional check.
---
---@param chain_function? resty.jwt.validator
---@return resty.jwt.validator
function validators.required(chain_function) end



--- Returns a validator which errors with a message if *NONE* of the given claim keys exist.
--- It is expected that this function is used against a full jwt object.
---@param claim_keys string[] # a non-empty table of strings
---@return resty.jwt.validator
function validators.require_one_of(claim_keys) end


--- Returns a validator that checks if the result of calling the given `check_function` for the tested value and `check_val` returns true.
---
--- The optional `check_type` is used to make sure that the check type matches and defaults to `type(check_val)`.
--- The first parameter passed to check_function will *never* be nil.
--- If the `check_function` raises an error, that will be appended to the error message.
---
---@param check_val      any      # required, cannot be `nil`
---@param check_function function # required
---@param name?          string   # optional, used for error messages
---@param check_type?    string
---
---@return resty.jwt.validator
function validators.check(check_val, check_function, name, check_type) end
validators.opt_check = validators.check


--- Returns a validator that checks if a value exactly equals (using `==`) the given check_value.
---@param check_val any # cannot be nil
---@return resty.jwt.validator
function validators.equals(check_val) end
validators.opt_equals = validators.equals


--- Returns a validator that checks if a value matches the given pattern (using `string.match`).
---@param pattern string
---@return resty.jwt.validator
function validators.matches(pattern) end
validators.opt_matches = validators.matches


--- Returns a validator which calls the given `check_function` for each of the given `check_values` and the tested value.
--- If any of these calls return `true`, then this function returns `true`.
---
--- The optional `check_type` is used to make sure that the check type matches and defaults to `type(check_values[1])` - the table type.
---
---@param check_values   any[]    # non-empty table with all the same types
---@param check_function function
---@param name?          string   # optional, used for error messages
---@param check_type?    string
---@param table_type?    string
---
---@return resty.jwt.validator
function validators.any_of(check_values, check_function, name, check_type, table_type) end
validators.opt_any_of = validators.any_of


--- Returns a validator that checks if a value exactly equals any of the given `check_values`.
---
---@param check_values any[]
---
---@return resty.jwt.validator
function validators.equals_any_of(check_values) end
validators.opt_equals_any_of = validators.equals_any_of


--- Returns a validator that checks if a value matches any of the given `patterns`.
---
---@param patterns string[]
---
---@return resty.jwt.validator
function validators.matches_any_of(patterns) end
validators.opt_matches_any_of = validators.matches_any_of


--- Returns a validator that checks if a value of expected type `string` exists in any of the given `check_values`.
---
---@param check_values any[]    # non-empty table with all the same types
---@param name?        string   # optional, used for error messages
---
---@return resty.jwt.validator
function validators.contains_any_of(check_values, name) end
validators.opt_contains_any_of = validators.contains_any_of


--- Returns a validator that checks how a value compares (numerically, using `>`) to a given `check_value`.
---@param check_val any
---@return resty.jwt.validator
function validators.greater_than(check_val) end
validators.opt_greater_than = validators.greater_than


--- Returns a validator that checks how a value compares (numerically, using `>=`) to a given `check_value`.
--- The value of `check_val` cannot be `nil` and must be a number.
---@param check_val any
---@return resty.jwt.validator
function validators.greater_than_or_equal(check_val) end
validators.opt_greater_than_or_equal = validators.greater_than_or_equal


--- Returns a validator that checks how a value compares (numerically, using `<`) to a given `check_value`.
---@param check_val number
---@return resty.jwt.validator
function validators.less_than(check_val) end
validators.opt_less_than = validators.less_than


--- Returns a validator that checks how a value compares (numerically, using `<=`) to a given `check_value`.
---@param check_val number
---@return resty.jwt.validator
function validators.less_than_or_equal(check_val) end
validators.opt_less_than_or_equal = validators.less_than_or_equal


--- Returns a validator that checks if the current time is not before the tested value within the system's leeway.  This means that:
---
---```lua
---  val <= (system_clock() + system_leeway).
---```
---@return resty.jwt.validator
function validators.is_not_before() end
validators.opt_is_not_before = validators.is_not_before

--- Returns a validator that checks if the current time is not equal to or after the tested value within the system's leeway.  This means that:
---```lua
---  val > (system_clock() - system_leeway).
---```
---@return resty.jwt.validator
function validators.is_not_expired() end
validators.opt_is_not_expired = validators.is_not_expired

--- Returns a validator that checks if the current time is the same as the tested value within the system's leeway.  This means that:
---```lua
---  val >= (system_clock() - system_leeway) and val <= (system_clock() + system_leeway).
---```
---@return resty.jwt.validator
function validators.is_at() end
validators.opt_is_at = validators.is_at

--- A function to set the leeway (in seconds) used for `is_not_before` and `is_not_expired`.  The default is to use `0` seconds
---@param leeway number
function validators.set_system_leeway(leeway) end


--- A function to set the system clock used for `is_not_before` and `is_not_expired`.  The default is to use `ngx.now`
---@param clock fun():number
function validators.set_system_clock(clock) end

return validators
