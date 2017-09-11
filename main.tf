data "archive_file" "md5sum" {
  type        = "zip"
  source_dir  = "${dirname(var.playbook)}"
  output_path = "${path.module}/playbook.zip"
}

resource "null_resource" "provisioner" {
  count      = "${signum(length(var.playbook)) == 1 ? 1 : 0}"
  depends_on = ["data.archive_file.md5sum"]

  triggers {
    signature = "${data.archive_file.md5sum.output_md5}"
    command   = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${join(" ", var.arguments)} -e ${join(" -e ", var.envs)} ${var.playbook}"
  }

  provisioner "local-exec" {
    command = "rm -rf ${path.module}/playbook.zip"
  }

  provisioner "local-exec" {
    command = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${join(" ", var.arguments)} -e ${join(" -e ", var.envs)} ${var.playbook}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
