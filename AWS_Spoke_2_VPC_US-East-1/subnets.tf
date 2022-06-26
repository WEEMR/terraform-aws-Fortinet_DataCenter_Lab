// -------------------------------------------------------------------------------------------------------------  Subnets 

// ------------------------------------------------------------------------------ spoke 2 Subnets

// spoke 1 Public Subnet 1

resource "aws_subnet" "spoke_2_wan1_subnet" {
  count = var.create_spoke_2_vpc == "yes" ? 1 : 0
  provider          = aws.spoke_2_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.spoke_2_wan1_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_spoke_2_WAN_1"
    reference  = "spoke_2_wan1_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// spoke 1 Public Subnet 2

resource "aws_subnet" "spoke_2_wan2_subnet" {
  count = var.create_spoke_2_vpc == "yes" ? 1 : 0
  provider          = aws.spoke_2_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.spoke_2_wan2_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_spoke_2_WAN_2"
    reference  = "spoke_2_wan2_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// -------------------------- spoke 2 Public Subnets Association with RT

resource "aws_route_table_association" "spoke_2_wan1_RT_association" {
  count = var.create_spoke_2_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_2_vpc
  subnet_id      = aws_subnet.spoke_2_wan1_subnet[count.index].id
  route_table_id = aws_default_route_table.public_subnets_RT[count.index].id
}

// Public Subnet 2 Association

resource "aws_route_table_association" "spoke_2_wan2_RT_association" {
  count = var.create_spoke_2_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_2_vpc
  subnet_id      = aws_subnet.spoke_2_wan2_subnet[count.index].id
  route_table_id = aws_default_route_table.public_subnets_RT[count.index].id
}


// spoke 1 Private Subnet

resource "aws_subnet" "spoke_2_private_subnet" {
  count = var.create_spoke_2_vpc == "yes" ? 1 : 0
  provider          = aws.spoke_2_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.spoke_2_private_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_spoke_2_Private_Subnet"
    reference  = "spoke_2_private_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"

  }
}

// -------------------------- spoke 1 Private Subnet Association with RT


// Virginia Private Subnet 1 Association 

resource "aws_route_table_association" "spoke_2_private_RT_association" {
  count = var.create_spoke_2_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_2_vpc
  subnet_id      = aws_subnet.spoke_2_private_subnet[count.index].id
  route_table_id = aws_route_table.spoke_2_pvt_rt[count.index].id
}