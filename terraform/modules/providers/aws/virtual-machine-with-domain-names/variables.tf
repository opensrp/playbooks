variable "vmdns_vm_ssh_key_name" {}
variable "vmdns_firewall_rules" {}
variable "vmdns_owner" {}
variable "vmdns_env" {}
variable "vmdns_end_date" {}
variable "vmdns_project" {}
variable "vmdns_name" {}
variable "vmdns_vpc_id" {}
variable "vmdns_vm_subnet_ids" {
  type = "list"
}
variable "vmdns_vm_availability_zones" {
  type = "list"
}
variable "vmdns_vm_instances" {
  type = "list"
}
variable "vmdns_domain_zone_name" {}
variable "vmdns_private_domain_names" {
  type = "list"
  default = []
}
variable "vmdns_public_domain_names" {
  type = "list"
  default = []
}