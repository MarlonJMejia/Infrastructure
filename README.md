`ansible-playbook site.yml`

`ansible-playbook site.yml --limit webservers`

`ansible-galaxy collection install community.general`


`ansible -m {package} -a "key=value" all`
`ansible -m debug -a "msg={{inventory_hostname}}" all`