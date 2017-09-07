data "external" "size" {
  program = ["sh", "${path.module}/size.sh"]

  query = {
    path = "${dirname(var.playbook)}"
  }
}

resource "null_resource" "provisioner" {
  count      = "${signum(length(var.playbook)) == 1 ? 1 : 0}"
  depends_on = ["data.external.size"]

  triggers {
    check_size = "${data.external.size.result}"
    command    = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${join(" ", var.arguments)} -e ${join(" -e ", var.envs)} ${var.playbook}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${join(" ", var.arguments)} -e ${join(" -e ", var.envs)} ${var.playbook}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
