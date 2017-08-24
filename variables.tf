variable "arguments" {
  type = "list"
}

variable "envs" {
  type = "list"
}

variable "playbook" {}

variable "dry_run" {
  default = true
}
