variable "mariadb_name" {
}

variable "mariadb_db_name" {
}

variable "mariadb_owner" {
}

variable "mariadb_env" {
}

variable "mariadb_end_date" {
}

variable "mariadb_project" {
}

variable "mariadb_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}

variable "mariadb_version" {
}

variable "mariadb_instance_class" {
}

variable "mariadb_allocated_storage" {
}

variable "mariadb_storage_type" {
}

variable "mariadb_username" {
}

variable "mariadb_password" {
}

variable "mariadb_vpc_id" {
}

variable "mariadb_firewall_rule_ingress_cidr_blocks" {
  type = list(string)
}

variable "mariadb_subnet_ids" {
}

variable "mariadb_deletion_protection" {
  default = true
}

variable "mariadb_multi_az" {
  default = false
}

variable "mariadb_port" {
  default = 3306
}

variable "mariadb_copy_tags_to_snapshot" {
  default = true
}

variable "mariadb_domain_names" {
  type = list(string)
}

variable "mariadb_domain_zone_name" {
}

variable "mariadb_backup_retention_period" {
  default = 35
}

variable "mariadb_backup_window" {
  default = "03:30-05:00"
}

