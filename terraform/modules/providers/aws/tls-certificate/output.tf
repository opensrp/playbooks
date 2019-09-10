output "certificate_id" {
  value = aws_acm_certificate_validation.main.certificate_arn
}

