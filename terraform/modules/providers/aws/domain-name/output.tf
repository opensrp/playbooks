output "domain_name" {
  value = "${join("", concat(aws_route53_record.main.*.name, aws_route53_record.alias.*.name))}"
}

output "domain_name_cnames" {
  value = "${concat(aws_route53_record.main_cnames.*.name, aws_route53_record.alias_cnames.*.name)}"
}