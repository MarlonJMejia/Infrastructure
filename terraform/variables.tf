variable "proxmox_api_url" {
  description = "The Proxmox API URL"
  type        = string
  default     = "https://proxmox.inside.lan:8006/api2/json"
}

variable "proxmox_user" {
  description = "The Proxmox user"
  type        = string
  default     = "root@pam"
}

# variable "proxmox_password" {
#   description = "The Proxmox user password"
#   type        = string
# }

# variable "proxmox_token_id" {
#   description = "The Proxmox token ID"
#   type        = string
# }

# variable "pm_api_token_secret" {
#   description = "The Proxmox token ID"
#   type        = string
# }

variable "ssh_public_keys" {
  type    = string
  default = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVDJkj1RWQvGVkUEVMG1koaWCylROa0Ri7acbMjqTvj illegal@legal
  EOT
}

variable "dockerapps_lxcid" {
  description = "Linux Container ID for docker"
  type        = number
  default     = "700"
}

variable "proxy_lxcid" {
  description = "Linux Container ID for proxy"
  type        = number
  default     = "998"
}

variable "netbootxyz_lxcid" {
  description = "Linux Container ID for pxe"
  type        = number
  default     = "999"
}

variable "freeipa_lxcid" {
  description = "Linux Container ID for freeipa"
  type        = number
  default     = "1000"
}

variable "thelounge_lxcid" {
  description = "Linux Container ID for sensu"
  type        = number
  default     = "1001"
}

variable "wikijs_lxcid" {
  description = "Linux Container ID for wikijs"
  type        = number
  default     = "1002"
}

variable "influxdb_lxcid" {
  description = "Linux Container ID for sensu"
  type        = number
  default     = "1003"
}

variable "authentik_lxcid" {
  description = "Linux Container ID for sensu"
  type        = number
  default     = "1004"
}