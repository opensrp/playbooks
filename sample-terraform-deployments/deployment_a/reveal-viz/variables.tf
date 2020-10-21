variable "region" {}

variable "vpc_id" {}

variable "webserver_firewall_rule_name" {}

variable "webserver_firewall_rule_description" {}

variable "owner" {}

variable "env" {}

variable "end_date" {}

variable "project" {}

variable "ssh_firewall_rule_name" {}

variable "ssh_firewall_rule_description" {}

variable "ssh_firewall_rule_ingress_cidr_blocks" {}

variable "vm_ssh_key_name" {}

variable "vmdns_name" {}

variable "availability_zones" {}

variable "domain_zone_name" {}

variable "vmdns_public_domain_names" {}

variable "vmdns_vm_instances" {
  type = list(object({
    admin_password    = string
    admin_user        = string
    reveal_web_domain = string
    superset_domain   = string
    certbot_email     = string
    group             = string
    init_action       = string
    instance_type     = string
    parent_image      = string
    software_version  = string
    volume_size       = string
    volume_type       = string
  }))
}

variable "uptimerobot_monitors" {
  description = "List of monitors to set up with their respective information"
  type = map(object({
    alert_contacts = list(string)
    friendly_name  = string
    monitor_type   = string
    keyword_type   = string
    keyword_value  = string
    url            = string
    interval       = number
  }))
}
