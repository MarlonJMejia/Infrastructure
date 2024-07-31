# Ansible

`ansible-playbook site.yml`

`ansible-playbook site.yml --limit webservers`

`ansible-galaxy collection install community.general`


`ansible -m {package} -a "key=value" all`
`ansible -m debug -a "msg={{inventory_hostname}}" all`

`ansible-playbook playbooks/update.yml --tags "set_tiemzone"`

# Terraform

`terraform plan -o output.json`
`terraform plan`

`terraform destroy --target=proxmox_lxc.thelounge --auto-approve`