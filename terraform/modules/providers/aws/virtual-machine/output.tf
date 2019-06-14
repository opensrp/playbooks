output "vm_ids" {
  value = "${aws_instance.main.*.id}"
}