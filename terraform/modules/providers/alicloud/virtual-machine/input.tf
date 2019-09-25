data "alicloud_vswitches" "vpc_vswitches" {
  count   = length(var.vm_availability_zones)
  vpc_id  = var.vm_vpc_id
  zone_id = var.vm_availability_zones[count.index]
}