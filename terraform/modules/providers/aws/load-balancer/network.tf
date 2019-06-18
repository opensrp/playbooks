data "aws_iam_policy_document" "logs-policy-document" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = "${var.lb_logs_user_identifiers}"
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${var.lb_logs_object_storage_bucket_name}/AWSLogs/*",
    ]
  }
}

resource "aws_alb" "main" {
  name                       = "${var.lb_name}"
  internal                   = false
  security_groups            = "${module.lb_firewall.firewall_rules}"
  subnets                    = "${var.lb_subnets}"
  enable_deletion_protection = "${var.lb_enable_delete_protection}"
  idle_timeout               = "${var.lb_idle_timeout}"

  access_logs {
    bucket = "${var.lb_logs_object_storage_bucket_name}"
  }

  tags = {
    OwnerList       = "${var.lb_owner}"
    EnvironmentList = "${var.lb_env}"
    EndDate         = "${var.lb_end_date}"
    ProjectList     = "${var.lb_project}"
  }
}

# HTTP
resource "aws_alb_target_group" "http" {
  name     = "${var.lb_name}-http"
  port     = "${var.lb_http_port}"
  protocol = "HTTP"
  vpc_id   = "${var.lb_vpc_id}"

  health_check {
    healthy_threshold   = "${var.lb_health_check_healthy_threshold}"
    path                = "${var.lb_health_check_path}"
    timeout             = "${var.lb_health_check_timeout}"
    unhealthy_threshold = "${var.lb_health_check_unhealthy_threshold}"
    matcher             = "${var.lb_health_check_healthy_status_code}"
  }

  tags = {
    OwnerList       = "${var.lb_owner}"
    EnvironmentList = "${var.lb_env}"
    EndDate         = "${var.lb_end_date}"
    ProjectList     = "${var.lb_project}"
  }
}

resource "aws_alb_target_group_attachment" "http" {
  count            = "${length(var.lb_instance_ids)}"
  target_group_arn = "${aws_alb_target_group.http.arn}"
  target_id        = "${element(var.lb_instance_ids, count.index)}"
  port             = "${var.lb_instance_port}"
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"
  depends_on        = ["aws_alb.main"]

  default_action {
    target_group_arn = "${aws_alb_target_group.http.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "http" {
  count        = "${length(var.lb_listener_rules)}"
  listener_arn = "${aws_alb_listener.http.arn}"
  priority     = "${lookup(element(var.lb_listener_rules, count.index), "priority")}"

  action {
    type             = "${lookup(element(var.lb_listener_rules, count.index), "action_type")}"
    target_group_arn = "${aws_alb_target_group.http.arn}"
  }

  condition {
    field  = "${lookup(element(var.lb_listener_rules, count.index), "condition_field")}"
    values = "${split(",", lookup(element(var.lb_listener_rules, count.index), "condition_field"))}"
  }
}

# HTTPS
resource "aws_alb_target_group" "https" {
  name     = "${var.lb_name}-https"
  port     = "${var.lb_https_port}"
  protocol = "${var.lb_instance_protocol}"
  vpc_id   = "${var.lb_vpc_id}"

  health_check {
    healthy_threshold   = "${var.lb_health_check_healthy_threshold}"
    path                = "${var.lb_health_check_path}"
    timeout             = "${var.lb_health_check_timeout}"
    unhealthy_threshold = "${var.lb_health_check_unhealthy_threshold}"
    matcher             = "${var.lb_health_check_healthy_status_code}"
  }

  tags = {
    OwnerList       = "${var.lb_owner}"
    EnvironmentList = "${var.lb_env}"
    EndDate         = "${var.lb_end_date}"
    ProjectList     = "${var.lb_project}"
  }
}

resource "aws_alb_target_group_attachment" "https" {
  count            = "${length(var.lb_instance_ids)}"
  target_group_arn = "${aws_alb_target_group.https.arn}"
  target_id        = "${element(var.lb_instance_ids, count.index)}"
  port             = "${var.lb_instance_port}"
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "${var.lb_ssl_policy}"
  certificate_arn   = "${module.tls_certificate.certificate_id}"
  depends_on        = ["aws_alb.main"]

  default_action {
    target_group_arn = "${aws_alb_target_group.https.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "https" {
  count        = "${length(var.lb_listener_rules)}"
  listener_arn = "${aws_alb_listener.https.arn}"
  priority     = "${lookup(element(var.lb_listener_rules, count.index), "priority")}"

  action {
    type             = "${lookup(element(var.lb_listener_rules, count.index), "action_type")}"
    target_group_arn = "${aws_alb_target_group.https.arn}"
  }

  condition {
    field  = "${lookup(element(var.lb_listener_rules, count.index), "condition_field")}"
    values = "${split(",", lookup(element(var.lb_listener_rules, count.index), "condition_field"))}"
  }
}

module "domain_name" {
  source                    = "../domain-name"
  domain_zone_name          = "${var.lb_domain_zone_name}"
  domain_name               = "${var.lb_domain_name}"
  domain_name_cnames        = "${var.lb_domain_name_cnames}"
  domain_name_alias         = "${aws_alb.main.dns_name}"
  domain_name_alias_zone_id = "${aws_alb.main.zone_id}"
}

module "tls_certificate" {
  source                             = "../tls-certificate"
  tls_certificate_name               = "${var.lb_name}"
  tls_certificate_env                = "${var.lb_env}"
  tls_certificate_owner              = "${var.lb_owner}"
  tls_certificate_project            = "${var.lb_project}"
  tls_certificate_end_date           = "${var.lb_end_date}"
  tls_certificate_domain_name        = "${var.lb_domain_name}"
  tls_certificate_domain_name_cnames = "${var.lb_domain_name_cnames}"
  tls_certificate_domain_zone_name   = "${var.lb_domain_zone_name}"
}

module "lb_firewall" {
  source                 = "../firewall"
  firewall_name          = "${var.lb_name}"
  firewall_vpc_id        = "${var.lb_vpc_id}"
  firewall_ingress_rules = "${var.lb_firewall_ingress_rules}"
  firewall_egress_rules  = "${var.lb_firewall_egress_rules}"
  firewall_owner         = "${var.lb_owner}"
  firewall_env           = "${var.lb_env}"
  firewall_end_date      = "${var.lb_end_date}"
  firewall_project       = "${var.lb_project}"
}
