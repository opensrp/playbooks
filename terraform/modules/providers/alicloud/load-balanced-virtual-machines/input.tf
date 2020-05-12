data "alicloud_vpcs" "main" {
  ids = [var.lbvm_vpc_id]
}