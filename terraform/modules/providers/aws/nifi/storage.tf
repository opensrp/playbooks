module "nifi_content_repository_storage" {
  source                  = "../virtual-machine-storage"
  vms_owner               = var.nifi_owner
  vms_env                 = var.nifi_env
  vms_end_date            = var.nifi_end_date
  vms_project             = var.nifi_project
  vms_size                = var.nifi_content_repository_vms_size
  vms_name                = var.nifi_content_repository_vms_name
  vms_vm_ids              = module.nifi_vmdns.vm_ids
  vms_mount_point         = var.nifi_content_repository_vms_mount_point
  vms_console_device_name = var.nifi_content_repository_vms_console_device_name
  vms_host_device_name    = var.nifi_content_repository_vms_host_device_name
}

module "nifi_other_repositories_storage" {
  source                  = "../virtual-machine-storage"
  vms_owner               = var.nifi_owner
  vms_env                 = var.nifi_env
  vms_end_date            = var.nifi_end_date
  vms_project             = var.nifi_project
  vms_size                = var.nifi_other_repositories_vms_size
  vms_name                = var.nifi_other_repositories_vms_name
  vms_vm_ids              = module.nifi_vmdns.vm_ids
  vms_mount_point         = var.nifi_other_repositories_vms_mount_point
  vms_console_device_name = var.nifi_other_repositories_vms_console_device_name
  vms_host_device_name    = var.nifi_other_repositories_vms_host_device_name
}
