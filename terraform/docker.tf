resource "proxmox_lxc" "dockerapps" {
  target_node     = "proxmox"
  hostname        = "dockerapps.inside.lan"
  ostemplate      = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
  unprivileged    = true
  ssh_public_keys = var.ssh_public_keys
  start           = true
  onboot          = true
  vmid            = var.dockerapps_lxcid
  memory          = 4048
  cpuunits        = 4084
  cores           = 2
  cpulimit        = 2
  tags = "debian;pxe"

  features {
    fuse = true
    nesting = true
    keyctl = true
  }

  // Mount points for iso files, folders need to be created in Proxmox first.

  mountpoint {
    mp      = "/dockerapps/" # server storage
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/dockerapps/"
    volume  = "/mnt/storage/appdata/dockerapps/"
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
    hwaddr = "bc:24:11:77:b4:76"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}