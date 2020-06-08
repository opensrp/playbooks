resource "alicloud_oss_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_acl
  storage_class = var.bucket_storage_class

  server_side_encryption_rule {
    sse_algorithm = var.bucket_encryption_algorithm
  }

  tags = {
    Name            = var.bucket_name
    OwnerList       = var.bucket_owner
    EnvironmentList = var.bucket_env
    ProjectList     = var.bucket_project
    DeploymentType  = var.bucket_deployment_type
    EndDate         = var.bucket_end_date
  }
}