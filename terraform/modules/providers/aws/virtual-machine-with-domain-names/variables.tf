variable "vmdns_vm_ssh_key_name" {
}

variable "vmdns_firewall_rules" {
}

variable "vmdns_owner" {
}

variable "vmdns_env" {
}

variable "vmdns_end_date" {
}

variable "vmdns_project" {
}

variable "vmdns_name" {
}

variable "vmdns_vpc_id" {
}

variable "vmdns_vm_availability_zones" {
  type = list(string)
}

variable "vmdns_vm_instances" {
  type = list(object({ group = string, parent_image = string, instance_type = string, volume_size = string, volume_type = string }))
}

variable "vmdns_domain_zone_name" {
}

variable "vmdns_private_domain_names" {
  type    = list(string)
  default = []
}

variable "vmdns_public_domain_names" {
  type    = list(string)
  default = []
}

variable "vmdns_root_block_device_encrypted" {
  type    = bool
  default = false
}
