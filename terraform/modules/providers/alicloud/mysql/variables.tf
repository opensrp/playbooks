variable "mysql_name" {
  type = string
}

variable "mysql_cidr" {
  type = string
}

variable "mysql_env" {
  type = string
}

variable "mysql_owner" {
  type = string
}

variable "mysql_end_date" {
  type = string
}

variable "mysql_project" {
  type = string
}

variable "mysql_vpc_id" {
  type = string
}

variable "mysql_vswitch_id" {
  type = string
}

variable "mysql_availability_zones" {
  type        = list(string)
  description = "The availability zones the database should be part of. The provided mysql_vswitch_id should be in one of the availablility zones."
}

variable "mysql_allocated_storage" {
  type = string
}

variable "mysql_version" {
  type = string
}

variable "mysql_instance_type" {
  type = string
}

variable "mysql_firewall_rule_ingress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks allowed to access all databases of an instance. The list contains up to 1,000 blocks"
}

variable "mysql_backup_retention_period" {
  type    = number
  default = 7
}

variable "mysql_backup_period" {
  type    = list(string)
  default = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
}

variable "mysql_backup_time" {
  type        = string
  default     = "02:00Z-03:00Z"
  description = "DB instance backup time, in the format of HH:mmZ- HH:mmZ. Time setting interval is one hour."
}

variable "mysql_username" {
  type = string
}

variable "mysql_password" {
  type = string
}
