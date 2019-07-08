resource "aws_security_group" "ingress_rules" {
  count       = "${length(var.firewall_ingress_rules)}"
  name        = "${var.firewall_name}-${lookup(var.firewall_ingress_rules[count.index], "name")}"
  description = "${lookup(var.firewall_ingress_rules[count.index], "description")}"
  vpc_id      = "${var.firewall_vpc_id}"

  ingress {
    from_port   = "${lookup(var.firewall_ingress_rules[count.index], "from_port")}"
    to_port     = "${lookup(var.firewall_ingress_rules[count.index], "to_port")}"
    protocol    = "${lookup(var.firewall_ingress_rules[count.index], "protocol")}"
    cidr_blocks = "${split(",", lookup(var.firewall_ingress_rules[count.index], "cidr_blocks"))}"
  }

  tags = {
    Name            = "${var.firewall_name}-${lookup(var.firewall_ingress_rules[count.index], "name")}"
    OwnerList       = "${var.firewall_owner}"
    EnvironmentList = "${var.firewall_env}"
    EndDate         = "${var.firewall_end_date}"
    ProjectList     = "${var.firewall_project}"
  }
}

resource "aws_security_group" "egress_rules" {
  count       = "${length(var.firewall_egress_rules)}"
  name        = "${var.firewall_name}-${lookup(var.firewall_egress_rules[count.index], "name")}"
  description = "${lookup(var.firewall_egress_rules[count.index], "description")}"
  vpc_id      = "${var.firewall_vpc_id}"

  egress {
    from_port   = "${lookup(var.firewall_egress_rules[count.index], "from_port")}"
    to_port     = "${lookup(var.firewall_egress_rules[count.index], "to_port")}"
    protocol    = "${lookup(var.firewall_egress_rules[count.index], "protocol")}"
    cidr_blocks = "${split(",", lookup(var.firewall_egress_rules[count.index], "cidr_blocks"))}"
  }

  tags = {
    Name            = "${var.firewall_name}-${lookup(var.firewall_egress_rules[count.index], "name")}"
    OwnerList       = "${var.firewall_owner}"
    EnvironmentList = "${var.firewall_env}"
    EndDate         = "${var.firewall_end_date}"
    ProjectList     = "${var.firewall_project}"
  }
}
