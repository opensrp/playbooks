module "firewall" {
  source                 = "../firewall"
  firewall_name          = "${var.postgresql_name}"
  firewall_vpc_id        = "${var.postgresql_vpc_id}"
  firewall_ingress_rules = "${var.postgresql_firewall_ingress_rules}"
  firewall_egress_rules  = "${var.postgresql_firewall_egress_rules}"
  firewall_owner         = "${var.postgresql_owner}"
  firewall_env           = "${var.postgresql_env}"
  firewall_end_date      = "${var.postgresql_end_date}"
  firewall_project       = "${var.postgresql_project}"
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.postgresql_name}"
  subnet_ids = "${var.postgresql_subnet_ids}"

  tags = {
    Name            = "${var.postgresql_name}"
    OwnerList       = "${var.postgresql_owner}"
    EnvironmentList = "${var.postgresql_env}"
    ProjectList     = "${var.postgresql_project}"
    EndDate         = "${var.postgresql_end_date}"
  }
}

resource "aws_route53_record" "main" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  count   = "${length(var.postgresql_domain_names)}"
  name    = "${element(var.postgresql_domain_names, count.index)}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_db_instance.main.address}"]
}
