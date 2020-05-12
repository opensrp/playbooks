resource "alicloud_vpc" "main" {
  name       = var.vpc_name
  cidr_block = var.vpc_cidr

  tags = {
    Name            = var.vpc_name
    OwnerList       = var.vpc_owner
    EnvironmentList = var.vpc_env
    EndDate         = var.vpc_end_date
    ProjectList     = var.vpc_project
    DeploymentType  = var.vpc_deployment_type
  }
}

resource "alicloud_nat_gateway" "main" {
  vpc_id               = alicloud_vpc.main.id
  name                 = var.vpc_name
  specification        = var.vpc_nat_gateway_specification
  instance_charge_type = "PostPaid"
}

resource "alicloud_route_table" "main" {
  vpc_id = alicloud_vpc.main.id
  name   = var.vpc_name

  tags = {
    Name            = var.vpc_name
    OwnerList       = var.vpc_owner
    EnvironmentList = var.vpc_env
    EndDate         = var.vpc_end_date
    ProjectList     = var.vpc_project
    DeploymentType  = var.vpc_deployment_type
  }
}

resource "alicloud_vswitch" "vpc_vswitches" {
  name              = "${var.vpc_name}-${count.index}"
  vpc_id            = alicloud_vpc.main.id
  cidr_block        = cidrsubnet(alicloud_vpc.main.cidr_block, var.vpc_subnet_newbits, count.index)
  availability_zone = element(var.vpc_availability_zones, count.index)
  count             = length(var.vpc_availability_zones)

  tags = {
    Name            = "${var.vpc_name}-${count.index}"
    OwnerList       = var.vpc_owner
    EnvironmentList = var.vpc_env
    EndDate         = var.vpc_end_date
    ProjectList     = var.vpc_project
    DeploymentType  = var.vpc_deployment_type
  }
}

resource "alicloud_route_table_attachment" "main" {
  count          = length(var.vpc_availability_zones)
  vswitch_id     = element(alicloud_vswitch.vpc_vswitches.*.id, count.index)
  route_table_id = alicloud_route_table.main.id
}
