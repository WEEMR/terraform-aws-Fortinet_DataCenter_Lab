// -------------------------------------------------------------------------------------------------------------  Subnets 

// ------------------------------------------------------------------------------ spoke_4 Subnets

// spoke_4 Public Subnet 1

resource "aws_subnet" "spoke_4_wan1_subnet" {
  count = var.create_spoke_4_vpc == "yes" ? 1 : 0
  provider          = aws.spoke_4_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.spoke_4_wan1_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_spoke_4_WAN_1"
    reference  = "spoke_4_wan1_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// spoke_4 Public Subnet 2

resource "aws_subnet" "spoke_4_wan2_subnet" {
  count = var.create_spoke_4_vpc == "yes" ? 1 : 0
  provider          = aws.spoke_4_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.spoke_4_wan2_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_spoke_4_WAN_2"
    reference  = "spoke_4_wan2_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// -------------------------- spoke 2 Public Subnets Association with RT

resource "aws_route_table_association" "spoke_4_wan1_RT_association" {
  count = var.create_spoke_4_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_4_vpc
  subnet_id      = aws_subnet.spoke_4_wan1_subnet[count.index].id
  route_table_id = aws_default_route_table.public_subnets_RT[count.index].id
}

// Public Subnet 2 Association

resource "aws_route_table_association" "spoke_4_wan2_RT_association" {
  count = var.create_spoke_4_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_4_vpc
  subnet_id      = aws_subnet.spoke_4_wan2_subnet[count.index].id
  route_table_id = aws_default_route_table.public_subnets_RT[count.index].id
}


// spoke_4 Private Subnet

resource "aws_subnet" "spoke_4_private_subnet" {
  count = var.create_spoke_4_vpc == "yes" ? 1 : 0
  provider          = aws.spoke_4_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.spoke_4_private_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_spoke_4_Private_Subnet"
    reference  = "spoke_4_private_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"

  }
}

// -------------------------- spoke_4 Private Subnet Association with RT


// Virginia Private Subnet 1 Association 

resource "aws_route_table_association" "spoke_4_private_RT_association" {
  count = var.create_spoke_4_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_4_vpc
  subnet_id      = aws_subnet.spoke_4_private_subnet[count.index].id
  route_table_id = aws_route_table.spoke_4_pvt_rt[count.index].id
}