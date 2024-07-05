resource "proxmox_lxc" "proxy" {
  target_node     = "proxmox"
  hostname        = "proxy.inside.lan"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.gz"
  unprivileged    = true
  ssh_public_keys = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVDJkj1RWQvGVkUEVMG1koaWCylROa0Ri7acbMjqTvj illegal@legal
  EOT
  start           = true
  onboot          = true
  vmid            = var.proxy_lxcid
  memory          = 1048
  cpuunits        = 1084
  cores           = 2
  tags = "debian, proxy"

  features {
    fuse = true
    nesting = true
    keyctl = true
  }

  mountpoint {
    mp      = "/mnt/storage/appdata/proxy/"
    size    = "2G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/proxy/"
    volume  = "/mnt/storage/appdata/proxy/"
  }

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "3500M"
  }

  network {
    name   = "eth0"
    bridge = "vmbr1"
    ip = "dhcp"
    tag = "50" # VLAN for Container
    hwaddr = "BC:24:11:1A:08:9C"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}