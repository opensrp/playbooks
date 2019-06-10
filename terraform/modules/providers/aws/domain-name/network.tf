# Route53
resource "aws_route53_record" "main" {
  count   = "${length(var.dns_names)}"
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${element(var.dns_names, count.index)}"
  type    = "A"
  ttl     = "300"
  records = ["${var.dns_ip_addresses}"]
}
