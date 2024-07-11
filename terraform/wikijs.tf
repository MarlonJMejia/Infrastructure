resource "proxmox_lxc" "wikijs" {
  target_node     = "proxmox"
  hostname        = "wikijs.inside.lan"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.gz"
  unprivileged    = true
  ssh_public_keys = var.ssh_public_keys
  start           = true
  onboot          = true
  vmid            = var.wikijs_lxcid
  memory          = 3000
  description = "<img src='https://raw.githubusercontent.com/requarks/wiki/904260fd44729ed2f75267daebd70499305121f8/client/static/svg/logo-wikijs.svg'/>"

  tags = "debian;docs"

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "3G"
  }

  // Mount points for wikijs backups

  mountpoint {
    mp      = "/mnt/storage/appdata/wikijs/"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/wikijs/"
    volume  = "/mnt/storage/appdata/wikijs/"
  }

  // DNS Records will be created by opnsense for ansible to use
  network {
    name   = "eth0"
    bridge = "vmbr1"
    ip = "dhcp"
    tag = "30"
    hwaddr = "BC:24:11:01:39:B6"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      description,
    ]
  }
}