terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://proxmox.inside.lan:8006/api2/json"
  pm_user = var.proxmox_user
  #pm_password = var.proxmox_password
  # pm_api_token_id = "root@pam!proxmox"
  # pm_api_token_secret = ""
  # pm_log_enable = true
  # pm_log_file   = "terraform-plugin-proxmox.log"
  # pm_debug      = true
  # pm_log_levels = {
  #   _default    = "debug"
  #   _capturelog = ""
  # }
}