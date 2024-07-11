output "all_lxc_info" {
  value = {
    thelounge = {
      hostname = proxmox_lxc.thelounge.hostname
      vmid     = proxmox_lxc.thelounge.vmid
      ip       = proxmox_lxc.thelounge.network[0].ip
      hwaddr   = proxmox_lxc.thelounge.network[0].hwaddr
    }
    influxdb = {
      hostname = proxmox_lxc.influxdb.hostname
      vmid     = proxmox_lxc.influxdb.vmid
      ip       = proxmox_lxc.influxdb.network[0].ip
      hwaddr   = proxmox_lxc.influxdb.network[0].hwaddr
    }
    wikijs = {
      hostname = proxmox_lxc.wikijs.hostname
      vmid     = proxmox_lxc.wikijs.vmid
      ip       = proxmox_lxc.wikijs.network[0].ip
      hwaddr   = proxmox_lxc.wikijs.network[0].hwaddr
    }
    # Add more entries for other instances
  }
}
