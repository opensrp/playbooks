resource "aws_security_group" "firewall_rule" {
  name        = var.postgresql_name
  description = "Access to the ${var.postgresql_name} database"
  vpc_id      = var.postgresql_vpc_id

  ingress {
    from_port   = var.postgresql_port
    to_port     = var.postgresql_port
    protocol    = "tcp"
    cidr_blocks = var.postgresql_firewall_rule_ingress_cidr_blocks
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
    Name            = var.postgresql_name
    OwnerList       = var.postgresql_owner
    EnvironmentList = var.postgresql_env
    EndDate         = var.postgresql_end_date
    ProjectList     = var.postgresql_project
  }
}

resource "aws_db_subnet_group" "main" {
  name       = var.postgresql_name
  subnet_ids = var.postgresql_subnet_ids

  tags = {
    Name            = var.postgresql_name
    OwnerList       = var.postgresql_owner
    EnvironmentList = var.postgresql_env
    ProjectList     = var.postgresql_project
    EndDate         = var.postgresql_end_date
  }
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  count   = length(var.postgresql_domain_names)
  name    = element(var.postgresql_domain_names, count.index)
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.main.address]
}

