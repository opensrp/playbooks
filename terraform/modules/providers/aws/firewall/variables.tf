variable "firewall_vpc_id" {
}

variable "firewall_ingress_rules" {
  type = list(string)
}

variable "firewall_egress_rules" {
  type = list(string)
}

variable "firewall_owner" {
}

variable "firewall_env" {
}

variable "firewall_end_date" {
}

variable "firewall_project" {
}

variable "firewall_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}

variable "firewall_name" {
}

