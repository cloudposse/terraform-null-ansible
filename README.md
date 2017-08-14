# tf_ansible

## Module usage

### Add special section to the playbook
You must add this section on the top of playbook that will be used for provision,
because Ansible needs an inventory and you, in any case, should add target host to an inventory (runtime or file based)
e.g. `../ansible/playbooks/playbook.yml`
* Create a runtime inventorty with an ip address of a host
* Wait for target host is ready for ssh connection

```
---
- hosts: localhost
  vars:
    gather_facts: true
  tasks:
  - name: Add public ip addresses to an dynamic inventory
    add_host:
      name: "{{ host }}"
      groups: all

  - local_action: wait_for port=22 host="{{ host }}" search_regex=OpenSSH delay=10

- hosts: all
  gather_facts: False
  become: True
  tasks:
  - name: Install python 2.7
    raw: test -e /usr/bin/python || (apt-get -y update && apt-get install -y python)
    args:
      creates: /usr/bin/python
```

### Create an aws instance
```
resource "aws_instance" "web" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"
  tags {
    Name        = test1
  }
}
```

### Apply the provisioner module to this resource
```
module "ansible_provisioner" {
   source    = "github.com/cloudposse/tf_ansible"
   arguments = ["--user=ubuntu"]
   envs      = ["host=${aws_instance.web.public_ip}"]
   playbook  = "../ansible/playbooks/provisioner.yml"

}
```
