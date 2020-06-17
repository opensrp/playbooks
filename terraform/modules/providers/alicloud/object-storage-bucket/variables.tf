variable "bucket_name" {
  type        = string
  description = "The name of the object store bucket."
}

variable "bucket_acl" {
  type        = string
  default     = "private"
  description = "The canned ACL to apply. Can be 'private', 'public-read', and 'public-read-write'."
}

variable "bucket_owner" {
  type        = string
  description = "The ID of the group that owns the bucket."
}

variable "bucket_env" {
  type        = string
  description = "The name of the environment the bucket is part of. Accepted values are 'production', 'staging', 'preview', and 'shared'."
}

variable "bucket_project" {
  type        = string
  description = "The ID of the project the bucket is part of."
}

variable "bucket_deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}

variable "bucket_end_date" {
  type        = string
  description = "The expiry date for the bucket. Please use ISO-8601 formatted dates or '-' if an end date is not applicable."
}

variable "bucket_encryption_algorithm" {
  type        = string
  default     = "AES256"
  description = "The algorithm to use to encrypt data in the bucket."
}

variable "bucket_storage_class" {
  type        = string
  default     = "Standard"
  description = "The storage class to apply. Can be 'Standard', 'IA', and 'Archive'. Check the Alicloud documentation for more details."
}