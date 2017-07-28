
resource "null_resource" "provisioner" {

  provisioner "local-exec" {
    command = "ansible-playbook ${var.playbook} -e ${join("-e", var.envs)}"
  }

  lifecycle {
    create_before_destroy = true
  }

}
