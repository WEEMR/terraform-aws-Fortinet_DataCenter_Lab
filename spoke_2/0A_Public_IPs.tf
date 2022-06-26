resource "aws_eip" "spoke_2_WAN1" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  provider               = aws.spoke_2_vpc
  depends_on        = [aws_instance.spoke_2]
  vpc               = true
  network_interface = aws_network_interface.spoke_2_eth0_wan1[count.index].id

  tags = {
    Name       = "${var.username}_Spoke_2_WAN_1"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_eip" "spoke_2_WAN2" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  provider               = aws.spoke_2_vpc
  depends_on        = [aws_instance.spoke_2]
  vpc               = true
  network_interface = aws_network_interface.spoke_2_eth1_wan2[count.index].id

  tags = {
    Name       = "${var.username}_Spoke_2_WAN_2"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}