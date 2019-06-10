variable "firewall_name" {}
variable "firewall_description" {}
variable "firewall_vpc_id" {}

variable "firewall_ingress_rules" {
  type = "list"
}

variable "firewall_egress_rules" {
  type = "list"
}

variable "firewall_owner" {}
variable "firewall_env" {}
variable "firewall_end_date" {}
variable "firewall_project" {}
