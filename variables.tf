variable "arguments" {
  default = []
  type    = "list"
  description = "Arguments"
}

variable "envs" {
  default = []
  type    = "list"
  description = "Environment variables"
}

variable "playbook" {
  default = ""
  description = "Playbook to run"
}

variable "dry_run" {
  default = true
  description = "Do dry run"
}
