resource "aws_eip" "spoke_1_WAN1" {
  count = var.create_spoke_1_fgt == "yes" ? 1 : 0
  provider               = aws.spoke_1_vpc
  depends_on        = [aws_instance.spoke_1]
  vpc               = true
  network_interface = aws_network_interface.spoke_1_eth0_wan1[count.index].id

  tags = {
    Name       = "${var.username}_Spoke_1_WAN_1"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_eip" "spoke_1_WAN2" {
  count = var.create_spoke_1_fgt == "yes" ? 1 : 0
  provider               = aws.spoke_1_vpc
  depends_on        = [aws_instance.spoke_1]
  vpc               = true
  network_interface = aws_network_interface.spoke_1_eth1_wan2[count.index].id

  tags = {
    Name       = "${var.username}_Spoke_2_WAN_2"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}