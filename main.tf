
resource "null_resource" "ansible_provisioner" {

  provisioner "local-exec" {
    command = "ansible-playbook ${var.playbook} -e host=${var.ip}"
  }

  lifecycle {
    create_before_destroy = true
  }

}
