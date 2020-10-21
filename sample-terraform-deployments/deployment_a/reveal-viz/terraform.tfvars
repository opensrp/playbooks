region                                = "[An AWS region to deploy the service e.g ap-soucheast-1]"
env                                   = "production"
owner                                 = "reveal-project-owner-code"
end_date                              = "YYYY-MM-DD"
project                               = "reveal-project-code"
vm_ssh_key_name                       = "aws_key"
domain_zone_name                      = "example.org."
vpc_id                                = ""
webserver_firewall_rule_name          = "reveal-PROJECT_CODE_HERE-production-webserver"
webserver_firewall_rule_description   = "Giving http access to Reveal Web, Apache Superset production webservers"
ssh_firewall_rule_name                = "reveal-PROJECT_CODE_HERE-production-webserver-ssh"
ssh_firewall_rule_description         = "Giving ssh access to Reveal Web, Apache Superset production servers"
ssh_firewall_rule_ingress_cidr_blocks = ["0.0.0.0/0"]
vmdns_name                            = "reveal-PROJECT_CODE_HERE-production-webserver"
vmdns_vm_instances = [{
  admin_password    = "please change me"
  admin_user        = "superset-admin-user"
  reveal_web_domain = "superset.example.org"
  superset_domain   = "web.example.org"
  certbot_email     = ""
  group             = "reveal-PROJECT_CODE_HERE-production-webserver"
  init_action       = ""
  instance_type     = "t3.medium"
  parent_image      = "ami-06fd8a495a537da8b"
  software_version  = "0.37.0"
  volume_size       = "50"
  volume_type       = "gp2"
}]
vmdns_public_domain_names = ["superset", "web"]

uptimerobot_monitors = {
  service_a_http = {
    alert_contacts = [
      "A Slack channel e.g deployments"
    ],
    friendly_name = "Reveal Web - Reveal"
    monitor_type  = "http"
    keyword_type  = null
    keyword_value = null
    url           = "https://web.example.org"
    interval      = 60
  },
  service_a_keyword = {
    alert_contacts = [
      "A Slack channel e.g deployments",
      "The A team"
    ],
    friendly_name = "Apache Superset - Reveal"
    monitor_type  = "keyword"
    keyword_type  = "not exists"
    keyword_value = "OK"
    url           = "https://superset.example.org/health"
    interval      = 60
  }
}
