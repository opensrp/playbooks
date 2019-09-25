variable "vm_name" {
  type = string
}

variable "vm_env" {
  type = string
}

variable "vm_ssh_key_name" {
  type = string
}

variable "vm_owner" {
  type = string
}

variable "vm_project" {
  type = string
}

variable "vm_end_date" {
  type = string
}

variable "vm_vpc_id" {
  type = string
}

variable "vm_associate_public_ip_address" {
  type    = bool
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

variable "vm_internet_max_bandwidth_out" {
  type    = number
  default = 10
}

variable "vm_security_enhancement_strategy" {
  type    = string
  default = "Deactive"
}