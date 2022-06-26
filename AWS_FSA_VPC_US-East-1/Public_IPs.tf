resource "aws_eip" "fsa_1_wan" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider          = aws.fsa_1_vpc
  depends_on        = [aws_instance.fsa_1]
  vpc               = true
  network_interface = aws_network_interface.fsa_1_eth0_wan[count.index].id

  tags = {
    Name       = "${var.username}_FGT_WAN"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_eip" "nat_gateway_eip" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider          = aws.fsa_1_vpc
  vpc               = true

  tags = {
    Name       = "${var.username}_FGT_WAN"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}