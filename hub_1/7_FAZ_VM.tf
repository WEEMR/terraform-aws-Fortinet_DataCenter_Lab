// FGTVM instance

resource "aws_network_interface" "hub1_FAZ_eth0" {
  count = var.create_hub_1_FAZ == "yes" ? 1 : 0
  provider    = aws.virginia
  description = "${var.username}_Terraform_hub_1_FAZ_WAN"
  subnet_id   = var.hub_1_private_subnet_id
  private_ips = var.hub_1_FAZ_LAN_IP
  security_groups = [var.Private_SG]

  tags = {
    Name = "${var.username}_TF_hub_1_FAZ_WAN"
  }
}

resource "aws_instance" "WRady_Terraform_FAZ" {
  count = var.create_hub_1_FAZ == "yes" ? 1 : 0
  provider    = aws.virginia
  ami               = lookup(var.FAZ_VM_AMI, var.virginia_region)
  instance_type     = var.FAZ_VM_Size
  availability_zone = data.aws_availability_zones.AZs.names[0]
  key_name          = var.keyname

  root_block_device {
    volume_type = "standard"
    volume_size = "5"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    snapshot_id = "snap-0600bf0d055d739fb"
  #  volume_size = "80"
  #  volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.hub1_FAZ_eth0[count.index].id
    device_index         = 0
  }

  tags = {
    Name = "${var.username}_TF_hub_1_FAZ"
  }
}
