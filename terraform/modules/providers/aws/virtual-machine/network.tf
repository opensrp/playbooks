# Security Groups

module "domain-name" {
  source           = "${var.vm_dns_module}"
  count            = "${length(var.vm_instances)}"
  dns_zone_name    = "${var.vm_dns_zone_name}"
  dns_names        = "${lookup(var.vm_instances[count.index], "domain_names")}"
  dns_ip_addresses = ["${element(aws_instance.main.*.public_ip, count.index)}"]
}

module "firewall" {
  source                 = "${var.vm_firewall_module}"
  count                  = "${length(var.vm_firewall)}"
  firewall_name          = "${lookup(var.vm_firewall[count.index], "name")}"
  firewall_description   = "${lookup(var.vm_firewall[count.index], "description")}"
  firewall_vpc_id        = "${var.vm_vpc_id}"
  firewall_ingress_rules = "${lookup(var.vm_firewall[count.index], "ingress_rules")}"
  firewall_egress_rules  = "${lookup(var.vm_firewall[count.index], "egress_rules")}"
  firewall_owner         = "${var.vm_owner}"
  firewall_env           = "${var.vm_env}"
  firewall_end_date      = "${var.vm_end_date}"
  firewall_project       = "${var.vm_project}"
}
