variable "vpc_name" {
}

variable "vpc_cidr" {
}

variable "vpc_env" {
}

variable "vpc_owner" {
}

variable "vpc_end_date" {
}

variable "vpc_project" {
}

variable "vpc_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}

variable "vpc_availability_zones" {
  type = list(string)
}

variable "vpc_map_public_ip_on_launch" {
  default = false
}

