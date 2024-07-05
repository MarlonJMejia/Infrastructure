resource "proxmox_lxc" "thelounge" {
  target_node     = "proxmox"
  hostname        = "thelounge.inside.lan"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.gz"
  unprivileged    = true
  ssh_public_keys = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVDJkj1RWQvGVkUEVMG1koaWCylROa0Ri7acbMjqTvj illegal@legal
  EOT
  start           = true
  onboot          = true
  vmid            = var.thelounge_lxcid
  memory          = 1048
  cpuunits        = 1084
  cores           = 2
  tags = "debian, irc"

  mountpoint {
    mp      = "/etc/thelounge"
    size    = "4G"
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
    bridge = "vmbr1"
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