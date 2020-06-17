resource "alicloud_dns_record" "private_domain_name" {
  count       = length(var.vm_private_domain_names)
  name        = element(var.vm_private_domain_names, count.index)
  type        = "A"
  host_record = var.vm_private_domain_names_host_record
  value       = join("\n", alicloud_instance.main.*.private_ip)
}

resource "alicloud_dns_record" "public_domain_name" {
  count       = length(var.vm_public_domain_names)
  name        = element(var.vm_public_domain_names, count.index)
  type        = "A"
  host_record = var.vm_public_domain_names_host_record
  value       = join("\n", alicloud_instance.main.*.public_ip)
}