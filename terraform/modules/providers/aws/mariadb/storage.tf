resource "aws_db_instance" "main" {
  identifier                = "${var.mariadb_name}"
  allocated_storage         = "${var.mariadb_allocated_storage}"
  storage_type              = "${var.mariadb_storage_type}"
  engine                    = "mariadb"
  engine_version            = "${var.mariadb_version}"
  instance_class            = "${var.mariadb_instance_class}"
  name                      = "${var.mariadb_db_name}"
  username                  = "${var.mariadb_username}"
  password                  = "${var.mariadb_password}"
  parameter_group_name      = "${aws_db_parameter_group.main.name}"
  db_subnet_group_name      = "${aws_db_subnet_group.main.name}"
  deletion_protection       = "${var.mariadb_deletion_protection}"
  multi_az                  = "${var.mariadb_multi_az}"
  port                      = "${var.mariadb_port}"
  copy_tags_to_snapshot     = "${var.mariadb_copy_tags_to_snapshot}"
  storage_encrypted         = true
  kms_key_id                = "${aws_kms_key.main.arn}"
  vpc_security_group_ids    = ["${aws_security_group.firewall_rule.id}"]
  final_snapshot_identifier = "${var.mariadb_name}"
  backup_retention_period   = "${var.mariadb_backup_retention_period}"
  backup_window             = "${var.mariadb_backup_window}"
  tags = {
    Name            = "${var.mariadb_name}"
    OwnerList       = "${var.mariadb_owner}"
    EnvironmentList = "${var.mariadb_env}"
    ProjectList     = "${var.mariadb_project}"
    EndDate         = "${var.mariadb_end_date}"
  }
}

resource "aws_db_parameter_group" "main" {
  name   = "${var.mariadb_name}"
  family = "mariadb${element(split(".", var.mariadb_version), 0)}.${element(split(".", var.mariadb_version), 1)}"

  parameter {
    name  = "log_bin_trust_function_creators"
    value = 1
  }

  tags = {
    Name            = "${var.mariadb_name}"
    OwnerList       = "${var.mariadb_owner}"
    EnvironmentList = "${var.mariadb_env}"
    ProjectList     = "${var.mariadb_project}"
    EndDate         = "${var.mariadb_end_date}"
  }
}

resource "aws_kms_key" "main" {
  description = "MariaDB at rest encryption key for ${var.mariadb_name}"
  tags = {
    Name            = "${var.mariadb_name}"
    OwnerList       = "${var.mariadb_owner}"
    EnvironmentList = "${var.mariadb_env}"
    ProjectList     = "${var.mariadb_project}"
    EndDate         = "${var.mariadb_end_date}"
  }
}

