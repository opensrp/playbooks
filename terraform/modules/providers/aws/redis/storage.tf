data "aws_vpc" "selected" {
  id = "${var.redis_vpc_id}"
}

resource "aws_security_group" "security_group" {
  name   = "${var.stack_name}-${var.engine}-sg"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = "${var.port}"
    to_port     = "${var.port}"
    cidr_blocks = ["${slice(concat(var.ingress_cidrs, split("-", data.aws_vpc.selected.cidr_block)), 0, length(var.ingress_cidrs) + 1)}"]
  }
}

resource "aws_elasticache_subnet_group" "elasticache_subnet" {
  name        = "${var.stack_name}-subnet-group"
  subnet_ids  = ["${var.vpc_subnets}"]
  description = "Subnet Group for Elasticache ${var.stack_name} ${var.engine}"
}

resource "aws_elasticache_parameter_group" "parameter_group" {
  name   = "${var.stack_name}-${var.engine}-pg"
  family = "${var.engine}${element(split(".", var.engine_version), 0)}.${element(split(".", var.engine_version), 1)}"
}

resource "aws_elasticache_cluster" "elasticache" {
  cluster_id           = "${var.stack_name}-${var.engine}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  node_type            = "${var.node_type}"
  num_cache_nodes      = "${var.num_cache_nodes}"
  parameter_group_name = "${var.parameter_group_name}"
  security_group_ids   = "${var.security_group_ids}"
  port                 = "${var.port}"
  apply_immediately    = "true"

  tags {
    Name = "${var.stack_name}-${var.engine}"
  }
}

module "vm_firewall" {
  source                 = "../firewall"
  firewall_name = "${var.redis_name}"
  firewall_vpc_id        = "${var.redis_vpc_id}"
  firewall_ingress_rules = "${var.redis_firewall_ingress_rules}"
  firewall_egress_rules  = "${var.redis_firewall_egress_rules}"
  firewall_owner         = "${var.redis_owner}"
  firewall_env           = "${var.redis_env}"
  firewall_end_date      = "${var.redis_end_date}"
  firewall_project       = "${var.redis_project}"
}
