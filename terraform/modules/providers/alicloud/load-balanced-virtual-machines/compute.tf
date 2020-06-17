module "vm" {
  source                = "../virtual-machine"
  vm_env                = var.lbvm_env
  vm_owner              = var.lbvm_owner
  vm_end_date           = var.lbvm_end_date
  vm_project            = var.lbvm_project
  vm_name               = var.lbvm_name
  vm_ssh_key_name       = var.lbvm_ssh_key_name
  vm_vpc_id             = var.lbvm_vpc_id
  vm_availability_zones = var.lbvm_availability_zones
  vm_firewall_rules     = var.lbvm_vm_firewall_rules
  vm_instances          = var.lbvm_vm_instances
}
