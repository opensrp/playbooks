module "firewall" {
  source                 = "../firewall"
  firewall_name          = "${var.mariadb_name}"
  firewall_vpc_id        = "${var.mariadb_vpc_id}"
  firewall_ingress_rules = "${var.mariadb_firewall_ingress_rules}"
  firewall_egress_rules  = "${var.mariadb_firewall_egress_rules}"
  firewall_owner         = "${var.mariadb_owner}"
  firewall_env           = "${var.mariadb_env}"
  firewall_end_date      = "${var.mariadb_end_date}"
  firewall_project       = "${var.mariadb_project}"
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.mariadb_name}"
  subnet_ids = "${var.mariadb_subnet_ids}"

  tags = {
    Name            = "${var.mariadb_name}"
    OwnerList       = "${var.mariadb_owner}"
    EnvironmentList = "${var.mariadb_env}"
    ProjectList     = "${var.mariadb_project}"
    EndDate         = "${var.mariadb_end_date}"
  }
}

resource "aws_route53_record" "main" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  count   = "${length(var.mariadb_domain_names)}"
  name    = "${element(var.mariadb_domain_names, count.index)}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_db_instance.main.address}"]
}
