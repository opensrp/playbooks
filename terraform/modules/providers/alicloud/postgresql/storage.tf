resource "alicloud_db_instance" "main" {
  engine               = "PostgreSQL"
  engine_version       = var.postgresql_version
  instance_type        = var.postgresql_instance_type
  instance_storage     = var.postgresql_allocated_storage
  instance_charge_type = "Postpaid"
  instance_name        = var.postgresql_name
  vswitch_id           = var.postgresql_vswitch_id
  zone_id              = "${join(",", var.postgresql_availability_zones)}"
  security_ips         = var.postgresql_firewall_rule_ingress_cidr_blocks
  tags = {
    Name            = var.postgresql_name
    OwnerList       = var.postgresql_owner
    EnvironmentList = var.postgresql_env
    ProjectList     = var.postgresql_project
    EndDate         = var.postgresql_end_date
  }
}

resource "alicloud_db_backup_policy" "main" {
  instance_id      = alicloud_db_instance.main.id
  retention_period = var.postgresql_backup_retention_period
  backup_period    = var.postgresql_backup_period
  backup_time      = var.postgresql_backup_time
}

resource "alicloud_db_account" "main" {
  instance_id = alicloud_db_instance.main.id
  name        = var.postgresql_username
  password    = var.postgresql_password
  type        = "Super"
}
