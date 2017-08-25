resource "null_resource" "provisioner" {
  count = "${signum(length(var.playbook)) == 1 ? 1 : 0}"

  triggers {
    default = "${sha256(file(var.playbook))}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${join(" ", var.arguments)} -e ${join(" -e ", var.envs)}" ${var.playbook}
  }

  lifecycle {
    create_before_destroy = true
  }
}
