variable "name" {
  description = "Management access policy name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "description" {
  description = "Description."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", var.description))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }
}

variable "telnet" {
  description = "Telnet settings. Default value `admin_state`: `false`. Allowed values `port`: 1-65535. Default value `port`: 23."
  type = object({
    admin_state = optional(bool)
    port        = optional(number)
  })
  default = {}

  validation {
    condition     = var.telnet.port == null || try(var.telnet.port >= 1 && var.telnet.port <= 65535, false)
    error_message = "`port`: Minimum value: 1. Maximum value: 65535."
  }
}

variable "ssh" {
  description = "SSH settings. Default value `admin_state`: `true`. Default value `password_auth`: `true`. Allowed values `port`: 1-65535. Default value `port`: 22. Default value `aes128_ctr`: `true`. Default value `aes128_gcm`: `true`. Default value `aes192_ctr`: `true`. Default value `aes256_ctr`: `true`. Default value `chacha`: `true`. Default value `hmac_sha1`: `true`. Default value `hmac_sha2_256`: `true`. Default value `hmac_sha2_512`: `true`."
  type = object({
    admin_state   = optional(bool)
    password_auth = optional(bool)
    port          = optional(number)
    aes128_ctr    = optional(bool)
    aes128_gcm    = optional(bool)
    aes192_ctr    = optional(bool)
    aes256_ctr    = optional(bool)
    chacha        = optional(bool)
    hmac_sha1     = optional(bool)
    hmac_sha2_256 = optional(bool)
    hmac_sha2_512 = optional(bool)
  })
  default = {}

  validation {
    condition     = var.ssh.port == null || try(var.ssh.port >= 1 && var.ssh.port <= 65535, false)
    error_message = "`port`: Minimum value: 1. Maximum value: 65535."
  }
}

variable "https" {
  description = "HTTPS settings. Default value `admin_state`: `true`. Default value `client_cert_auth_state`: `false`. Allowed values `port`: 1-65535. Default value `port`: 443. Choices `dh`: `1024`, `2048`, `4096`, `none`. Default value `dh`: `none`. Default value `tlsv1`: `false`. Default value `tlsv1_1`: `true`. Default value `tlsv1_2`: `true`."
  type = object({
    admin_state            = optional(bool)
    client_cert_auth_state = optional(bool)
    port                   = optional(number)
    dh                     = optional(string)
    tlsv1                  = optional(bool)
    tlsv1_1                = optional(bool)
    tlsv1_2                = optional(bool)
    keyring                = optional(string)
  })
  default = {}

  validation {
    condition     = var.https.port == null || try(var.https.port >= 1 && var.https.port <= 65535, false)
    error_message = "`port`: Minimum value: 1. Maximum value: 65535."
  }

  validation {
    condition     = var.https.dh == null || try(contains(["1024", "2048", "4096", "none"], var.https.dh), false)
    error_message = "`dh`: Allowed values: `1024`, `2048`, `4096` or `none`."
  }

  validation {
    condition     = var.https.keyring == null || try(can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.https.keyring)), false)
    error_message = "`keyring`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "http" {
  description = "HTTP settings. Default value `admin_state`: `false`. Allowed values `port`: 1-65535. Default value `port`: 80."
  type = object({
    admin_state = optional(bool)
    port        = optional(number)
  })
  default = {}

  validation {
    condition     = var.http.port == null || try(var.http.port >= 1 && var.http.port <= 65535, false)
    error_message = "`port`: Minimum value: 1. Maximum value: 65535."
  }
}
