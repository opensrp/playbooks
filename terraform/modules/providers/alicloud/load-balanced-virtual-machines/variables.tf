variable "lbvm_env" {
  type        = string
  description = "The environment this load balancer is in. Possible values are 'staging', 'previw', 'production', and 'shared'."
}

variable "lbvm_owner" {
  type        = string
  description = "The ID of the owner/team that is responsible for the load balancer."
}

variable "lbvm_end_date" {
  type        = string
  description = "The end date for the provisioned resources."
}

variable "lbvm_project" {
  type        = string
  description = "The ID of the project that owns the load balancer."
}

variable "lbvm_deployment_type" {
  type        = string
  default     = "vm"
  description = "The type of deployment this load balancer is part of."
}

variable "lbvm_name" {
  type        = string
  description = "The name to give the load balanced virtual machine setup."
}

variable "lbvm_ssh_key_name" {
  type        = string
  description = "The SSH key to install in the VMs that are brought up."
}

variable "lbvm_vpc_id" {
  type        = string
  description = "The ID of the VPC to attach resources."
}

variable "lbvm_availability_zones" {
  type        = list(string)
  description = "At least two availability zones to place the ECS instances and load balancer."
}

variable "lbvm_vm_firewall_rules" {
  type        = list(string)
  description = "The firewall rules to attach to the virtual machines."
}

variable "lbvm_vm_instances" {
  type        = list(object({ group = string, parent_image = string, instance_type = string, volume_size = string, volume_type = string }))
  description = "List of VMs to create then attach to the load balancer."
}

variable "lbvm_lb_instance_port" {
  type        = number
  default     = 80
  description = "The port the load balancer should connect to the backend (load balanced application) using."
}

variable "lbvm_lb_idle_timeout" {
  type        = number
  default     = 60
  description = "Timeout for HTTP or HTTPS established but idle connections. Valid value range: [1-60] in seconds."
}

variable "lbvm_lb_request_timeout" {
  type        = number
  default     = 180
  description = "Timeout for HTTPS or HTTPS listener requests. Valid value range: [1-180] in seconds."
}

variable "lbvm_lb_instance_protocol" {
  type        = string
  default     = "http"
  description = "The protocol the load balancer's backend is listening on."
}

variable "lbvm_lb_health_check_path" {
  type        = string
  description = "The path in each of the servers behind the load balancer to hit to get a health check status."
}

variable "lbvm_lb_ssl_policy" {
  type        = string
  description = "HTTPS listener TLS cipher policy. Valid values are 'tls_cipher_policy_1_0', 'tls_cipher_policy_1_1', 'tls_cipher_policy_1_2', and 'tls_cipher_policy_1_2_strict'."
  default     = "tls_cipher_policy_1_2_strict"
}

variable "lbvm_lb_ssl_certificate_id" {
  type        = string
  description = "SLB Server certificate ID."
}

variable "lbvm_lb_stickiness_cookie_duration" {
  type        = number
  default     = 86400
  description = "Cookie timeout for the stickiness session. It is mandatory when lb_stickiness_enabled is true and lb_stickiness_type is 'insert'. Otherwise, it will be ignored. Valid value range: [1-86400] in seconds."
}

variable "lbvm_lb_stickiness_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable session stickiness on the load balancer."
}
