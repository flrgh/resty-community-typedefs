---@meta


--- https://github.com/GUI/lua-resty-mail
---
---@class resty.mail
---
---@field _VERSION string
local mail = {}


---@class resty.mail.mailer : table
local mailer = {}


--- Send an email via the SMTP server.
---
--- This function returns true on success. In case of errors, returns nil and a string describing the error.
---
---@param data resty.mail.mailer.send.data
function mailer:send(data) end


---@class resty.mail.mailer.send.data : table
---@field from         string   #  Email address for the From header.
---@field reply_to?    string   # Email address for the Reply-To header.
---@field to           string[] # A table (list-like) of email addresses for the To recipients.
---@field cc?          string[] # A table (list-like) of email addresses for the Cc recipients.
---@field bcc?         string[] # A table (list-like) of email addresses for the Bcc recipients.
---@field subject      string   # Message subject.
---@field text?        string   # Body of the message (plain text version).
---@field html?        string   # Body of the message (HTML verion).
---@field headers?     table<string, string>               # A table of additional headers to set on the message.
---@field attachments? resty.mail.mailer.send.attachment[] # A table (list-like) of file attachments for the message.


--- Each attachment must be an table (map-like) with the following fields:
---@class resty.mail.mailer.send.attachment : table
---@field filename     string                # The filename of the attachment.
---@field content_type string                # The Content-Type of the file attachment.
---@field content      string                # The contents of the file attachment as a string.
---@field disposition? "attachment"|"inline" # The Content-Disposition of the file attachment. Can either be attachment or inline. (default: attachment)
---@field content_id?  string                # The Content-ID of the file attachment. (default: randomly generated ID)


---@class resty.mail.new.opts : table
---
---@field host?             string          # The host of the SMTP server to connect to. (default: localhost)
---@field port?             number          # The port number on the SMTP server to connect to. (default: 25)
---@field starttls?         boolean         # Set to true to ensure STARTTLS is always used to encrypt communication with the SMTP server. If not set, STARTTLS will automatically be enabled if the server supports it (but explicitly setting this to true if your server supports it is preferable to prevent STRIPTLS attacks). This is usually used in conjunction with port 587. (default: nil)
---@field ssl?              boolean         # Set to true to use SMTPS to encrypt communication with the SMTP server (not needed if STARTTLS is being used instead). This is usually used in conjunction with port 465. (default: nil)
---@field username?         string          # Username to use for SMTP authentication. (default: nil)
---@field password?         string          # Password to use for SMTP authentication. (default: nil)
---@field auth_type?        "plain"|"login" # The type of SMTP authentication to perform. Can either be plain or login. (default: plain if username and password are present)
---@field domain?           string          # The domain name presented to the SMTP server during the EHLO connection and used as part of the Message-ID header. (default: localhost.localdomain)
---@field ssl_verify?       boolean         # Whether or not to perform verification of the server's certificate when either ssl or starttls is enabled. If this is enabled then configuring the lua_ssl_trusted_certificate setting will be required. (default: false)
---@field ssl_host?         string          # If the hostname of the server's certificate is different than the host option, this setting can be used to specify a different host used for SNI and TLS verification when either ssl or starttls is enabled. (default: the host option's value)
---@field timeout_connect?  number          # The timeout (in milliseconds) for connecting to the SMTP server. (default: OpenResty's global lua_socket_connect_timeout timeout, which defaults to 60s)
---@field timeout_send?     number          # The timeout (in milliseconds) for sending data to the SMTP server. (default: OpenResty's global lua_socket_send_timeout timeout, which defaults to 60s)
---@field timeout_read?     number          # The timeout (in milliseconds) for reading data from the SMTP server. (default: OpenResty's global lua_socket_read_timeout timeout, which defaults to 60s)


---@param opts resty.mail.new.opts
---@return resty.mail.mailer? mailer
---@return string?            error
function mail.new(opts) end


return mail
