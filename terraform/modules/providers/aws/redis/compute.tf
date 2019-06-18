module "vm" {
  source                = "../virtual-machine"
  vm_env                = "${var.redis_env}"
  vm_owner              = "${var.redis_owner}"
  vm_end_date           = "${var.redis_end_date}"
  vm_project            = "${var.redis_project}"
  vm_name               = "${var.redis_name}"
  vm_ssh_key_name       = "${var.redis_vm_ssh_key_name}"
  vm_subnet_ids         = "${var.redis_vm_subnet_ids}"
  vm_availability_zones = "${var.redis_vm_availability_zones}"
  vm_firewall_rules     = "${module.firewall.firewall_rules}"
  vm_instances          = "${var.redis_vm_instances}"
}
