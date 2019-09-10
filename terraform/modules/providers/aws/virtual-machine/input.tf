data "aws_subnet_ids" "vpc_subnet_ids" {
  vpc_id = var.vm_vpc_id
  filter {
    name   = "availability-zone"
    values = var.vm_availability_zones
  }
}

data "aws_subnet" "vpc_subnets" {
  count = length(data.aws_subnet_ids.vpc_subnet_ids.ids)
  id    = tolist(data.aws_subnet_ids.vpc_subnet_ids.ids)[count.index]
}