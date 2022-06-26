// Security Groups


resource "aws_default_security_group" "default_SG" {
  count = var.create_spoke_1_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_1_vpc
  vpc_id = aws_vpc.SDWAN_VPC[count.index].id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name       = "${var.username}_SDWAN_Default_SG"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}


resource "aws_security_group" "Public_SG" {
  count = var.create_spoke_1_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_1_vpc
  name        = "${var.username}_SDWAN_Public_Allow_SG"
  description = "Public Allow traffic"
  vpc_id      = aws_vpc.SDWAN_VPC[count.index].id

  dynamic "ingress" {
    for_each = var.Public_SG
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.username}_SDWAN_Public_Allow_SG"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}

resource "aws_security_group" "Private_SG" {
  count = var.create_spoke_1_vpc == "yes" ? 1 : 0
  provider       = aws.spoke_1_vpc
  name        = "${var.username}_SDWAN_Private_SG"
  description = "Allow all traffic for the Private Subnet"
  vpc_id      = aws_vpc.SDWAN_VPC[count.index].id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "${var.username}_SDWAN_Private_SG"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}