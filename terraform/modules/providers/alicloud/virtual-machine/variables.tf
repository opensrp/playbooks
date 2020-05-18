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

variable "vm_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
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

variable "vm_private_domain_names" {
  type    = list(string)
  default = []
}

variable "vm_private_domain_names_host_record" {
  type        = string
  default     = "@"
  description = "Host record for the DNS A record for the load balancer."
}

variable "vm_public_domain_names" {
  type    = list(string)
  default = []
}

variable "vm_public_domain_names_host_record" {
  type        = string
  default     = "@"
  description = "Host record for the DNS A record for the load balancer."
}

variable "vm_user_data" {
  type        = string
  description = "The cloud-init user data to be applied to all the virtual machines. 'user_data' key in a VMs object inside the vm_instances variable will take presidence over this value."
  default     = <<EOF
#!/bin/bash

set -e
useradd -c ubuntu -s /bin/bash -m -d /home/ubuntu -U ubuntu -G sudo
echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/100-cloud-init-ubuntu
mkdir -p /home/ubuntu/.ssh
cp /root/.ssh/authorized_keys /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
EOF
}
