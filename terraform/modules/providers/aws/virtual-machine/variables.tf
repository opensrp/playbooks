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

variable "vm_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
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

variable "vm_root_block_device_encrypted" {
  type    = bool
  default = false
}

variable "vm_user_data" {
  type        = string
  description = "The cloud-init user data to be applied to all the virtual machines. 'user_data' key in a VMs object inside the vm_instances variable will take presidence over this value."
  default     = <<EOF
#!/bin/bash

echo "Instance is up!"
EOF
}
