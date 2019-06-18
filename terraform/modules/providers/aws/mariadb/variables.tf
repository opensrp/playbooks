variable "mariadb_name" {}
variable "mariadb_db_name" {}
variable "mariadb_owner" {}
variable "mariadb_env" {}
variable "mariadb_end_date" {}
variable "mariadb_project" {}
variable "mariadb_version" {}
variable "mariadb_instance_class" {}
variable "mariadb_allocated_storage" {}
variable "mariadb_storage_type" {}
variable "mariadb_username" {}
variable "mariadb_password" {}
variable "mariadb_vpc_id" {}
variable "mariadb_firewall_ingress_rules" {}
variable "mariadb_firewall_egress_rules" {}
variable "mariadb_subnet_ids" {}
variable "mariadb_deletion_protection" {
  default = true
}
variable "mariadb_multi_az" {
  default = false
}
variable "mariadb_port" {
  default = 5432
}
variable "mariadb_copy_tags_to_snapshot" {
  default = true
}
variable "mariadb_domain_names" {
  type = "list"
}
variable "mariadb_domain_zone_name" {}
variable "mariadb_backup_retention_period" {
  default = 35
}
variable "mariadb_backup_window" {
  default = "03:30-5:00"
}