data "aws_route53_zone" "main" {
  name = "${var.vmdns_domain_zone_name}"
}