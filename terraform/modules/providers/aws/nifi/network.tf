resource "aws_security_group" "nifi_firewall_rule" {
  name        = var.nifi_firewall_rule_name
  description = var.nifi_firewall_rule_description
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = var.nifi_firewall_rule_ssh_ingress_cidr_blocks
  }

  ingress {
    from_port   = "60000"
    to_port     = "61000"
    protocol    = "udp"
    cidr_blocks = var.nifi_firewall_rule_ssh_ingress_cidr_blocks
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name            = var.nifi_firewall_rule_name
    OwnerList       = var.nifi_owner
    EnvironmentList = var.nifi_env
    EndDate         = var.nifi_end_date
    ProjectList     = var.nifi_project
  }
}
