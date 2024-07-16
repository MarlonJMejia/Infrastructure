resource "proxmox_lxc" "influxdb" {
  target_node     = "proxmox"
  hostname        = "influxdb.inside.lan"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
  unprivileged    = true
  ssh_public_keys = var.ssh_public_keys
  start           = true
  onboot          = true
  vmid            = var.influxdb_lxcid
  memory          = 1048
  cpuunits        = 1084
  cores           = 2
  cpulimit        = 2
  tags = "debian;influxdb;monitoring"

  features {
    nesting = true
  }

  mountpoint {
    mp      = "/var/lib/influxdb/"
    size    = "2G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/influxdb/"
    volume  = "/mnt/storage/appdata/influxdb/"
  }

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "3000M"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    tag = "30"
    hwaddr = "bc:24:11:00:c7:78"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}