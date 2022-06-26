// Virgina Public Route Table  (Main / Default Route Table)

resource "aws_default_route_table" "public_subnets_RT" {
  count = var.create_hub_2_vpc == "yes" ? 1 : 0
  provider       = aws.hub_2_VPC
  default_route_table_id = aws_vpc.SDWAN_VPC[count.index].default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_vpc_igw[count.index].id
  }

  tags = {
    Name       = "${var.username}_Terraform_hub_2_public_subnets_RT"
    Owner      = var.username
    Enviroment = "Terraform Testing"
    Region     = "US East 1"
  }
}

// hub2 Private Subnet Route Table

resource "aws_route_table" "hub_2_pvt_rt" {
  count = var.create_hub_2_vpc == "yes" ? 1 : 0
  provider       = aws.hub_2_VPC
  vpc_id = aws_vpc.SDWAN_VPC[count.index].id

  tags = {
    Name       = "${var.username}_hub_2_pvt_rt"
    reference  = "hub_2_pvt_rt"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}