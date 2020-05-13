variable "postgresql_name" {
  type        = string
  description = "The name to give the database server."
}

variable "postgresql_env" {
  type        = string
  description = "The environment this database is in. Possible values are 'staging', 'previw', 'production', and 'shared'."
}

variable "postgresql_owner" {
  type        = string
  description = "The ID of the owner/team that is responsible for the database."
}

variable "postgresql_end_date" {
  type        = string
  description = "The last date for the database."
}

variable "postgresql_project" {
  type        = string
  description = "The ID of the project that owns the database."
}

variable "postgresql_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}

variable "postgresql_vswitch_id" {
  type        = string
  description = "The virtual switch ID to launch DB instances in one VPC."
}

variable "postgresql_availability_zones" {
  type        = list(string)
  description = "The availability zones the database should be part of. The provided postgresql_vswitch_id should be in one of the availablility zones."
}

variable "postgresql_allocated_storage" {
  type        = string
  description = "User-defined DB instance storage space. Value range: [5, 2000]."
}

variable "postgresql_version" {
  type        = string
  description = "Database version. For value options, refer to 'EngineVersion' in https://www.alibabacloud.com/help/doc-detail/26228.htm."
}

variable "postgresql_instance_type" {
  type        = string
  description = "DB Instance type. For possible values, check https://www.alibabacloud.com/help/doc-detail/26312.htm."
}

variable "postgresql_firewall_rule_ingress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks allowed to access all databases of an instance. The list contains up to 1,000 blocks"
}

variable "postgresql_backup_retention_period" {
  type        = number
  description = "Instance backup retention days. Valid values: [7-730]."
  default     = 35
}

variable "postgresql_backup_days" {
  type        = list(string)
  default     = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  description = "Which days of the week to back up the database."
}

variable "postgresql_backup_time" {
  type        = string
  default     = "02:00Z-03:00Z"
  description = "DB instance backup time, in the format of HH:mmZ- HH:mmZ. Time setting interval is one hour."
}

variable "postgresql_username" {
  type        = string
  description = "Superuser account to create in the database. It may consist of lower case letters, numbers, and underlines, and must start with a letter and have no more than 16 characters."
}

variable "postgresql_kms_encrypted_password" {
  type        = string
  description = "A KMS encrypted password to be used with postgresql_username."
}

variable "postgresql_kms_encryption_context" {
  type        = string
  description = "The KMS encryption context used to decrypt postgresql_kms_encrypted_password."
}

variable "postgresql_instance_storage_type" {
  type        = string
  description = "The storage type of the instance. Valid values: ['local_ssd', 'cloud_ssd', 'cloud_essd', 'cloud_essd3', 'cloud_essd3']."
  default     = "local_ssd"
}