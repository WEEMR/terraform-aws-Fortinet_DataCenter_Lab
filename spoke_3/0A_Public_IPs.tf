resource "aws_eip" "spoke_3_WAN1" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  provider               = aws.spoke_3_vpc
  depends_on        = [aws_instance.spoke_3]
  vpc               = true
  network_interface = aws_network_interface.spoke_3_eth0_wan1[count.index].id

  tags = {
    Name       = "${var.username}_Spoke_3_WAN_1"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_eip" "spoke_3_WAN2" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  provider               = aws.spoke_3_vpc
  depends_on        = [aws_instance.spoke_3]
  vpc               = true
  network_interface = aws_network_interface.spoke_3_eth1_wan2[count.index].id

  tags = {
    Name       = "${var.username}_spoke_3_WAN_2"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}