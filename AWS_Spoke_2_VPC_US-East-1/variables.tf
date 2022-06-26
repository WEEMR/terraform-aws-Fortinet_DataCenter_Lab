# Access and secret keys to your environment
variable "access_key" {}
variable "secret_key" {}


variable "username" {}
variable "virginia_region" {}

variable "Public_Hosted_Zone" {}
variable "SubHosted_Zone" {}

variable "create_spoke_2_vpc" {}

// Production VPC CIDR

variable "spoke_2_vpc_cidr" {}

// Spoke 1 Subnets

variable "spoke_2_wan1_subnet_cidr" {}

variable "spoke_2_wan2_subnet_cidr" {}

variable "spoke_2_private_subnet_cidr" {}


// Dynamic Security Group


variable "Public_SG" {
  description = "Public Security Group used by dynamic block at network.tf"
  default = [
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 8443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 10443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 80
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 2222
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 541
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 0
      proto       = "1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
