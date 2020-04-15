resource "aws_ebs_volume" "volume" {
  count             = length(data.aws_instance.instances)
  availability_zone = element(data.aws_instance.instances.*.availability_zone, count.index)
  size              = var.vms_size
  encrypted         = var.vms_encrypted
  type              = var.vms_type

  tags = {
    Name            = "${var.vms_name}-${count.index}"
    OwnerList       = var.vms_owner
    ProjectList     = var.vms_project
    DeploymentType  = var.vms_deployment_type
    EndDate         = var.vms_end_date
    EnvironmentList = var.vms_env
  }
}

resource "aws_volume_attachment" "volume_attachment" {
  count       = length(data.aws_instance.instances)
  device_name = var.vms_console_device_name
  volume_id   = element(aws_ebs_volume.volume.*.id, count.index)
  instance_id = element(data.aws_instance.instances.*.id, count.index)
}

resource "null_resource" "host_attachment_commands" {
  count      = length(data.aws_instance.instances)
  depends_on = [aws_volume_attachment.volume_attachment]

  connection {
    user = var.vms_vm_connection_user
    host = element(data.aws_instance.instances.*.public_ip, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "set -e",
      "sudo fdisk -l ${var.vms_host_device_name}",
      "if ! sudo blkid ${var.vms_host_device_name}; then sudo mkfs.${var.vms_filesystem_type} ${var.vms_host_device_name}; fi",
      "sudo mkdir -p ${var.vms_mount_point}",
      "sudo mount ${var.vms_host_device_name} ${var.vms_mount_point}",
      "sudo sed -i '/.*${replace(var.vms_host_device_name, "/", "\\/")}.*/d' /etc/fstab",
      "sudo sed -i '/.*${replace(var.vms_mount_point, "/", "\\/")}.*/d' /etc/fstab",
      "sudo bash -c 'echo \"${var.vms_host_device_name}\t${var.vms_mount_point}\t${var.vms_filesystem_type}\t${var.vms_fstab_mount_options}\" >> /etc/fstab'"
    ]

  }
}