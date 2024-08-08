variable "password_config" {
  type = object({
    username_size = number
    password_size = number
    special       = bool
    special_chars = string
  })
  description = "Password generation configuration"
  nullable    = false

  default = {
    username_size = 5
    password_size = 20
    special       = true
    special_chars = "!@#$%^&*()_+-=[]{}|:,.<>?"
  }
}