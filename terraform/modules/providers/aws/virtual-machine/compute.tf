# VPS
resource "aws_instance" "main" {
  count                       = "${length(var.vm_instances)}"
  ami                         = "${lookup(var.vm_instances[count.index], "parent_image")}"
  availability_zone           = "${element(data.aws_subnet.vpc_subnets.*.availability_zone, count.index % length(data.aws_subnet.vpc_subnets))}"
  instance_type               = "${lookup(var.vm_instances[count.index], "instance_type")}"
  key_name                    = "${var.vm_ssh_key_name}"
  vpc_security_group_ids      = "${var.vm_firewall_rules}"
  subnet_id                   = "${element(data.aws_subnet.vpc_subnets.*.id, count.index % length(data.aws_subnet.vpc_subnets))}"
  associate_public_ip_address = "${var.vm_associate_public_ip_address}"

  root_block_device {
    volume_size = "${lookup(var.vm_instances[count.index], "volume_size")}"
    volume_type = "${lookup(var.vm_instances[count.index], "volume_type")}"
  }

  tags = {
    Name            = "${var.vm_name}-${count.index}"
    Group           = "${lookup(var.vm_instances[count.index], "group")}"
    OwnerList       = "${var.vm_owner}"
    EnvironmentList = "${var.vm_env}"
    EndDate         = "${var.vm_end_date}"
    ProjectList     = "${var.vm_project}"
  }

  volume_tags = {
    Name            = "${var.vm_name}-${count.index}"
    Group           = "${lookup(var.vm_instances[count.index], "group")}"
    OwnerList       = "${var.vm_owner}"
    EnvironmentList = "${var.vm_env}"
    EndDate         = "${var.vm_end_date}"
    ProjectList     = "${var.vm_project}"
  }
}
