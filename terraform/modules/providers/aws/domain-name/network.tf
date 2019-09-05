# Route53
resource "aws_route53_record" "main" {
  count   = var.domain_name_alias == "" ? 1 : 0
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = "300"
  records = var.domain_name_ip_addresses
}

resource "aws_route53_record" "main_cnames" {
  zone_id = data.aws_route53_zone.main.zone_id
  count   = var.domain_name_alias == "" ? length(var.domain_name_cnames) : 0
  name    = element(var.domain_name_cnames, count.index)
  type    = "CNAME"
  ttl     = "300"
  records = [aws_route53_record.main[0].name]
}

resource "aws_route53_record" "alias" {
  count   = var.domain_name_alias == "" ? 0 : 1
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.domain_name_alias
    zone_id                = var.domain_name_alias_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "alias_cnames" {
  zone_id = data.aws_route53_zone.main.zone_id
  count   = var.domain_name_alias == "" ? 0 : length(var.domain_name_cnames)
  name    = element(var.domain_name_cnames, count.index)
  type    = "CNAME"
  ttl     = "300"
  records = [aws_route53_record.alias[0].name]
}

