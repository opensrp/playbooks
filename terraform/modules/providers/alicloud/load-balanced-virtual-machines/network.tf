module "lb" {
  source                        = "../load-balancer"
  lb_env                        = var.lbvm_env
  lb_owner                      = var.lbvm_owner
  lb_end_date                   = var.lbvm_end_date
  lb_project                    = var.lbvm_project
  lb_name                       = var.lbvm_name
  lb_subnet                     = data.alicloud_vpcs.main.vpcs.0.cidr_block
  lb_instance_port              = var.lbvm_lb_instance_port
  lb_instance_protocol          = var.lbvm_lb_instance_protocol
  lb_health_check_path          = var.lbvm_lb_health_check_path
  lb_ssl_policy                 = var.lbvm_lb_ssl_policy
  lb_ssl_certificate_id         = var.lbvm_lb_ssl_certificate_id
  lb_idle_timeout               = var.lbvm_lb_idle_timeout
  lb_request_timeout            = var.lbvm_lb_request_timeout
  lb_stickiness_cookie_duration = var.lbvm_lb_stickiness_cookie_duration
  lb_stickiness_enabled         = var.lbvm_lb_stickiness_enabled
  lb_availability_zones         = var.lbvm_availability_zones
  lb_domain_name                = var.lbvm_lb_domain_name
  lb_domain_name_cnames         = var.lbvm_lb_domain_name_cnames
}

resource "alicloud_slb_attachment" "main" {
  load_balancer_id = module.lb.lb_id
  instance_ids     = module.vm.vm_ids
}
