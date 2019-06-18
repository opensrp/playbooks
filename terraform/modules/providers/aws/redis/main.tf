data "aws_route53_zone" "main" {
  name = "${var.redis_domain_zone_name}"
}