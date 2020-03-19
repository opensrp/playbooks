resource "aws_security_group" "ingress_rules" {
  count       = length(var.firewall_ingress_rules)
  name        = "${var.firewall_name}-${var.firewall_ingress_rules[count.index]["name"]}"
  description = var.firewall_ingress_rules[count.index]["description"]
  vpc_id      = var.firewall_vpc_id

  ingress {
    from_port   = var.firewall_ingress_rules[count.index]["from_port"]
    to_port     = var.firewall_ingress_rules[count.index]["to_port"]
    protocol    = var.firewall_ingress_rules[count.index]["protocol"]
    cidr_blocks = split(",", var.firewall_ingress_rules[count.index]["cidr_blocks"])
  }

  tags = {
    Name            = "${var.firewall_name}-${var.firewall_ingress_rules[count.index]["name"]}"
    OwnerList       = var.firewall_owner
    EnvironmentList = var.firewall_env
    EndDate         = var.firewall_end_date
    ProjectList     = var.firewall_project
    DeploymentType  = var.firewall_deployment_type
  }
}

resource "aws_security_group" "egress_rules" {
  count       = length(var.firewall_egress_rules)
  name        = "${var.firewall_name}-${var.firewall_egress_rules[count.index]["name"]}"
  description = var.firewall_egress_rules[count.index]["description"]
  vpc_id      = var.firewall_vpc_id

  egress {
    from_port   = var.firewall_egress_rules[count.index]["from_port"]
    to_port     = var.firewall_egress_rules[count.index]["to_port"]
    protocol    = var.firewall_egress_rules[count.index]["protocol"]
    cidr_blocks = split(",", var.firewall_egress_rules[count.index]["cidr_blocks"])
  }

  tags = {
    Name            = "${var.firewall_name}-${var.firewall_egress_rules[count.index]["name"]}"
    OwnerList       = var.firewall_owner
    EnvironmentList = var.firewall_env
    EndDate         = var.firewall_end_date
    ProjectList     = var.firewall_project
    DeploymentType  = var.firewall_deployment_type
  }
}

