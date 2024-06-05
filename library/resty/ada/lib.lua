---@meta

---@class resty.ada.lib
local lib = {}

---@class resty.ada.lib.ada_owned_string
---@field data   any
---@field length integer

---@class resty.ada.lib.ada_string
---@field data   any
---@field length integer

---@class resty.ada.lib.ada_string_pair
---@field key   resty.ada.lib.ada_string
---@field value resty.ada.lib.ada_string

---@alias resty.ada.lib.ada_url ffi.cdata*
---@alias resty.ada.lib.ada_strings ffi.cdata*
---@alias resty.ada.lib.ada_url_search_params ffi.cdata*
---@alias resty.ada.lib.ada_url_search_params_keys_iter ffi.cdata*
---@alias resty.ada.lib.ada_url_search_params_values_iter ffi.cdata*
---@alias resty.ada.lib.ada_url_search_params_entries_iter ffi.cdata*

---@param params string
---@param len integer
---@return resty.ada.lib.ada_url_search_params
function lib.ada_parse_search_params(params, len) end

---@param s resty.ada.lib.ada_url_search_params
function lib.ada_search_params_sort(s) end

---@param s resty.ada.lib.ada_url_search_params
---@return resty.ada.lib.ada_owned_string
function lib.ada_search_params_to_string(s) end

---@param s         resty.ada.lib.ada_url_search_params
---@param key       string
---@param key_len   integer
---@param value     string
---@param value_len integer
function lib.ada_search_params_append(s, key, key_len, value, value_len) end

---@param  s resty.ada.lib.ada_url_search_params
---@return integer
function lib.ada_search_params_size(s) end

---@param s         resty.ada.lib.ada_url_search_params
---@param key       string
---@param key_len   integer
---@param value     string
---@param value_len integer
function lib.ada_search_params_set(s, key, key_len, value, value_len) end

---@param s         resty.ada.lib.ada_url_search_params
---@param key       string
---@param key_len   integer
function lib.ada_search_params_remove(s, key, key_len) end

---@param s         resty.ada.lib.ada_url_search_params
---@param key       string
---@param key_len   integer
---@param value     string
---@param value_len integer
function lib.ada_search_params_remove_value(s, key, key_len, value, value_len) end

---@param s         resty.ada.lib.ada_url_search_params
---@param key       string
---@param key_len   integer
---@return boolean
function lib.ada_search_params_has(s, key, key_len) end

---@param s         resty.ada.lib.ada_url_search_params
---@param key       string
---@param key_len   integer
---@param value     string
---@param value_len integer
---@return boolean
function lib.ada_search_params_has_value(s, key, key_len, value, value_len) end

---@param s         resty.ada.lib.ada_url_search_params
---@param key       string
---@param key_len   integer
---@return resty.ada.lib.ada_string
function lib.ada_search_params_get(s, key, key_len) end

---@param s         resty.ada.lib.ada_url_search_params
---@param key       string
---@param key_len   integer
---@return resty.ada.lib.ada_strings
function lib.ada_search_params_get_all(s, key, key_len) end

---@param ada_strings resty.ada.lib.ada_strings
---@return integer
function lib.ada_strings_size(ada_strings) end

---@param ada_strings resty.ada.lib.ada_strings
---@param index integer
---@return resty.ada.lib.ada_string|nil
function lib.ada_strings_get(ada_strings, index) end

---@param ada_url resty.ada.lib.ada_url
function lib.ada_clear_port(ada_url) end

---@param ada_url resty.ada.lib.ada_url
function lib.ada_clear_hash(ada_url) end

