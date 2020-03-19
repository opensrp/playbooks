resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name            = var.vpc_name
    OwnerList       = var.vpc_owner
    EnvironmentList = var.vpc_env
    EndDate         = var.vpc_end_date
    ProjectList     = var.vpc_project
    DeploymentType  = var.vpc_deployment_type
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name            = var.vpc_name
    OwnerList       = var.vpc_owner
    EnvironmentList = var.vpc_env
    EndDate         = var.vpc_end_date
    ProjectList     = var.vpc_project
    DeploymentType  = var.vpc_deployment_type
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name            = var.vpc_name
    OwnerList       = var.vpc_owner
    EnvironmentList = var.vpc_env
    EndDate         = var.vpc_end_date
    ProjectList     = var.vpc_project
    DeploymentType  = var.vpc_deployment_type
  }
}

resource "aws_subnet" "vpc_subnets" {
  availability_zone       = element(var.vpc_availability_zones, count.index)
  count                   = length(var.vpc_availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = var.vpc_map_public_ip_on_launch

  tags = {
    Name            = "${var.vpc_name}-${count.index}"
    OwnerList       = var.vpc_owner
    EnvironmentList = var.vpc_env
    EndDate         = var.vpc_end_date
    ProjectList     = var.vpc_project
    DeploymentType  = var.vpc_deployment_type
  }
}

resource "aws_route_table_association" "main" {
  count          = length(var.vpc_availability_zones)
  subnet_id      = element(aws_subnet.vpc_subnets.*.id, count.index)
  route_table_id = aws_route_table.main.id
}

