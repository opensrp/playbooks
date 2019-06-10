output "vpc_main_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_subnet_ids" {
  value = "${aws_subnet.vpc_subnets.*.id}"
}

output "vpc_arn" {
  value = "${aws_vpc.main.arn}"
}
