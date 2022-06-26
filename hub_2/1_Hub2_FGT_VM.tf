// FGTVM instance

data "aws_availability_zones" "AZs" {
  provider = aws.hub_2_vpc
  state = "available"
}

// ------------------------------------------------------------------------------ hub 2 Interfaces

# Port 1 - WAN 1

resource "aws_network_interface" "hub_2_eth0_wan1" {
  count = var.create_hub_2_fgt == "yes" ? 1 : 0
  provider       = aws.hub_2_vpc
  description = "${var.username}_TF_hub_2_WAN_1"
  subnet_id   = var.hub_2_wan1_subnet_id
  private_ips = var.hub_2_wan1_pvt_ip
  security_groups = [var.default_SG, var.Public_SG]

  tags = {
    Name = "${var.username}_TF_hub_2_WAN_1"
  }
}

# Port 2 - WAN 2

resource "aws_network_interface" "hub_2_eth1_wan2" {
  count = var.create_hub_2_fgt == "yes" ? 1 : 0
  provider       = aws.hub_2_vpc
  description       = "${var.username}_TF_hub_2_WAN_2"
  subnet_id         = var.hub_2_wan2_subnet_id
  private_ips       = var.hub_2_wan2_pvt_ip
  security_groups = [var.default_SG, var.Public_SG]

  tags = {
    Name = "${var.username}_TF_hub_2_WAN_2"
  }
}

# Port 3 - LAN 

resource "aws_network_interface" "hub_2_eth2_lan" {
  count = var.create_hub_2_fgt == "yes" ? 1 : 0
  provider       = aws.hub_2_vpc
  description        = "${var.username}_TF_hub_2_LAN"
  subnet_id         = var.hub_2_private_subnet_id
  source_dest_check = false
  private_ips        = var.hub_2_lan_pvt_IP
  security_groups = [var.Private_SG]

  tags = {
    Name = "${var.username}_TF_hub_2_LAN"
  }
}

// ------------------------------------------------------------------------------ hub 2 Private LAN Route Table

# Assgining hub 2 LAN interface as the main egress point [Next Hop] for the LAN subnet.

resource "aws_route" "hub_2_Pvt_RT_default_out" {
  count = var.create_hub_2_fgt == "yes" ? 1 : 0
  provider               = aws.hub_2_vpc
  route_table_id         = var.hub_2_pvt_rt_id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_network_interface.hub_2_eth2_lan]
  network_interface_id   = aws_network_interface.hub_2_eth2_lan[count.index].id
}


// ------------------------------------------------------------------------------ Creating FortiGate

resource "aws_instance" "hub_2" {
  count = var.create_hub_2_fgt == "yes" ? 1 : 0
  provider          = aws.hub_2_vpc
  ami               = lookup(var.FGT_VM_AMI, var.virginia_region)
  instance_type     = var.FGT_VM_Size
  availability_zone = data.aws_availability_zones.AZs.names[0]
  key_name          = var.keyname
  user_data         = data.template_file.FortiGate.rendered

  root_block_device {
    volume_type = "standard"
    volume_size = "2"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "30"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.hub_2_eth0_wan1[count.index].id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.hub_2_eth1_wan2[count.index].id
    device_index         = 1
  }

    network_interface {
    network_interface_id = aws_network_interface.hub_2_eth2_lan[count.index].id
    device_index         = 2
  }

  tags = {
    Name = "${var.username}_TF_hub_2_FGT"
  }
}


data "template_file" "FortiGate" {
  template = file(var.hub2_Configurations)
  vars = {
    adminsport             = "443"
    username               = "${var.username}"
    Password               = "${var.Password}"
    FMG                    = "fmg.${var.username}.fortinetpslab.com"
    Ubuntu_LAN_IP          = "${var.hub_2_Ubuntu_LAN_IP[0]}"
    Windows_LAN_IP         = "${var.hub_2_WinSrv_LAN_IP[0]}"
    FMG_FQDN               = "${var.hub1_FMG_For_Spokes}"
    FGT_WAN_IP           = "${var.hub_2_wan1_pvt_ip[0]}"
    FGT_WAN_2_IP           = "${var.hub_2_wan2_pvt_ip[0]}"
    pubsub1_gw             = cidrhost(var.hub_2_wan1_subnet_cidr, 1)
    pubsub2_gw             = cidrhost(var.hub_2_wan2_subnet_cidr, 1)
    access_key             = "${var.access_key}"
    secret_key             = "${var.secret_key}"
    region                 = "${var.virginia_region}"
    pvt_subnet_ID          = "${var.hub_2_private_subnet_id}"
  }
  }
