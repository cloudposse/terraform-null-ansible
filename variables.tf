variable "arguments" {
  default     = []
  type        = list(string)
  description = "Arguments"
}

variable "envs" {
  default     = []
  type        = list(string)
  description = "Environment variables"
}

variable "playbook" {
  default     = ""
  description = "Playbook to run"
}

variable "dry_run" {
  default     = true
  description = "Do dry run"
}
