# tf_ansible

## Module usage

### Create an aws instance
resource "aws_instance" "web" {
  ami = "ami-408c7f28"
  instance_type = "t1.micro"
  tags {Name:test1}
}

## Aply the provisioner module to this resource
module "ansible_provisioner" {
  source  = "github.com/cloudposse/tf_ansible"
  ip = "${aws_instance.web.public_ip}"
  playbook = "../ansible/playbooks/playbook.yml"
}

