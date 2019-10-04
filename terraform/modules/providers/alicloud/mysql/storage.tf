resource "alicloud_db_instance" "main" {
  engine               = "MySQL"
  engine_version       = var.mysql_version
  instance_type        = var.mysql_instance_type
  instance_storage     = var.mysql_allocated_storage
  instance_charge_type = "Postpaid"
  instance_name        = var.mysql_name
  vswitch_id           = var.mysql_vswitch_id
  zone_id              = "${join(",", var.mysql_availability_zones)}"
  security_ips         = var.mysql_firewall_rule_ingress_cidr_blocks
  tags = {
    Name            = var.mysql_name
    OwnerList       = var.mysql_owner
    EnvironmentList = var.mysql_env
    ProjectList     = var.mysql_project
    EndDate         = var.mysql_end_date
  }
}

resource "alicloud_db_backup_policy" "main" {
  instance_id      = alicloud_db_instance.main.id
  retention_period = var.mysql_backup_retention_period
  backup_period    = var.mysql_backup_period
  backup_time      = var.mysql_backup_time
}

resource "alicloud_db_account" "main" {
  instance_id = alicloud_db_instance.main.id
  name        = var.mysql_username
  password    = var.mysql_password
  type        = "Super"
}
