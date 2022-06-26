// FSA VM instance

// ------------------------------------------------------------------------------ fsa 1 Interfaces

# Port 1 - WAN 1

resource "aws_network_interface" "fsa_1_eth0_wan" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  description = "${var.username}_TF_fsa_1_WAN"
  subnet_id   = aws_subnet.fsa_1_public_subnet[count.index].id
  private_ips = var.fsa_1_wan_pvt_ip
  security_groups = [aws_default_security_group.default_SG[count.index].id]

  tags = {
    Name = "${var.username}_TF_fsa_1_WAN"
  }
}

# Port 2 - WAN 2

resource "aws_network_interface" "fsa_1_eth1_lan" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  description       = "${var.username}_TF_fsa_1_LAN"
  subnet_id         = aws_subnet.fsa_1_private_subnet[count.index].id
  source_dest_check = false
  private_ips       = var.fsa_1_lan_pvt_ip
  security_groups = [aws_security_group.Private_SG[count.index].id]

  tags = {
    Name = "${var.username}_TF_fsa_1_LAN"
  }
}

# Port 3 - LAN 

resource "aws_network_interface" "fsa_1_eth2_ha" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  description        = "${var.username}_TF_fsa_1_HA"
  subnet_id         = aws_subnet.fsa_1_HA_subnet[count.index].id
  source_dest_check = false
  private_ips        = var.fsa_1_ha_pvt_IP
  security_groups = [aws_security_group.Private_SG[count.index].id]

  tags = {
    Name = "${var.username}_TF_fsa_1_HA"
  }
}

// ------------------------------------------------------------------------------ fsa 1 Private LAN Route Table

# Assgining fsa 1 LAN interface as the main egress point [Next Hop] for the LAN subnet.

#resource "aws_route" "fsa_1_Pvt_RT_to_spoke_1" {
#  provider               = aws.fsa_1_vpc
#  route_table_id         = var.fsa_1_pvt_rt_id
#  destination_cidr_block = var.spoke_1_private_subnet_cidr
#  depends_on             = [aws_network_interface.fsa_1_eth1_lan]
#  network_interface_id   = aws_network_interface.fsa_1_eth2_lan.id
#
#}


// ------------------------------------------------------------------------------ Creating FortiSandbox

resource "aws_instance" "fsa_1" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider          = aws.fsa_1_vpc
  ami               = lookup(var.FSA_VM_AMI, var.virginia_region)
  instance_type     = var.FSA_VM_Size
  availability_zone = data.aws_availability_zones.AZs.names[0]
  key_name          = var.keyname

  root_block_device {
    volume_type = "standard"
    volume_size = "1"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    snapshot_id = "snap-024720b0ed185271d"
    #volume_size = "80"
    #volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.fsa_1_eth0_wan[count.index].id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.fsa_1_eth1_lan[count.index].id
    device_index         = 1
  }

    network_interface {
    network_interface_id = aws_network_interface.fsa_1_eth2_ha[count.index].id
    device_index         = 2
  }

  tags = {
    Name = "${var.username}_TF_FortiSandbox_Primary"
  }
}