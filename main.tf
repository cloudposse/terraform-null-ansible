resource "random_id" "default" {
  byte_length = 8
}

data "archive_file" "default" {
  type        = "zip"
  source_dir  = "${dirname(var.playbook)}"
  output_path = "${path.module}/${random_id.default.hex}.zip"
}

resource "null_resource" "provisioner" {
  count = "${signum(length(var.playbook)) == 1 ? 1 : 0}"

  depends_on = ["data.archive_file.default"]

  triggers {
    signature = "${data.archive_file.default.output_md5}"
    command   = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${length(compact(concat(var.arguments))) > 0 ? join(" ", var.arguments) : ""} ${length(compact(concat(var.envs))) > 0 ? join(" -e ", var.envs) : ""} ${var.playbook}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook ${var.dry_run ? "--check --diff" : ""} ${length(compact(concat(var.arguments))) > 0 ? join(" ", var.arguments) : ""} ${length(compact(concat(var.envs))) > 0 ? join(" -e ", var.envs) : ""} ${var.playbook}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "cleanup" {
  triggers {
    default = "${random_id.default.hex}"
  }

  provisioner "local-exec" {
    command = "rm -f ${data.archive_file.default.output_path}"
  }
}
