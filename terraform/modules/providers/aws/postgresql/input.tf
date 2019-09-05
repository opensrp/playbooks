data "aws_route53_zone" "main" {
  name = var.postgresql_domain_zone_name
}

