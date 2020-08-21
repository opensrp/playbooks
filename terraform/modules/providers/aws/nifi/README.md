## NiFi on AWS

Sets up infrastructure on AWS for NiFi. The following AWS infrastructure is brought up:

1.  An EC2 instance
2.  Security groups for controlling HTTP and SSH access
3.  An EBS volume for NiFi's content repository
4.  An EBS volume for NiFi's other repositories
5.  DNS names pointing to the provisioned EC2 instances

## Usage

The module assumes:

1.  NiFi is pre-installed in the AMIs provided

2.  The following services are also pre-installed alongside NiFi
    a. NGINX
    b. collectd
    c. Monit
    d. Certbot

3.  In the pre-built AMIs NiFi is configured to write content to the mount points specified in  nifi_other_repositories_vms_mount_point and nifi_content_repository_vms_mount_point.

Add a module block in your Terraform deployment files that looks like:

```hcl
module "nifi" {
  source                                     = "../../../../modules/providers/aws/nifi"
  nifi_vm_ssh_key_name                       = "name-of-key-on-aws"
  nifi_owner                                 = "opensrp"
  nifi_env                                   = "staging"
  nifi_end_date                              = "-"
  nifi_project                               = "test-project"
  nifi_vmdns_name                            = "opensrp-test-project-staging-nifi"
  nifi_vpc_id                                = "vpc-blahblah"
  nifi_availability_zones                    = ["us-east-1a", "us-east-1b", "us-east-1c"]
  nifi_firewall_rule_name                    = "access-to-opensrp-test-project-nifi"
  nifi_firewall_rule_ssh_ingress_cidr_blocks = ["0.0.0.0/0"] # super permissive. Not recommended for production
  nifi_firewall_rule_description             = ""
  nifi_vmdns_vm_instances                    = var.nifi_vmdns_vm_instances
  nifi_domain_zone_name                      = var.domain_zone_name
  nifi_vmdns_public_domain_names             = var.nifi_vmdns_public_domain_names
  nifi_lets_encrypt_alert_email              = var.nifi_lets_encrypt_alert_email
  nifi_content_repository_vms_mount_point    = var.nifi_content_repository_vms_mount_point
  nifi_other_repositories_vms_mount_point    = var.nifi_other_repositories_vms_mount_point
  nifi_content_repository_vms_size           = var.nifi_content_repository_vms_size
  nifi_other_repositories_vms_size           = var.nifi_other_repositories_vms_size
  nifi_content_repository_vms_name           = var.nifi_content_repository_vms_name
  nifi_other_repositories_vms_name           = var.nifi_other_repositories_vms_name
}
```

### Further Work

The following features aren't yet supported by this module:

1.  Support for bringing up more than one EC2 instance
2.  Support for more than one DNS name
3.  Support for providing a custom template to be applied as the cloudinit user data.
