variable "arguments" {
  default = [""]
  type    = "list"
}

variable "envs" {
  default = [""]
  type    = "list"
}

variable "playbook" {
  default = ""
}

variable "dry_run" {
  default = true
}
