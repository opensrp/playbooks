output "vm_ids" {
  value = "${aws_instance.main.*.id}"
}

output "vm_private_ips" {
  value = "${aws_instance.main.*.private_ip}"
}

output "vm_public_ips" {
  value = "${aws_instance.main.*.public_ip}"
}
