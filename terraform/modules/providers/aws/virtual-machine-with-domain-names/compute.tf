module "vm" {
  source                = "../virtual-machine"
  vm_env                = var.vmdns_env
  vm_owner              = var.vmdns_owner
  vm_end_date           = var.vmdns_end_date
  vm_project            = var.vmdns_project
  vm_name               = var.vmdns_name
  vm_vpc_id             = var.vmdns_vpc_id
  vm_ssh_key_name       = var.vmdns_vm_ssh_key_name
  vm_availability_zones = var.vmdns_vm_availability_zones
  vm_firewall_rules     = var.vmdns_firewall_rules
  vm_instances          = var.vmdns_vm_instances
}

