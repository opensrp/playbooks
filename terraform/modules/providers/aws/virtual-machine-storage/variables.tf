variable "vms_name" {
  type = string
}
variable "vms_owner" {
  type = string
}
variable "vms_project" {
  type = string
}
variable "vms_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}
variable "vms_end_date" {
  type = string
}
variable "vms_env" {
  type = string
}
variable "vms_size" {
  type = number
}
variable "vms_encrypted" {
  type    = bool
  default = true
}
variable "vms_type" {
  type    = string
  default = "gp2"
}
# Noticed that the device name specified to the AWS API or on the console
# might not be the same one that is installed on the host
variable "vms_console_device_name" {
  type    = string
  default = "/dev/sdf"
}
variable "vms_host_device_name" {
  type    = string
  default = "/dev/nvme1n1"
}
variable "vms_mount_point" {
  type = string
}
variable "vms_vm_ids" {
  type = list(string)
}

variable "vms_vm_connection_user" {
  type    = string
  default = "ubuntu"
}
variable "vms_filesystem_type" {
  type    = string
  default = "ext4"
}
variable "vms_fstab_mount_options" {
  type    = string
  default = "defaults\t0\t2"
}