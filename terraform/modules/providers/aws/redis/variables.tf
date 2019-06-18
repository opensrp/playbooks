variable "redis_vm_ssh_key_name" {}
variable "redis_firewall_ingress_rules" {}
variable "redis_firewall_egress_rules" {}
variable "redis_owner" {}
variable "redis_env" {}
variable "redis_end_date" {}
variable "redis_project" {}
variable "redis_name" {}
variable "redis_version" {}
variable "redis_port" {
  default = 6379
}
variable "redis_vpc_id" {}
variable "redis_vm_subnet_ids" {
  type = "list"
}
variable "redis_vm_availability_zones" {
  type = "list"
}
variable "redis_vm_instances" {
  type = "list"
}
variable "redis_domain_zone_name" {}
variable "redis_domain_names" {
  type = "list"
}