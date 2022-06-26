resource "aws_eip" "hub_2_WAN1" {
  count = var.create_hub_2_fgt == "yes" ? 1 : 0
  provider               = aws.hub_2_vpc
  depends_on        = [aws_instance.hub_2]
  vpc               = true
  network_interface = aws_network_interface.hub_2_eth0_wan1[count.index].id

  tags = {
    Name       = "${var.username}_hub_2_WAN_1"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_eip" "hub_2_WAN2" {
  count = var.create_hub_2_fgt == "yes" ? 1 : 0
  provider          = aws.hub_2_vpc
  depends_on        = [aws_instance.hub_2]
  vpc               = true
  network_interface = aws_network_interface.hub_2_eth1_wan2[count.index].id

  tags = {
    Name       = "${var.username}_hub_2_WAN_2"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}