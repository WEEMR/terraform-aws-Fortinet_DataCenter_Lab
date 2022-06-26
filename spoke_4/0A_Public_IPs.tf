resource "aws_eip" "spoke_4_WAN1" {
  count = var.create_spoke_4_fgt == "yes" ? 1 : 0
  provider               = aws.spoke_4_vpc
  depends_on        = [aws_instance.spoke_4]
  vpc               = true
  network_interface = aws_network_interface.spoke_4_eth0_wan1[count.index].id

  tags = {
    Name       = "${var.username}_spoke_4_WAN_1"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_eip" "spoke_4_WAN2" {
  count = var.create_spoke_4_fgt == "yes" ? 1 : 0
  provider               = aws.spoke_4_vpc
  depends_on        = [aws_instance.spoke_4]
  vpc               = true
  network_interface = aws_network_interface.spoke_4_eth1_wan2[count.index].id

  tags = {
    Name       = "${var.username}_spoke_4_WAN_2"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}