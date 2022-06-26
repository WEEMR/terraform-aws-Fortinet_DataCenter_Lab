// -------------------------------------------------------------------------------------------------------------  Subnets 

// ------------------------------------------------------------------------------ fsa 1 Subnets

// fsa 1 Public Subnet 1

resource "aws_subnet" "fsa_1_public_subnet" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider          = aws.fsa_1_vpc
  vpc_id            = aws_vpc.FSA_VPC[count.index].id
  cidr_block        = var.fsa_1_public_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_fsa_1_public_1"
    reference  = "fsa_1_wan1_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// -------------------------- fsa 1 Public Subnet Association with RT

resource "aws_route_table_association" "fsa_1_public_RT_association" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  subnet_id      = aws_subnet.fsa_1_public_subnet[count.index].id
  route_table_id = aws_default_route_table.public_subnet_RT[count.index].id
}



// fsa 1 Public Subnet 2

resource "aws_subnet" "fsa_1_private_subnet" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider          = aws.fsa_1_vpc
  vpc_id            = aws_vpc.FSA_VPC[count.index].id
  cidr_block        = var.fsa_1_private_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_fsa_1_private_subnet"
    reference  = "fsa_1_wan2_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_route_table_association" "fsa_1_private_RT_association" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  subnet_id      = aws_subnet.fsa_1_private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_RT[count.index].id
}


// fsa 1 Private Subnet

resource "aws_subnet" "fsa_1_HA_subnet" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider          = aws.fsa_1_vpc
  vpc_id            = aws_vpc.FSA_VPC[count.index].id
  cidr_block        = var.fsa_1_HA_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_fsa_1_HA_Subnet"
    reference  = "fsa_1_private_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"

  }
}

// -------------------------- fsa 1 HA Subnet Association with RT


// Virginia Private Subnet 1 Association 

resource "aws_route_table_association" "fsa_1_HA_RT_association" {
  count = var.create_FSA == "yes" ? 1 : 0
  provider       = aws.fsa_1_vpc
  subnet_id      = aws_subnet.fsa_1_HA_subnet[count.index].id
  route_table_id = aws_route_table.fsa_1_HA_pvt_rt[count.index].id
}