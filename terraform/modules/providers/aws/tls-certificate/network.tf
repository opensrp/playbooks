resource "aws_acm_certificate" "main" {
  domain_name               = "${var.tls_certificate_domain_name}.${var.tls_certificate_domain_zone_name}"
  validation_method         = "DNS"
  subject_alternative_names = "${var.tls_certificate_domain_name_cnames}"

  tags = {
    Name            = "${var.tls_certificate_name}"
    OwnerList       = "${var.tls_certificate_owner}"
    EnvironmentList = "${var.tls_certificate_env}"
    EndDate         = "${var.tls_certificate_end_date}"
    ProjectList     = "${var.tls_certificate_project}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count      = "${length(var.tls_certificate_domain_name_cnames) + 1}"
  depends_on = ["aws_acm_certificate.main"]
  name       = "${lookup(aws_acm_certificate.main.domain_validation_options[count.index], "resource_record_name")}"
  type       = "${lookup(aws_acm_certificate.main.domain_validation_options[count.index], "resource_record_type")}"
  zone_id    = "${data.aws_route53_zone.main.id}"
  records    = ["${lookup(aws_acm_certificate.main.domain_validation_options[count.index], "resource_record_value")}"]
  ttl        = 60
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = "${aws_acm_certificate.main.arn}"
  validation_record_fqdns = "${aws_route53_record.cert_validation.*.fqdn}"

  timeouts {
    create = "1h"
  }
}