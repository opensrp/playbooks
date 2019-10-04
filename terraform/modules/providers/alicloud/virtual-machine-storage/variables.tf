variable "vms_name" {
  type = string
}
variable "vms_owner" {
  type = string
}
variable "vms_project" {
  type = string
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
  default = "cloud_efficiency"
}
variable "vms_host_device_name" {
  type    = string
  default = "/dev/vdb"
}
variable "vms_mount_point" {
  type = string
}
variable "vms_vm_ids" {
  type = list(string)
}

variable "vms_vm_connection_user" {
  type    = string
  default = "root"
}
variable "vms_filesystem_type" {
  type    = string
  default = "ext4"
}
variable "vms_fstab_mount_options" {
  type    = string
  default = "defaults\t0\t2"
}

variable "vms_delete_with_instance" {
  type    = bool
  default = false
}