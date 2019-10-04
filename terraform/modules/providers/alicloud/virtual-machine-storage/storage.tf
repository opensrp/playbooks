resource "alicloud_disk" "volume" {
  count                = length(data.alicloud_instances.instances)
  availability_zone    = element(data.alicloud_instances.instances.*.instances, count.index)[0].availability_zone
  size                 = var.vms_size
  encrypted            = var.vms_encrypted
  category             = var.vms_type
  name                 = "${var.vms_name}-${count.index}"
  delete_with_instance = var.vms_delete_with_instance

  tags = {
    Name            = "${var.vms_name}-${count.index}"
    OwnerList       = var.vms_owner
    ProjectList     = var.vms_project
    EndDate         = var.vms_end_date
    EnvironmentList = var.vms_env
  }
}

resource "alicloud_disk_attachment" "volume_attachment" {
  count       = length(data.alicloud_instances.instances)
  disk_id     = element(alicloud_disk.volume.*.id, count.index)
  instance_id = element(data.alicloud_instances.instances.*.instances, count.index)[0].id
}

resource "null_resource" "host_attachment_commands" {
  count      = length(data.alicloud_instances.instances)
  depends_on = [alicloud_disk_attachment.volume_attachment]

  connection {
    user = var.vms_vm_connection_user
    host = element(data.alicloud_instances.instances.*.instances, count.index)[0].public_ip
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