###########################################################################
# Virtual Private Cloud
#
# Anythin named 'default' is assiated to the default VPC in our AWS account
# Anything named 'main' is associated to the VPC being defined here
###########################################################################

data "aws_vpc" "default" {
  id = "${var.vpc_default_vpc_id}"
}

data "aws_route_table" "default" {
  route_table_id = "${var.vpc_default_route_table}"
}
