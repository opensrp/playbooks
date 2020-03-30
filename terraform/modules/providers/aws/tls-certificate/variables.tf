variable "tls_certificate_domain_name" {
}

variable "tls_certificate_domain_name_cnames" {
  type    = list(string)
  default = []
}

variable "tls_certificate_name" {
}

variable "tls_certificate_env" {
}

variable "tls_certificate_owner" {
}

variable "tls_certificate_project" {
}

variable "tls_certificate_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}

variable "tls_certificate_end_date" {
}

variable "tls_certificate_domain_zone_name" {
}