---@param ada_url resty.ada.lib.ada_url
function lib.ada_clear_search(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_credentials(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_empty_hostname(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_hostname(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_non_empty_username(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_non_empty_password(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_port(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_password(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_hash(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_has_search(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
---@return boolean ok
function lib.ada_set_href(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
---@return boolean ok
function lib.ada_set_host(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
---@return boolean ok
function lib.ada_set_hostname(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
---@return boolean ok
function lib.ada_set_protocol(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
---@return boolean ok
function lib.ada_set_username(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
---@return boolean ok
function lib.ada_set_password(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
---@return boolean ok
function lib.ada_set_port(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
---@return boolean ok
function lib.ada_set_pathname(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
function lib.ada_set_search(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@param input string
---@param length integer
function lib.ada_set_hash(ada_url, input, length) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_href(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_username(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_password(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_port(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_hash(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_host(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_hostname(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_pathname(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_search(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_string
function lib.ada_get_protocol(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_owned_string
function lib.ada_get_origin(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return integer
function lib.ada_get_host_type(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return integer
function lib.ada_get_scheme_type(ada_url) end

---@param input string
---@param length integer
---@return resty.ada.lib.ada_owned_string
function lib.ada_idna_to_unicode(input, length) end

---@param input string
---@param length integer
---@return resty.ada.lib.ada_owned_string
function lib.ada_idna_to_ascii(input, length) end

---@param ada_url resty.ada.lib.ada_url
---@return boolean
function lib.ada_is_valid(ada_url) end

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_url copy
function lib.ada_copy(ada_url) end

---@class resty.ada.lib.ada_url_components
---@field protocol_end   integer
---@field username_end   integer
---@field host_start     integer
---@field host_end       integer
---@field port           integer
---@field pathname_start integer
---@field search_start   integer
---@field hash_start     integer

---@param ada_url resty.ada.lib.ada_url
---@return resty.ada.lib.ada_url_components
function lib.ada_get_components(ada_url) end

---@param input string
---@param length integer
---@return resty.ada.lib.ada_url
function lib.ada_parse(input, length) end

---@param input string
---@param length integer
---@param base string
---@param base_len integer
---@return resty.ada.lib.ada_url
function lib.ada_parse_with_base(input, length, base, base_len) end

---@param input string
---@param length integer
---@return boolean
function lib.ada_can_parse(input, length) end

---@param input string
---@param length integer
---@param base string
---@param base_len integer
---@return boolean
function lib.ada_can_parse_with_base(input, length, base, base_len) end

---@param ada_url resty.ada.lib.ada_url
function lib.ada_free(ada_url) end

---@param owned resty.ada.lib.ada_owned_string
function lib.ada_free_owned_string(owned) end

---@param owned resty.ada.lib.ada_url_search_params
function lib.ada_free_search_params(owned) end

---@param owned resty.ada.lib.ada_strings
function lib.ada_free_strings(owned) end

---@param iter resty.ada.lib.ada_url_search_params_keys_iter
function lib.ada_free_search_params_keys_iter(iter) end

---@param iter resty.ada.lib.ada_url_search_params_values_iter
function lib.ada_free_search_params_values_iter(iter) end

---@param iter resty.ada.lib.ada_url_search_params_entries_iter
function lib.ada_free_search_params_entries_iter(iter) end

---@param iter resty.ada.lib.ada_url_search_params_keys_iter
---@return boolean
function lib.ada_search_params_keys_iter_has_next(iter) end

---@param iter resty.ada.lib.ada_url_search_params_values_iter
---@return boolean
function lib.ada_search_params_values_iter_has_next(iter) end

---@param iter resty.ada.lib.ada_url_search_params_entries_iter
---@return boolean
function lib.ada_search_params_entries_iter_has_next(iter) end

---@param params resty.ada.lib.ada_url_search_params
---@return resty.ada.lib.ada_url_search_params_keys_iter
function lib.ada_search_params_get_keys(params) end

---@param params resty.ada.lib.ada_url_search_params
---@return resty.ada.lib.ada_url_search_params_values_iter
function lib.ada_search_params_get_values(params) end

---@param params resty.ada.lib.ada_url_search_params
---@return resty.ada.lib.ada_url_search_params_entries_iter
function lib.ada_search_params_get_entries(params) end

---@param iter resty.ada.lib.ada_url_search_params_keys_iter
---@return resty.ada.lib.ada_string
function lib.ada_search_params_keys_iter_next(iter) end

---@param iter resty.ada.lib.ada_url_search_params_values_iter
---@return resty.ada.lib.ada_string
function lib.ada_search_params_values_iter_next(iter) end

---@param iter resty.ada.lib.ada_url_search_params_entries_iter
---@return resty.ada.lib.ada_string_pair
function lib.ada_search_params_entries_iter_next(iter) end

return lib
