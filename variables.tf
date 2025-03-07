variable "enable_iam_project" {
  description = "Enable or disable the IAM project module"
  type        = bool
  default     = true
}

variable "enable_organizations_project" {
  description = "Enable or disable the Organizations project module"
  type        = bool
  default     = true
}

variable "run_terraform_apply" {
  description = "Control whether to run terraform apply or destroy"
  type        = bool
  default     = false
}