data "aws_iam_policy_document" "logs-policy-document" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.lb_logs_user_identifiers
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
  name                       = var.lb_name
  internal                   = false
  security_groups            = [aws_security_group.firewall_rule.id]
  subnets                    = var.lb_subnets
  enable_deletion_protection = var.lb_enable_delete_protection
  idle_timeout               = var.lb_idle_timeout

  access_logs {
    bucket = var.lb_logs_object_storage_bucket_name
  }

  tags = {
    OwnerList       = var.lb_owner
    EnvironmentList = var.lb_env
    EndDate         = var.lb_end_date
    ProjectList     = var.lb_project
    DeploymentType  = var.lb_deployment_type
  }
}

# HTTP
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb.main]

  default_action {
    type = "redirect"
    redirect {
      status_code = "HTTP_301"
      protocol    = "HTTPS"
      port        = 443
    }
  }
}

# HTTPS
resource "aws_alb_target_group" "https" {
  name     = "${var.lb_name}-https"
  port     = var.lb_https_port
  protocol = var.lb_instance_protocol
  vpc_id   = var.lb_vpc_id

  health_check {
    healthy_threshold   = var.lb_health_check_healthy_threshold
    path                = var.lb_health_check_path
    timeout             = var.lb_health_check_timeout
    unhealthy_threshold = var.lb_health_check_unhealthy_threshold
    matcher             = var.lb_health_check_healthy_status_code
  }

  stickiness {
    type            = var.lb_stickiness_type
    cookie_duration = var.lb_stickiness_cookie_duration
    enabled         = var.lb_stickiness_enabled
  }

  tags = {
    OwnerList       = var.lb_owner
    EnvironmentList = var.lb_env
    EndDate         = var.lb_end_date
    ProjectList     = var.lb_project
    DeploymentType  = var.lb_deployment_type
  }
}

resource "aws_cloudwatch_metric_alarm" "https-unhealthy-hosts" {
  alarm_name                = "alb-${var.lb_name}-https-unhealthy-hosts"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.lb_alarm_unhealthy_hosts_evaluation_periods
  metric_name               = "UnHealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = var.lb_alarm_unhealthy_hosts_period
  statistic                 = "Average"
  threshold                 = floor(length(var.lb_instance_ids) * var.lb_alarm_unhealthy_hosts_threshold)
  alarm_actions             = var.lb_alarm_alarm_actions
  ok_actions                = var.lb_alarm_ok_actions
  insufficient_data_actions = var.lb_alarm_insufficient_data_actions

  dimensions = {
    LoadBalancer = aws_alb.main.arn_suffix
    TargetGroup  = aws_alb_target_group.https.arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "https-requests-5xx-count" {
  alarm_name                = "alb-${var.lb_name}-https-requests-5xx-count"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = var.lb_alarm_requests_5xx_count_evaluation_periods
  metric_name               = "HTTPCode_Target_5XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = var.lb_alarm_requests_5xx_count_period
  statistic                 = "Sum"
  threshold                 = var.lb_alarm_requests_5xx_threshold
  alarm_actions             = var.lb_alarm_alarm_actions
  ok_actions                = var.lb_alarm_ok_actions
  insufficient_data_actions = var.lb_alarm_insufficient_data_actions
  treat_missing_data        = "notBreaching"

  dimensions = {
    LoadBalancer = aws_alb.main.arn_suffix
    TargetGroup  = aws_alb_target_group.https.arn_suffix
  }
}

resource "aws_alb_target_group_attachment" "https" {
  count            = length(var.lb_instance_ids)
  target_group_arn = aws_alb_target_group.https.arn
  target_id        = element(var.lb_instance_ids, count.index)
  port             = var.lb_instance_port
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.lb_ssl_policy
  certificate_arn   = module.tls_certificate.certificate_id
  depends_on        = [aws_alb.main]

  default_action {
    target_group_arn = aws_alb_target_group.https.arn
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "https" {
  count        = length(var.lb_listener_rules)
  listener_arn = aws_alb_listener.https.arn
  priority     = element(var.lb_listener_rules, count.index)["priority"]

  action {
    type             = element(var.lb_listener_rules, count.index)["action_type"]
    target_group_arn = aws_alb_target_group.https.arn
  }

  condition {
    field = element(var.lb_listener_rules, count.index)["condition_field"]
    values = split(
      ",",
      element(var.lb_listener_rules, count.index)["condition_field"],
    )
  }
}

module "domain_name" {
  source                    = "../domain-name"
  domain_zone_name          = var.lb_domain_zone_name
  domain_name               = var.lb_domain_name
  domain_name_cnames        = var.lb_domain_name_cnames
  domain_name_alias         = aws_alb.main.dns_name
  domain_name_alias_zone_id = aws_alb.main.zone_id
}

module "tls_certificate" {
  source                             = "../tls-certificate"
  tls_certificate_name               = var.lb_name
  tls_certificate_env                = var.lb_env
  tls_certificate_owner              = var.lb_owner
  tls_certificate_project            = var.lb_project
  tls_certificate_end_date           = var.lb_end_date
  tls_certificate_domain_name        = var.lb_domain_name
  tls_certificate_domain_name_cnames = var.lb_domain_name_cnames
  tls_certificate_domain_zone_name   = var.lb_domain_zone_name
}

resource "aws_security_group" "firewall_rule" {
  name        = var.lb_name
  description = "Access to ${var.lb_name} load balancer"
  vpc_id      = var.lb_vpc_id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name            = var.lb_name
    OwnerList       = var.lb_owner
    EnvironmentList = var.lb_env
    EndDate         = var.lb_end_date
    ProjectList     = var.lb_project
    DeploymentType  = var.lb_deployment_type
  }
}

