variable "lb_env" {
}

variable "lb_owner" {
}

variable "lb_project" {
}

variable "lb_end_date" {
}

variable "lb_name" {
}

variable "lb_subnets" {
  type = list(string)
}

variable "lb_enable_delete_protection" {
  default = false
}

variable "lb_idle_timeout" {
  default = 300
}

variable "lb_http_port" {
  default = 80
}

variable "lb_https_port" {
  default = 443
}

variable "lb_instance_port" {
}

variable "lb_instance_protocol" {
  default = "HTTP"
}

variable "lb_vpc_id" {
}

variable "lb_health_check_healthy_threshold" {
  default = 5
}

variable "lb_health_check_path" {
}

variable "lb_health_check_timeout" {
  default = 5
}

variable "lb_health_check_unhealthy_threshold" {
  default = 2
}

variable "lb_health_check_healthy_status_code" {
  default = "200"
}

variable "lb_instance_ids" {
  type = list(string)
}

variable "lb_logs_user_identifiers" {
  type = list(string)
  default = [
    "arn:aws:iam::127311923021:root", // us-east-1
    "arn:aws:iam::033677994240:root", // us-east-2
    "arn:aws:iam::027434742980:root", // us-west-1
    "arn:aws:iam::797873946194:root", // us-west-2
    "arn:aws:iam::985666609251:root", // ca-central-1
    "arn:aws:iam::054676820928:root", // eu-central-1
    "arn:aws:iam::156460612806:root", // eu-west-1
    "arn:aws:iam::652711504416:root", // eu-west-2
    "arn:aws:iam::009996457667:root", // eu-west-3
    "arn:aws:iam::897822967062:root", // eu-north-1
    "arn:aws:iam::754344448648:root", // ap-east-1
    "arn:aws:iam::582318560864:root", // ap-northeast-1
    "arn:aws:iam::600734575887:root", // ap-northeast-2
    "arn:aws:iam::383597477331:root", // ap-northeast-3
    "arn:aws:iam::114774131450:root", // ap-southeast-1
    "arn:aws:iam::783225319266:root", // ap-southeast-2
    "arn:aws:iam::718504428378:root", // ap-south-1
    "arn:aws:iam::507241528517:root", // sa-east-1
    "arn:aws:iam::048591011584:root", // us-gov-west-1*
    "arn:aws:iam::190560391635:root", // us-gov-east-1*
    "arn:aws:iam::638102146993:root", // cn-north-1**
    "arn:aws:iam::037604701340:root",
  ] // cn-northwest-1**
}

variable "lb_stickiness_type" {
  type    = string
  default = "lb_cookie"
}

variable "lb_stickiness_cookie_duration" {
  type    = number
  default = 86400
}

variable "lb_stickiness_enabled" {
  type    = bool
  default = false
}

variable "lb_logs_object_storage_bucket_name" {
}

variable "lb_listener_rules" {
  type = list(object({ priority = number, action_type = string, condition_field = string, values = string }))
}

variable "lb_ssl_policy" {
}

variable "lb_domain_zone_name" {
}

variable "lb_domain_name" {
}

variable "lb_domain_name_cnames" {
}

variable "lb_alarm_unhealthy_hosts_evaluation_periods" {
  type        = string
  default     = "1"
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "lb_alarm_unhealthy_hosts_period" {
  type        = string
  default     = "300"
  description = "The period in seconds over which the average is applied."
}

variable "lb_alarm_unhealthy_hosts_threshold" {
  type        = number
  default     = 0.25
  description = "The fraction of hosts that if become unhealthy an alarm is raised"
}

variable "lb_alarm_requests_5xx_count_evaluation_periods" {
  type        = string
  default     = "1"
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "lb_alarm_requests_5xx_count_period" {
  type        = string
  default     = "300"
  description = "The period in seconds over which the sum is applied."
}

variable "lb_alarm_requests_5xx_threshold" {
  type        = number
  default     = 50
  description = "The threshold of number of 5xx requests that if crossed, an alarm will be raised."
}

variable "lb_alarm_alarm_actions" {
  type        = list(string)
  default     = []
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN)."
}

variable "lb_alarm_insufficient_data_actions" {
  type        = list(string)
  default     = []
  description = "The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN)."
}

variable "lb_alarm_ok_actions" {
  type        = list(string)
  default     = []
  description = "The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN)."
}