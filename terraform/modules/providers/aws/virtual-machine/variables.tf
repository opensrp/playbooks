variable "vm_name" {}
variable "vm_env" {}
variable "vm_dns_zone_name" {}
variable "vm_ssh_key_name" {}
variable "vm_owner" {}
variable "vm_project" {}
variable "vm_end_date" {}

variable "vm_instances" {
  type = "list"
}

variable "vm_associate_public_ip_address" {
  default = true
}

variable "vm_dns_module" {
  default = "${file("${path.module}")}/../domain-name"
}

variable "vm_firewall_module" {
  default = "${file("${path.module}")}/../firewall"
}

variable "vm_firewall" {
  type = "list"
}

variable "vm_vpc_id" {}
