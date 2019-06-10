resource "aws_security_group" "main" {
  name        = "${var.firewall_name}"
  description = "${var.firewall_description}"
  vpc_id      = "${var.firewall_vpc_id}"

  ingress {
    count       = "${length(var.firewall_ingress_rules)}"
    from_port   = "${lookup(var.firewall_ingress_rules[count.index], "from_port")}"
    to_port     = "${lookup(var.firewall_ingress_rules[count.index], "to_port")}"
    protocol    = "${lookup(var.firewall_ingress_rules[count.index], "protocol")}"
    cidr_blocks = "${lookup(var.firewall_ingress_rules[count.index], "cidr_blocks")}"
  }

  egress {
    count       = "${length(var.firewall_egress_rules)}"
    from_port   = "${lookup(var.firewall_egress_rules[count.index], "from_port")}"
    to_port     = "${lookup(var.firewall_egress_rules[count.index], "to_port")}"
    protocol    = "${lookup(var.firewall_egress_rules[count.index], "protocol")}"
    cidr_blocks = "${lookup(var.firewall_egress_rules[count.index], "cidr_blocks")}"
  }

  tags {
    Name            = "${var.firewall_name}"
    OwnerList       = "${var.firewall_owner}"
    EnvironmentList = "${var.firewall_env}"
    EndDate         = "${var.firewall_end_date}"
    ProjectList     = "${var.firewall_project}"
  }
}
