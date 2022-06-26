##############################################################################################################
# Production VPC - Hub
##############################################################################################################
resource "aws_vpc" "SDWAN_VPC" {
  count = var.create_hub_3_vpc == "yes" ? 1 : 0
  provider       = aws.hub_3_vpc
  cidr_block           = var.hub_3_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name            = "${var.username}_Terraform_hub_3_Prod_VPC"
    Resources_Owner = var.username
    Enviroment      = "Terraform Production"
  }
}

// Get all avaliable AZ's in the region variable

data "aws_availability_zones" "AZs" {
  provider = aws.hub_3_vpc
  state = "available"
}

# IGW
resource "aws_internet_gateway" "prod_vpc_igw" {
  count = var.create_hub_3_vpc == "yes" ? 1 : 0
  provider       = aws.hub_3_vpc
  vpc_id = aws_vpc.SDWAN_VPC[count.index].id
  tags = {
    Name            = "${var.username}_Terraform_hub_3_Prod_VPC_IGW"
    Resources_Owner = var.username
    Enviroment      = "Terraform Testing"
  }
}