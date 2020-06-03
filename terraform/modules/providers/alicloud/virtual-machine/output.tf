output "vm_ids" {
  value = alicloud_instance.main.*.id
}

output "vm_public_ips" {
  value = alicloud_instance.main.*.public_ip
}

output "vm_private_ips" {
  value = alicloud_instance.main.*.private_ip
}