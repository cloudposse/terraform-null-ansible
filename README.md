# terraform-null-ansible

Terraform Module to run ansible playbooks.

## Module usage

### Add special section to the playbook

You must add this section on the top of all playbooks that will be used for provisioning.

This will add a dynamic inventory to target the host that needs provisioning.

e.g. `../ansible/playbooks/playbook.yml`

* Create a runtime inventorty with an ip address of a host
* Wait for target host is ready for ssh connection

```yaml
---
- hosts: localhost
  gather_facts: True
  check_mode: no
  tasks:
  - name: Add public ip addresses to an dynamic inventory
    add_host:
      name: "{{ host }}"
      groups: all

  - local_action: wait_for port=22 host="{{ host }}" search_regex=OpenSSH delay=10

- hosts: all
  gather_facts: False
  check_mode: no
  become: True
  tasks:
  - name: Install python 2.7
    raw: >
      test -e /usr/bin/python ||
      (
        (test -e /usr/bin/apt-get && (apt-get -y update && apt-get install -y python)) ||
        (test -e /usr/bin/yum && (yum makecache fast && yum install -y python))
      )
    args:
      creates: /usr/bin/python
```

### Create an aws instance

```hcl
resource "aws_instance" "web" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"
  tags {
    Name        = test1
  }
}
```

### Apply the provisioner module to this resource

```hcl
module "ansible_provisioner" {
   source    = "github.com/cloudposse/tf_ansible"

   arguments = ["--user=ubuntu"]
   envs      = ["host=${aws_instance.web.public_ip}"]
   playbook  = "../ansible/playbooks/test.yml"
   dry_run   = false

}
```
