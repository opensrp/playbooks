output "vpc_id" {
  value = alicloud_vpc.main.id
}

output "vpc_vswitch_ids" {
  value = alicloud_vswitch.vpc_vswitches.*.id
}