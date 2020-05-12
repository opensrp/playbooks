variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_env" {
  type = string
}

variable "vpc_owner" {
  type = string
}

variable "vpc_end_date" {
  type = string
}

variable "vpc_project" {
  type = string
}

variable "vpc_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}

variable "vpc_availability_zones" {
  type = list(string)
}

variable "vpc_nat_gateway_specification" {
  type    = string
  default = "Small"
}

variable "vpc_subnet_newbits" {
  type        = number
  default     = 8
  description = "The number of additional bits with which to extend the subnet prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20"
}