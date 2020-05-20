resource "alicloud_slb" "main" {
  name                 = var.lb_name
  instance_charge_type = var.lb_instance_charge_type
  internet_charge_type = var.lb_internet_charge_type
  master_zone_id       = var.lb_availability_zones[0]
  slave_zone_id        = var.lb_availability_zones[1]
  address_type         = var.lb_address_type
  delete_protection    = var.lb_enable_delete_protection ? "on" : "off"
  specification        = var.lb_instance_type

  tags = {
    Name            = var.lb_name
    OwnerList       = var.lb_owner
    EnvironmentList = var.lb_env
    EndDate         = var.lb_end_date
    ProjectList     = var.lb_project
    DeploymentType  = var.lb_deployment_type
  }
}

resource "alicloud_slb_listener" "https" {
  load_balancer_id          = alicloud_slb.main.id
  backend_port              = var.lb_instance_port
  frontend_port             = var.lb_https_port
  bandwidth                 = var.lb_bandwidth
  protocol                  = "https"
  sticky_session            = var.lb_stickiness_enabled ? "on" : "off"
  sticky_session_type       = var.lb_stickiness_type
  cookie_timeout            = var.lb_stickiness_cookie_duration
  cookie                    = var.lb_stickiness_cookie_name
  health_check              = "on"
  health_check_uri          = var.lb_health_check_path
  health_check_connect_port = var.lb_instance_port
  healthy_threshold         = var.lb_health_check_healthy_threshold
  unhealthy_threshold       = var.lb_health_check_unhealthy_threshold
  health_check_timeout      = var.lb_health_check_timeout
  health_check_interval     = var.lb_health_check_interval
  health_check_http_code    = var.lb_health_check_healthy_status_code
  health_check_method       = var.lb_health_check_method
  idle_timeout              = var.lb_idle_timeout
  request_timeout           = var.lb_request_timeout
  tls_cipher_policy         = var.lb_ssl_policy
  server_certificate_id     = var.lb_ssl_certificate_id
  x_forwarded_for {
    retrive_slb_ip = true
    retrive_slb_id = true
  }
}

resource "alicloud_slb_listener" "http" {
  depends_on       = [alicloud_slb_listener.https]
  load_balancer_id = alicloud_slb.main.id
  frontend_port    = var.lb_http_port
  protocol         = "http"
  listener_forward = "on"
  forward_port     = var.lb_https_port
}

resource "alicloud_dns_record" "a" {
  name        = var.lb_domain_name
  host_record = var.lb_domain_name_host_record
  type        = "A"
  value       = alicloud_slb.main.address
}

resource "alicloud_dns_record" "cnames" {
  count       = length(var.lb_domain_name_cnames)
  name        = var.lb_domain_name_cnames[count.index]
  host_record = var.lb_domain_name_cnames_host_record
  type        = "CNAME"
  value       = var.lb_domain_name
}
