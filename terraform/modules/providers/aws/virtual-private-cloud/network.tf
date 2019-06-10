resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name            = "${var.vpc_name}"
    OwnerList       = "${var.vpc_owner}"
    EnvironmentList = "${var.vpc_env}"
    EndDate         = "${var.vpc_end_date}"
    ProjectList     = "${var.vpc_project}"
  }
}

resource "aws_vpc_peering_connection" "main_to_default" {
  count       = "${var.vpc_peer_to_default ? 1 : 0}"
  peer_vpc_id = "${data.aws_vpc.default.id}"
  vpc_id      = "${aws_vpc.main.id}"
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags {
    OwnerList       = "${var.vpc_owner}"
    EnvironmentList = "${var.vpc_env}"
    EndDate         = "${var.vpc_end_date}"
    ProjectList     = "${var.vpc_project}"
    Name            = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name            = "${var.vpc_name}"
    OwnerList       = "${var.vpc_owner}"
    EnvironmentList = "${var.vpc_env}"
    EndDate         = "${var.vpc_end_date}"
    ProjectList     = "${var.vpc_project}"
  }
}

resource "aws_route_table" "main" {
  count  = "${var.vpc_peer_to_default ? 1 : 0}"
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  route {
    cidr_block                = "${data.aws_vpc.default.cidr_block}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.main_to_default.id}"
  }

  tags {
    Name            = "${var.vpc_name}"
    OwnerList       = "${var.vpc_owner}"
    EnvironmentList = "${var.vpc_env}"
    EndDate         = "${var.vpc_end_date}"
    ProjectList     = "${var.vpc_project}"
  }
}

resource "aws_route" "default_to_main" {
  count = "${var.vpc_peer_to_default ? 1 : 0}"

  route_table_id            = "${data.aws_route_table.default.id}"
  destination_cidr_block    = "${aws_vpc.main.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.main_to_default.id}"
}

resource "aws_subnet" "vpc_subnets" {
  availability_zone       = "${element(var.vpc_availability_zones, count.index)}"
  count                   = "${length(var.vpc_availability_zones)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)}"
  map_public_ip_on_launch = "${var.vpc_map_public_ip_on_launch}"

  tags {
    Name            = "${var.vpc_name}-${count.index}"
    OwnerList       = "${var.vpc_owner}"
    EnvironmentList = "${var.vpc_env}"
    EndDate         = "${var.vpc_end_date}"
    ProjectList     = "${var.vpc_project}"
  }
}

resource "aws_route_table_association" "main" {
  count          = "${length(var.vpc_availability_zones)}"
  subnet_id      = "${element(aws_subnet.vpc_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.main.id}"
}
