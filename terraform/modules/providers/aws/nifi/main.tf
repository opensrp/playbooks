data "aws_vpc" "main" {
  id = var.nifi_vpc_id
}

data "aws_subnet_ids" "main" {
  vpc_id = var.nifi_vpc_id
}

data "template_file" "init" {
  template = file("${path.module}/init.sh.tpl")

  vars = {
    hostname                 = "${var.nifi_vmdns_name}-0"
    domain_name              = "${var.nifi_vmdns_public_domain_names[0]}.${var.nifi_domain_zone_name}"
    content_repo_mount_path  = var.nifi_content_repository_vms_mount_point
    other_repos_mount_path   = var.nifi_other_repositories_vms_mount_point
    lets_encrypt_alert_email = var.nifi_lets_encrypt_alert_email
  }
}
