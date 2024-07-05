resource "proxmox_lxc" "authentik" {
  target_node     = "proxmox"
  hostname        = "authentik.inside.lan"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.gz"
  unprivileged    = true
  ssh_public_keys = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVDJkj1RWQvGVkUEVMG1koaWCylROa0Ri7acbMjqTvj illegal@legal
  EOT
  start           = true
  onboot          = true
  vmid            = var.authentik_lxcid
  memory          = 1048
  cpuunits        = 1084
  cores           = 2
  tags = "debian, authentik"

  features {
    keyctl = true #This is required to use docker inside a container.
    fuse = true
    nesting = true
  }

  mountpoint {
    mp      = "/var/lib/authentik/"
    size    = "2G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/authentik/"
    volume  = "/mnt/storage/appdata/authentik/"
  }

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4500M"
  }

  network {
    name   = "eth0"
    bridge = "vmbr1"
    ip = "dhcp"
    tag = "30"
    hwaddr = "bc:24:11:00:c7:79"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}