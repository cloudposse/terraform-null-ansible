data "external" "md5sum" {
  program = ["sh", "${path.module}/md5sum.sh"]

  query = {
    path = "${dirname(var.playbook)}"
  }
}

resource "null_resource" "provisioner" {
  count      = "${signum(length(var.playbook)) == 1 ? 1 : 0}"
  depends_on = ["data.external.md5sum"]

  triggers {
    check_size = "${jsonencode(data.external.md5sum.result)}"
    command    = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${join(" ", var.arguments)} -e ${join(" -e ", var.envs)} ${var.playbook}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${join(" ", var.arguments)} -e ${join(" -e ", var.envs)} ${var.playbook}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
