#####################################################################################
# Variables for control Tower Controls/Guardrails
#####################################################################################

# AWS Control Tower Controls (sometimes called Guardrails) Input Variable Types
variable "enable_guardrails_module" {
  description = "configuration to enable/disable organisational guardrails managed via terraform"
  type        = bool
  default     = false
}

variable "organisational_unit_root_id" {
  description = "ID of aws organisational root ou"
  type        = string
}

variable "controls" {
  description = "Configuration of AWS Control Tower Guardrails for the whole organization"
  type = list(object({
    control_names           = list(string)
    organizational_unit_ids = list(string)
  }))
}


#####################################################################################
# Variables for organisazional Backup policy
#####################################################################################
variable "enable_backup_module" {
  description = "configuration to enable/disable organisational backup policy managed via terraform"
  type        = bool
  default     = false
}