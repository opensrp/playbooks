terraform {
  backend "s3" {
    bucket = "[An AWS S# bucket for storing the Terraform state]"
    key    = "[path/to/state.tf for this setup]"
    region = "[Region where the bucket is e.g. ap-southeast-1]"
  }
}

provider "aws" {
  region = var.region
}

module "uptimerobot_monitor" {
  source               = "../../../../modules/providers/uptimerobot/monitor"
  uptimerobot_monitors = var.uptimerobot_monitors
}

resource "aws_security_group" "webserver_firewall_rule" {
  name        = var.webserver_firewall_rule_name
  description = var.webserver_firewall_rule_description
  vpc_id      = var.vpc_id

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
    Name            = var.webserver_firewall_rule_name
    OwnerList       = var.owner
    EnvironmentList = var.env
    EndDate         = var.end_date
    ProjectList     = var.project
  }
}

resource "aws_security_group" "ssh_firewall_rule" {
  name        = var.ssh_firewall_rule_name
  description = var.ssh_firewall_rule_description
  vpc_id      = var.vpc_id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = var.ssh_firewall_rule_ingress_cidr_blocks
  }

  ingress {
    from_port   = "60000"
    to_port     = "61000"
    protocol    = "udp"
    cidr_blocks = var.ssh_firewall_rule_ingress_cidr_blocks
  }

  tags = {
    Name            = var.ssh_firewall_rule_name
    OwnerList       = var.owner
    EnvironmentList = var.env
    EndDate         = var.end_date
    ProjectList     = var.project
  }
}

data "template_file" "init-script" {
  count    = length(var.vmdns_vm_instances)
  template = file("${path.module}/init.sh.tpl")

  vars = {
    action            = element(var.vmdns_vm_instances, count.index).init_action
    admin_password    = element(var.vmdns_vm_instances, count.index).admin_password
    admin_user        = element(var.vmdns_vm_instances, count.index).admin_user
    reveal_web_domain = element(var.vmdns_vm_instances, count.index).reveal_web_domain
    superset_domain   = element(var.vmdns_vm_instances, count.index).superset_domain
    app_email         = element(var.vmdns_vm_instances, count.index).certbot_email
    deployment        = "vm"
    env               = var.env
    group             = "superset-${var.project}-${var.env}"
    owner             = var.owner
    region            = var.region
    superset_version  = element(var.vmdns_vm_instances, count.index).software_version
  }
}

data "template_cloudinit_config" "init-script" {
  count         = length(var.vmdns_vm_instances)
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"

    content = element(data.template_file.init-script, count.index).rendered
  }
}

module "webserver_vmdns" {
  source                      = "../../../../modules/providers/aws/virtual-machine-with-domain-names"
  vmdns_vm_ssh_key_name       = var.vm_ssh_key_name
  vmdns_firewall_rules        = [aws_security_group.ssh_firewall_rule.id, aws_security_group.webserver_firewall_rule.id]
  vmdns_owner                 = var.owner
  vmdns_env                   = var.env
  vmdns_end_date              = var.end_date
  vmdns_project               = var.project
  vmdns_name                  = var.vmdns_name
  vmdns_vpc_id                = var.vpc_id
  vmdns_vm_availability_zones = var.availability_zones
  vmdns_vm_instances          = var.vmdns_vm_instances
  vmdns_domain_zone_name      = var.domain_zone_name
  vmdns_public_domain_names   = var.vmdns_public_domain_names
  vmdns_vm_user_data          = data.template_cloudinit_config.init-script.0.rendered
}
