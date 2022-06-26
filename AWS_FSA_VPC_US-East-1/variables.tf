# Access and secret keys to your environment
variable "access_key" {}
variable "secret_key" {}

# AWS Key Name to create Resources
variable "keyname" {}
# FortiGate Username and Password
variable "username" {}
variable "Password" {}

# Region 
variable "virginia_region" {}

# DNS Zone ID
variable "Public_Hosted_Zone" {}
variable "Public_SubHosted_Zone_id" {}
variable "SubHosted_Zone" {}


variable "create_FSA" {}

// Production VPC CIDR

variable "fsa_1_vpc_cidr" {}

// fsa 1 Subnets

variable "fsa_1_public_subnet_cidr" {}

variable "fsa_1_private_subnet_cidr" {}

variable "fsa_1_HA_subnet_cidr" {}

// fsa interfaces IPs 

variable "fsa_1_wan_pvt_ip" {}

variable "fsa_1_lan_pvt_ip" {}

variable "fsa_1_ha_pvt_IP" {}


#FTNT FSA 4.0.0.1 Image
#ami-0ad6237ad99eb11ce

#FSA Private AMI 4.0.0.1 Image 
#ami-0131a9f9b44fd2122

# FSA AMI

variable "FSA_VM_AMI" {
  description = "FortiSandbox AWS(BYOL) - 4.0.1 AMI"
  type        = map
  default = {
    us-east-1 = "ami-0131a9f9b44fd2122"
  }
}



# FSA VM Size

variable "FSA_VM_Size" {
  description = "FSA Instance Size"
  default     = "c5.xlarge"
}

// Dynamic Security Group


variable "FSA_SG_Ingress" {
  description = "Default Security Group used by dynamic ingress block default SG"
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
      port        = 514
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 21
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 3389
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 1344
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 11344
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 0
      proto       = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "FSA_SG_Egress" {
  description = "Default Security Group used by dynamic egress block default SG"
  default = [
    {
      port        = 0
      proto       = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },

  ]
}

