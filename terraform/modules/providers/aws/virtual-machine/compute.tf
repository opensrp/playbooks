# VPS
resource "aws_instance" "main" {
  count                       = "${length(var.vm_instances)}"
  ami                         = "${lookup(var.vm_instances[count.index], "parent_image")}"
  availability_zone           = "${lookup(var.vm_instances[count.index], "availability_zone")}"
  instance_type               = "${lookup(var.vm_instances[count.index], "instance_type")}"
  key_name                    = "${var.vm_ssh_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.main.*.id}"]
  subnet_id                   = "${lookup(var.vm_instances[count.index], "subnet_id")}"
  associate_public_ip_address = "${var.vm_associate_public_ip_address}"

  root_block_device {
    volume_size = "${lookup(var.vm_instances[count.index], "volume_size")}"
    volume_type = "${lookup(var.vm_instances[count.index], "volume_type")}"
  }

  tags {
    Name            = "${var.vm_name}-${count.index}"
    Index           = "${count.index}"
    Group           = "${var.vm_name}"
    OwnerList       = "${var.vm_owner}"
    EnvironmentList = "${var.vm_env}"
    EndDate         = "${var.vm_end_date}"
    ProjectList     = "${var.vm_project}"
  }

  volume_tags {
    OwnerList       = "${var.vm_owner}"
    EnvironmentList = "${var.vm_env}"
    EndDate         = "${var.vm_end_date}"
    ProjectList     = "${var.vm_project}"
  }
}
