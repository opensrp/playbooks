module "nifi_vmdns" {
  source                      = "../virtual-machine-with-domain-names"
  vmdns_vm_ssh_key_name       = var.nifi_vm_ssh_key_name
  vmdns_firewall_rules        = [aws_security_group.nifi_firewall_rule.id]
  vmdns_owner                 = var.nifi_owner
  vmdns_env                   = var.nifi_env
  vmdns_end_date              = var.nifi_end_date
  vmdns_project               = var.nifi_project
  vmdns_name                  = var.nifi_vmdns_name
  vmdns_vpc_id                = data.aws_vpc.main.id
  vmdns_vm_availability_zones = var.nifi_availability_zones
  vmdns_vm_instances          = var.nifi_vmdns_vm_instances
  vmdns_domain_zone_name      = "${var.nifi_domain_zone_name}."
  vmdns_public_domain_names   = var.nifi_vmdns_public_domain_names
  vmdns_vm_user_data          = data.template_file.init.rendered
}
