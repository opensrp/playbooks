data "aws_route53_zone" "main" {
  name = var.tls_certificate_domain_zone_name
}

