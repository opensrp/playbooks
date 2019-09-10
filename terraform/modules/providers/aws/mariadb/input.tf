data "aws_route53_zone" "main" {
  name = var.mariadb_domain_zone_name
}

