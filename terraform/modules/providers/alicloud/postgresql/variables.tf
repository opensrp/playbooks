variable "postgresql_name" {
  type = string
}

variable "postgresql_cidr" {
  type = string
}

variable "postgresql_env" {
  type = string
}

variable "postgresql_owner" {
  type = string
}

variable "postgresql_end_date" {
  type = string
}

variable "postgresql_project" {
  type = string
}

variable "postgresql_vpc_id" {
  type = string
}

variable "postgresql_vswitch_id" {
  type = string
}

variable "postgresql_availability_zones" {
  type        = list(string)
  description = "The availability zones the database should be part of. The provided postgresql_vswitch_id should be in one of the availablility zones."
}

variable "postgresql_allocated_storage" {
  type = string
}

variable "postgresql_version" {
  type = string
}

variable "postgresql_instance_type" {
  type = string
}

variable "postgresql_firewall_rule_ingress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks allowed to access all databases of an instance. The list contains up to 1,000 blocks"
}

variable "postgresql_backup_retention_period" {
  type    = number
  default = 35
}

variable "postgresql_backup_period" {
  type    = list(string)
  default = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
}

variable "postgresql_backup_time" {
  type        = string
  default     = "02:00Z-03:00Z"
  description = "DB instance backup time, in the format of HH:mmZ- HH:mmZ. Time setting interval is one hour."
}

variable "postgresql_username" {
  type = string
}

variable "postgresql_password" {
  type = string
}
