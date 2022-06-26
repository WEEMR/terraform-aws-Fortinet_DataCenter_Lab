// Virgina Public Route Table  (Main / Default Route Table)

resource "aws_default_route_table" "public_subnet_RT" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  default_route_table_id = aws_vpc.FSA_VPC[count.index].default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.FSA_vpc_igw[count.index].id
  }

  tags = {
    Name       = "${var.username}_Terraform_fsa_1_public_subnets_RT"
    Owner      = var.username
    Enviroment = "Terraform Testing"
    Region     = "US East 1"
  }
}



resource "aws_route_table" "private_subnet_RT" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  vpc_id = aws_vpc.FSA_VPC[count.index].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.FSA_LAN_NATGW[count.index].id
  }

  tags = {
    Name       = "${var.username}_Terraform_fsa_1_private_subnets_RT"
    Owner      = var.username
    Enviroment = "Terraform Testing"
    Region     = "US East 1"
  }
}

// fsa 1 Private Subnet Route Table

resource "aws_route_table" "fsa_1_HA_pvt_rt" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  vpc_id = aws_vpc.FSA_VPC[count.index].id

  tags = {
    Name       = "${var.username}_fsa_1_HA_pvt_rt"
    reference  = "fsa_1_HA_pvt_rt"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}