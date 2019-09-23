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

variable "vpc_availability_zones" {
  type = list(string)
}

variable "vpc_nat_gateway_specification" {
  type    = string
  default = "Small"
}