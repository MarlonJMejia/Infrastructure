Basic VM
```bash
create_template.py --vmid 2999 --name "Ubuntu24-04" --cinit ubuntu-user-data.yml --iso noble-server-cloudimg-amd64.img
```

with a VLAN
```
create_template.py --vmid 2999 --name "Ubuntu24-04" --cinit ubuntu-user-data.yml --iso noble-server-cloudimg-amd64.img --vlan 30
```

Cloud-Init file must be in /var/lib/vz/snippets
```
create_template.py --vmid 2999 --name "Ubuntu24-04" --cinit ubuntu-user-data.yml --iso noble-server-cloudimg-amd64.img --vlan 30 --cinit debian-user-data.yml
```
