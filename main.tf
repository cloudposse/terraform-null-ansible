data "null_data_source" "ansible" {
  inputs = {
    command = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${join(" ", var.arguments)} -e ${join(" -e ", var.envs)} ${var.playbook}"
  }
}

resource "null_resource" "provisioner" {
  count = "${signum(length(var.playbook)) == 1 ? 1 : 0}"

  triggers {
    default = "${data.null_data_source.ansible.inputs.command}"
  }

  provisioner "local-exec" {
    command = "${data.null_data_source.ansible.inputs.command}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
