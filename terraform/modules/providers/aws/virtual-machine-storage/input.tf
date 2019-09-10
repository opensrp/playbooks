data "aws_instance" "instances" {
  count       = length(var.vms_vm_ids)
  instance_id = var.vms_vm_ids[count.index]
}