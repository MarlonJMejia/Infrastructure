# Ansible

`ansible-playbook site.yml --forks 100`

`ansible-playbook site.yml --limit webservers`

`ansible-galaxy collection install community.general`


`ansible -m {package} -a "key=value" all`
`ansible -m debug -a "msg={{inventory_hostname}}" all`

`ansible-playbook playbooks/update.yml --tags "set_tiemzone"`

## Creating your own facts

```yaml
- name: Work with Ansible Facts
  hosts: proxy
  become: yes
  gather_facts: yes
  tasks:
    - name: Ensure directory is exist
      file:
        path: /etc/ansible/facts.d
        state: directory
        recurse: yes
        
    - name: Copy the content to the file
      copy:
        content: |
            [application]
            name=haproxy
        dest: /etc/ansible/facts.d/environment.fact

    - name: debug
      debug:
        msg: "{{ ansible_local.custom.sample_exam }}"
```

## Filtering

```bash
ansible -m setup -a "filter=ansible_local" proxy
```

# Terraform

`terraform plan -o output.json`
`terraform plan`

`terraform destroy --target=proxmox_lxc.thelounge --auto-approve`