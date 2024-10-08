resource "proxmox_lxc" "netbootxyz" {
  target_node     = "proxmox"
  hostname        = "pxe.inside.lan"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
  unprivileged    = true
  ssh_public_keys = var.ssh_public_keys
  start           = true
  onboot          = true
  vmid            = var.netbootxyz_lxcid
  memory          = 2048
  tags = "debian;pxe"

  features {
    fuse = true
    nesting = true
    keyctl = true
  }

  // Mount points for iso files, folders need to be created in Proxmox first.

  mountpoint {
    mp      = "/mnt/storage/appdata/netbootxyz/"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/netbootxyz/"
    volume  = "/mnt/storage/appdata/netbootxyz/"
  }

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "3G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    tag = "30"
    hwaddr = "DA:DD:70:4A:01:F3"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}