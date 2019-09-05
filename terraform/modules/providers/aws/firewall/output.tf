output "firewall_rules" {
  value = concat(
    aws_security_group.ingress_rules.*.id,
    aws_security_group.egress_rules.*.id,
  )
}

