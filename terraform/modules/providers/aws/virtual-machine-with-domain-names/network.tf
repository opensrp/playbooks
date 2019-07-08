resource "aws_route53_record" "private_domain_name" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  count   = "${length(var.vmdns_private_domain_names)}"
  name    = "${element(var.vmdns_private_domain_names, count.index)}"
  type    = "A"
  ttl     = "300"
  records = "${module.vm.vm_private_ips}"
}

resource "aws_route53_record" "public_domain_name" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  count   = "${length(var.vmdns_public_domain_names)}"
  name    = "${element(var.vmdns_public_domain_names, count.index)}"
  type    = "A"
  ttl     = "300"
  records = "${module.vm.vm_public_ips}"
}