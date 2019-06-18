
module "firewall" {
  source                 = "../firewall"
  firewall_name          = "${var.redis_name}"
  firewall_vpc_id        = "${var.redis_vpc_id}"
  firewall_ingress_rules = "${var.redis_firewall_ingress_rules}"
  firewall_egress_rules  = "${var.redis_firewall_egress_rules}"
  firewall_owner         = "${var.redis_owner}"
  firewall_env           = "${var.redis_env}"
  firewall_end_date      = "${var.redis_end_date}"
  firewall_project       = "${var.redis_project}"
}

resource "aws_route53_record" "main" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  count   = "${length(var.redis_domain_names)}"
  name    = "${element(var.redis_domain_names, count.index)}"
  type    = "A"
  ttl     = "300"
  records = "${module.vm.vm_private_ips}"
}