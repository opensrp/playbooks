variable "lb_env" {
  type        = string
  description = "The environment this load balancer is in. Possible values are 'staging', 'previw', 'production', and 'shared'."
}

variable "lb_owner" {
  type        = string
  description = "The ID of the owner/team that is responsible for the load balancer."
}

variable "lb_project" {
  type        = string
  description = "The ID of the project that owns the load balancer."
}

variable "lb_subnet" {
  type        = string
  description = "The CIDR block that will have access to the load balancer."
}

variable "lb_deployment_type" {
  type        = string
  default     = "vm"
  description = "The type of deployment this load balancer is part of."
}

variable "lb_instance_charge_type" {
  type        = string
  default     = "PostPaid"
  description = "The billing method of the load balancer. Valid values are 'PrePaid' and 'PostPaid'."
}

variable "lb_internet_charge_type" {
  type        = string
  default     = "PayByTraffic"
  description = "TValid values are 'PayByBandwidth' and 'PayByTraffic'."
}

variable "lb_availability_zones" {
  type        = list(string)
  description = "List of at least two availability zones the load balancer should be put."
}

variable "lb_end_date" {
  type        = string
  description = "The last date for the load balancer."
}

variable "lb_name" {
  type        = string
  description = "The name to give the load balancer."
}

variable "lb_address_type" {
  type        = string
  default     = "internet"
  description = "The network type of the SLB instance. Valid values are 'internet' and 'intranet'. If load balancer launched in VPC, this value must be 'intranet'."
}

variable "lb_enable_delete_protection" {
  default     = false
  description = "Whether enable the deletion protection or not."
}

variable "lb_instance_type" {
  type        = string
  default     = "slb.s1.small"
  description = "The specification of the Server Load Balancer instance. valid values are: 'slb.s1.small', 'slb.s2.small', 'slb.s2.medium', 'slb.s3.small', 'slb.s3.medium', 'slb.s3.large', and 'slb.s4.large'."
}

variable "lb_http_port" {
  type        = number
  default     = 80
  description = "Which port the load balancer should listen for HTTP traffic."
}

variable "lb_https_port" {
  type        = number
  default     = 443
  description = "Which port the load balancer should listen for HTTPS traffic."
}

variable "lb_instance_port" {
  type        = number
  default     = 80
  description = "The port the load balancer should connect to the backend (load balanced application) using."
}

variable "lb_stickiness_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable session stickiness on the load balancer."
}

variable "lb_stickiness_type" {
  type        = string
  default     = "insert"
  description = "If lb_stickiness_enabled is true, it is mandatory. Otherwise, it will be ignored. Valid values are 'insert' and 'server'. 'insert' means it is inserted from Server Load Balancer. 'server' means the Server Load Balancer learns from the backend server."
}

variable "lb_stickiness_cookie_duration" {
  type        = number
  default     = 86400
  description = "Cookie timeout for the stickiness session. It is mandatory when lb_stickiness_enabled is true and lb_stickiness_type is 'insert'. Otherwise, it will be ignored. Valid value range: [1-86400] in seconds."
}

variable "lb_stickiness_cookie_name" {
  type        = string
  default     = "ALICLOUDSLB"
  description = "The cookie configured on the server. It is mandatory when lb_stickiness_enabled is true and lb_stickiness_type is 'server'. Otherwise, it will be ignored. Valid values are strings in line with RFC2965, with length being 1- 200. It only contains characters such as ASCII codes, English letters and digits instead of the comma, semicolon or spacing, and it cannot start with $."
}

variable "lb_instance_protocol" {
  type        = string
  default     = "http"
  description = "The protocol the load balancer's backend is listening on."
}

variable "lb_health_check_path" {
  type        = string
  description = "The path in each of the servers behind the load balancer to hit to get a health check status."
}

variable "lb_health_check_healthy_threshold" {
  type        = number
  default     = 5
  description = "Threshold determining the result of the health check is success. Valid value range: [1-10] in seconds."
}

variable "lb_health_check_timeout" {
  type        = number
  default     = 10
  description = "Maximum timeout of each health check response. Valid value range: [1-300] in seconds. Note: If lb_health_check_timeout < lb_health_check_interval, its will be replaced by lb_health_check_interval."
}

variable "lb_health_check_interval" {
  type        = number
  default     = 2
  description = "Time interval of health checks. Valid value range: [1-50] in seconds."
}

variable "lb_health_check_unhealthy_threshold" {
  type        = number
  default     = 2
  description = "Threshold determining the result of the health check is unhealthy. Valid value range: [1-10] in seconds."
}

variable "lb_health_check_healthy_status_code" {
  type        = string
  default     = "http_2xx"
  description = "Regular health check HTTP status code. Multiple codes are segmented by “,”. Default to 'http_2xx'. Valid values are: 'http_2xx', 'http_3xx', 'http_4xx', and 'http_5xx'."
}

variable "lb_health_check_method" {
  type        = string
  default     = "get"
  description = "The method to use for health checks. Valid values are 'get' and 'head'."
}

variable "lb_idle_timeout" {
  type        = number
  default     = 60
  description = "Timeout for HTTP or HTTPS established but idle connections. Valid value range: [1-60] in seconds."
}

variable "lb_request_timeout" {
  type        = number
  default     = 180
  description = "Timeout for HTTPS or HTTPS listener requests. Valid value range: [1-180] in seconds."
}

variable "lb_allowed_cidr" {
  type        = string
  description = "The IPv4 CIDR block that should have access to the load balancer"
  default     = "0.0.0.0/0"
}

variable "lb_ssl_policy" {
  type        = string
  description = "HTTPS listener TLS cipher policy. Valid values are 'tls_cipher_policy_1_0', 'tls_cipher_policy_1_1', 'tls_cipher_policy_1_2', and 'tls_cipher_policy_1_2_strict'."
  default     = "tls_cipher_policy_1_2_strict"
}

variable "lb_ssl_certificate_id" {
  type        = string
  description = "SLB Server certificate ID."
}

variable "lb_bandwidth" {
  type        = number
  description = "Bandwidth peak of Listener. For the public network instance charged per traffic consumed, the Bandwidth on Listener can be set to -1, indicating the bandwidth peak is unlimited. Valid values are [-1, 1-1000] in MB/S."
  default     = -1
}
