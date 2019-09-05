variable "vm_name" {
}

variable "vm_env" {
}

variable "vm_ssh_key_name" {
}

variable "vm_owner" {
}

variable "vm_project" {
}

variable "vm_end_date" {
}

variable "vm_vpc_id" {
}

variable "vm_associate_public_ip_address" {
  default = true
}

variable "vm_availability_zones" {
  type = list(string)
}

variable "vm_firewall_rules" {
  type = list(string)
}

variable "vm_instances" {
  type = list(object({ group = string, parent_image = string, instance_type = string, volume_size = string, volume_type = string }))
}