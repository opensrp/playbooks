variable "postgresql_name" {}
variable "postgresql_db_name" {}
variable "postgresql_owner" {}
variable "postgresql_env" {}
variable "postgresql_end_date" {}
variable "postgresql_project" {}
variable "postgresql_version" {}
variable "postgresql_instance_class" {}
variable "postgresql_allocated_storage" {}
variable "postgresql_storage_type" {}
variable "postgresql_username" {}
variable "postgresql_password" {}
variable "postgresql_vpc_id" {}
variable "postgresql_firewall_rule_ingress_cidr_blocks" {}
variable "postgresql_subnet_ids" {}
variable "postgresql_deletion_protection" {
  default = true
}
variable "postgresql_multi_az" {
  default = false
}
variable "postgresql_port" {
  default = 5432
}
variable "postgresql_copy_tags_to_snapshot" {
  default = true
}
variable "postgresql_domain_names" {
  type = "list"
}
variable "postgresql_domain_zone_name" {}
variable "postgresql_backup_retention_period" {
  default = 35
}
variable "postgresql_backup_window" {
  default = "03:30-05:00"
}