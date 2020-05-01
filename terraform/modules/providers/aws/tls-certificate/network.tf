resource "aws_acm_certificate" "main" {
  domain_name               = length(var.tls_certificate_domain_name) > 0 ? "${var.tls_certificate_domain_name}.${var.tls_certificate_domain_zone_name}" : var.tls_certificate_domain_zone_name
  validation_method         = "DNS"
  subject_alternative_names = var.tls_certificate_domain_name_cnames

  tags = {
    Name            = var.tls_certificate_name
    OwnerList       = var.tls_certificate_owner
    EnvironmentList = var.tls_certificate_env
    EndDate         = var.tls_certificate_end_date
    ProjectList     = var.tls_certificate_project
    DeploymentType  = var.tls_certificate_deployment_type
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count      = length(var.tls_certificate_domain_name_cnames) + 1
  depends_on = [aws_acm_certificate.main]
  name       = aws_acm_certificate.main.domain_validation_options[count.index]["resource_record_name"]
  type       = aws_acm_certificate.main.domain_validation_options[count.index]["resource_record_type"]
  zone_id    = data.aws_route53_zone.main.id
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  records = [aws_acm_certificate.main.domain_validation_options[count.index]["resource_record_value"]]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn

  timeouts {
    create = "1h"
  }
}

