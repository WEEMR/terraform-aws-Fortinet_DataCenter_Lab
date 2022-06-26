resource "aws_eip" "hub_1_WAN1" {
  provider               = aws.virginia
  depends_on        = [aws_instance.hub_1]
  vpc               = true
  network_interface = aws_network_interface.hub_1_eth0_wan1.id

  tags = {
    Name       = "${var.username}_Hub_1_WAN_1"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_eip" "hub_1_WAN2" {
  provider          = aws.virginia
  depends_on        = [aws_instance.hub_1]
  vpc               = true
  network_interface = aws_network_interface.hub_1_eth1_wan2.id

  tags = {
    Name       = "${var.username}_Hub_1_WAN_2"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}