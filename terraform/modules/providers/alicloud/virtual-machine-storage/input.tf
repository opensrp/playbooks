data "alicloud_instances" "instances" {
  count = length(var.vms_vm_ids)
  ids   = [var.vms_vm_ids[count.index]]
}