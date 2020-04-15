resource "alicloud_instance" "main" {
  count                         = length(var.vm_instances)
  security_groups               = var.vm_firewall_rules
  instance_type                 = var.vm_instances[count.index]["instance_type"]
  system_disk_category          = var.vm_instances[count.index]["volume_type"]
  image_id                      = var.vm_instances[count.index]["parent_image"]
  system_disk_size              = var.vm_instances[count.index]["volume_size"]
  instance_name                 = "${var.vm_name}-${count.index}"
  internet_max_bandwidth_out    = var.vm_internet_max_bandwidth_out
  instance_charge_type          = "PostPaid"
  key_name                      = var.vm_ssh_key_name
  security_enhancement_strategy = var.vm_security_enhancement_strategy
  availability_zone = element(
    data.alicloud_vswitches.vpc_vswitches.*.vswitches,
    count.index % length(data.alicloud_vswitches.vpc_vswitches),
  )[0].zone_id
  vswitch_id = element(
    data.alicloud_vswitches.vpc_vswitches.*.vswitches,
    count.index % length(data.alicloud_vswitches.vpc_vswitches),
  )[0].id

  tags = {
    Name            = "${var.vm_name}-${count.index}"
    Group           = var.vm_instances[count.index]["group"]
    OwnerList       = var.vm_owner
    EnvironmentList = var.vm_env
    EndDate         = var.vm_end_date
    ProjectList     = var.vm_project
    DeploymentType  = var.vm_deployment_type
  }

  volume_tags = {
    Name            = "${var.vm_name}-${count.index}"
    Group           = var.vm_instances[count.index]["group"]
    OwnerList       = var.vm_owner
    EnvironmentList = var.vm_env
    EndDate         = var.vm_end_date
    ProjectList     = var.vm_project
    DeploymentType  = var.vm_deployment_type
  }
}