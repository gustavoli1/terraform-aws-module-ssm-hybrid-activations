variable "name" {
  description = "The name of the activation."
  type        = string
  default     = "ssm-activation"
}

variable "iam_role" {
  description = "The IAM role to associate with the managed instances."
  type        = string
  default     = ""
}

variable "registration_limit" {
  description = "The number of instances that can be registered using this activation."
  type        = number
  default     = 1
}

variable "expiration_date" {
  description = "The specific date when the activation expires, in RFC3339 format. If set, this takes precedence over expiration_in_days."
  type        = string
  default     = null
}

variable "expiration_in_days" {
  description = "Number of days until the activation expires. Valid between 1 and 30. Ignored if expiration_date is set."
  type        = number
  default     = null
}

variable "description" {
  description = "A description for the activation."
  type        = string
  default     = "SSM Hybrid Activation"
}

variable "tags" {
  description = "Tags to apply to the activation."
  type        = map(string)
  default     = {}
}

variable "create_iam_role" {
  description = "Whether to create the IAM role for the activation."
  type        = bool
  default     = true
}

variable "default_instance_name" {
  description = "The default name of the managed instance."
  type        = string
  default     = null
}
