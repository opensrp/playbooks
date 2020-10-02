variable "nifi_env" {
  type = string
}
variable "nifi_owner" {
  type = string
}
variable "nifi_end_date" {
  type = string
}
variable "nifi_project" {
  type = string
}
variable "nifi_domain_zone_name" {
  type = string
}
variable "nifi_vpc_id" {
  type = string
}
variable "nifi_vm_ssh_key_name" {
  type = string
}
variable "nifi_availability_zones" {
  type = list(string)
}

# NiFi Firewall Rule
variable "nifi_firewall_rule_name" {
  type = string
}
variable "nifi_firewall_rule_description" {
  type = string
}
variable "nifi_firewall_rule_ssh_ingress_cidr_blocks" {
}

# NiFi
variable "nifi_vmdns_name" {
  type = string
}
variable "nifi_vmdns_vm_instances" {
}
variable "nifi_vmdns_public_domain_names" {
}
variable "nifi_lets_encrypt_alert_email" {
  type = string
}

# NiFi Content Repository Storage
variable "nifi_content_repository_vms_size" {
  type = string
}
variable "nifi_content_repository_vms_name" {
  type = string
}
variable "nifi_content_repository_vms_mount_point" {
  type = string
}
# Noticed that the device name specified to the AWS API or on the console
# might not be the same one that is installed on the host
variable "nifi_content_repository_vms_console_device_name" {
  type    = string
  default = "/dev/sdf"
}
variable "nifi_content_repository_vms_host_device_name" {
  type    = string
  default = "/dev/nvme1n1"
}

# NiFi Other Repositories Storage
variable "nifi_other_repositories_vms_size" {
  type = string
}
variable "nifi_other_repositories_vms_name" {
  type = string
}
variable "nifi_other_repositories_vms_mount_point" {
  type = string
}
# Noticed that the device name specified to the AWS API or on the console
# might not be the same one that is installed on the host
variable "nifi_other_repositories_vms_console_device_name" {
  type    = string
  default = "/dev/sdg"
}
variable "nifi_other_repositories_vms_host_device_name" {
  type    = string
  default = "/dev/nvme2n1"
}
