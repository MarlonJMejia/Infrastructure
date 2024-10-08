resource "proxmox_lxc" "thelounge" {
  target_node     = "proxmox"
  hostname        = "thelounge.inside.lan"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
  unprivileged    = true
  ssh_public_keys = var.ssh_public_keys
  start           = true
  onboot          = true
  vmid            = var.thelounge_lxcid
  memory          = 3048
  cpuunits        = 3084
  cores           = 2
  cpulimit        = 2
  tags = "debian;irc"

  features {
    nesting = true
  }

  mountpoint {
    mp      = "/etc/thelounge"
    size    = "10G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/thelounge"
    volume  = "/mnt/storage/appdata/thelounge"
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
    hwaddr = "bc:24:11:77:b4:89"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}
