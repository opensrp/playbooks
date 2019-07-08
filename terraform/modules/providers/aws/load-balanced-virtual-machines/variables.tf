variable "lbvm_env" {}
variable "lbvm_owner" {}
variable "lbvm_end_date" {}
variable "lbvm_project" {}
variable "lbvm_name" {}
variable "lbvm_ssh_key_name" {}
variable "lbvm_vpc_id" {}
variable "lbvm_subnet_ids" {
  type = "list"
}
variable "lbvm_availability_zones" {
  type = "list"
}
variable "lbvm_vm_firewall_rules" {
  type = "list"
}
variable "lbvm_vm_instances" {
  type = "list"
}
variable "lbvm_lb_instance_port" {
  default = 80
}
variable "lbvm_lb_instance_protocol" {
  default = "HTTP"
}
variable "lbvm_lb_health_check_path" {}
variable "lbvm_lb_listener_rules" {}
variable "lbvm_lb_ssl_policy" {
  default = "ELBSecurityPolicy-2016-08"
}
variable "lbvm_domain_zone_name" {}
variable "lbvm_domain_name" {}
variable "lbvm_domain_name_cnames" {}

variable "lbvm_lb_logs_object_storage_bucket_name" {}
