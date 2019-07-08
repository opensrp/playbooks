variable "vpc_name" {}
variable "vpc_cidr" {}
variable "vpc_env" {}
variable "vpc_owner" {}
variable "vpc_end_date" {}
variable "vpc_project" {}

variable "vpc_availability_zones" {
  type = "list"
}

variable "vpc_map_public_ip_on_launch" {
  default = false
}
