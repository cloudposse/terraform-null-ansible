resource "null_resource" "provisioner" {
  count = "${signum(length(var.playbook)) == 1 ? 1 : 0}"
  provisioner "local-exec" {
    command = "ansible-playbook ${join(" ", var.arguments)} ${var.playbook} -e ${join("-e", var.envs)}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
