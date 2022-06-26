// -------------------------------------------------------------------------------------------------------------  Subnets 

// ------------------------------------------------------------------------------ spoke 1 Subnets

// spoke 1 Public Subnet 1

resource "aws_subnet" "hub_3_wan1_subnet" {
  count = var.create_hub_3_vpc == "yes" ? 1 : 0
  provider          = aws.hub_3_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.hub_3_wan1_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_hub_3_WAN_1"
    reference  = "hub_3_wan1_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// spoke 1 Public Subnet 2

resource "aws_subnet" "hub_3_wan2_subnet" {
  count = var.create_hub_3_vpc == "yes" ? 1 : 0
  provider          = aws.hub_3_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.hub_3_wan2_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_hub_3_WAN_3"
    reference  = "hub_3_wan2_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

// -------------------------- spoke 1 Public Subnets Association with RT

resource "aws_route_table_association" "hub_3_wan1_RT_association" {
  count = var.create_hub_3_vpc == "yes" ? 1 : 0
  provider       = aws.hub_3_vpc
  subnet_id      = aws_subnet.hub_3_wan1_subnet[count.index].id
  route_table_id = aws_default_route_table.public_subnets_RT[count.index].id
}

// Public Subnet 2 Association

resource "aws_route_table_association" "hub_3_wan2_RT_association" {
  count = var.create_hub_3_vpc == "yes" ? 1 : 0
  provider       = aws.hub_3_vpc
  subnet_id      = aws_subnet.hub_3_wan2_subnet[count.index].id
  route_table_id = aws_default_route_table.public_subnets_RT[count.index].id
}


// spoke 1 Private Subnet

resource "aws_subnet" "hub_3_private_subnet" {
  count = var.create_hub_3_vpc == "yes" ? 1 : 0
  provider          = aws.hub_3_vpc
  vpc_id            = aws_vpc.SDWAN_VPC[count.index].id
  cidr_block        = var.hub_3_private_subnet_cidr
  availability_zone = data.aws_availability_zones.AZs.names[0]
  tags = {
    Name       = "${var.username}_Terraform_SDAWN_hub_3_Private_Subnet"
    reference  = "hub_3_private_subnet" 
    Owner      = var.username
    Enviroment = "Terraform Testing"

  }
}

// -------------------------- spoke 1 Private Subnet Association with RT


// Virginia Private Subnet 1 Association 

resource "aws_route_table_association" "hub_3_private_RT_association" {
  count = var.create_hub_3_vpc == "yes" ? 1 : 0
  provider       = aws.hub_3_vpc
  subnet_id      = aws_subnet.hub_3_private_subnet[count.index].id
  route_table_id = aws_route_table.hub_3_pvt_rt[count.index].id
}