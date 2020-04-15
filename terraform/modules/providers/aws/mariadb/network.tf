resource "aws_security_group" "firewall_rule" {
  name        = var.mariadb_name
  description = "Access to the ${var.mariadb_name} database"
  vpc_id      = var.mariadb_vpc_id

  ingress {
    from_port   = var.mariadb_port
    to_port     = var.mariadb_port
    protocol    = "tcp"
    cidr_blocks = var.mariadb_firewall_rule_ingress_cidr_blocks
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name            = var.mariadb_name
    OwnerList       = var.mariadb_owner
    EnvironmentList = var.mariadb_env
    EndDate         = var.mariadb_end_date
    ProjectList     = var.mariadb_project
    DeploymentType  = var.mariadb_deployment_type
  }
}

resource "aws_db_subnet_group" "main" {
  name       = var.mariadb_name
  subnet_ids = var.mariadb_subnet_ids

  tags = {
    Name            = var.mariadb_name
    OwnerList       = var.mariadb_owner
    EnvironmentList = var.mariadb_env
    ProjectList     = var.mariadb_project
    DeploymentType  = var.mariadb_deployment_type
    EndDate         = var.mariadb_end_date
  }
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  count   = length(var.mariadb_domain_names)
  name    = element(var.mariadb_domain_names, count.index)
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.main.address]
}

