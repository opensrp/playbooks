variable "domain_zone_name" {
}

variable "domain_name" {
}

variable "domain_name_alias" {
  default = ""
}

variable "domain_name_alias_zone_id" {
  default = ""
}

variable "domain_name_cnames" {
  type = list(string)
}

variable "domain_name_ip_addresses" {
  type    = list(string)
  default = []
}

