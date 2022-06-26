##############################################################################################################
#                                                                                                            #
#                                Data Center - Module 1 Terraform deployment                                 #
#                                                                                                            #
##############################################################################################################

# Access and secret keys to your environment

variable "access_key" {}
variable "secret_key" {}

# AWS Key Name to create Resources
variable "keyname" {}

# Devices Username and Password
variable "username" {
  description = "Provide the name of the user who will own the deployed resources"
}
variable "Password" {
    description = "Provide the password which will be used to login to all the deployed resources"
}

// -------------------------------------------------------------------------------- DNS

variable "Public_Hosted_Zone" {}
variable "SubHosted_Zone" {}

// -------------------------------------------------------------------------------- Region

variable "virginia_region" {
  description = "Provide the region to deploy the VPC in"
  default     = "us-east-1"
}


# ------------------------------------------------------------------------------------------------------------

#                                                  FSA 1

# ------------------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------- Hub 1 VPC CIDR Block

variable "fsa_1_vpc_cidr" {
  default = "10.250.0.0/16"
}


// Subnets 

variable "fsa_1_public_subnet_cidr" {
  description = "hub 1 WAN 1 Subnet CIDR Block"
  default     = "10.250.1.0/24"
}

variable "fsa_1_private_subnet_cidr" {
  description = "hub 1 WAN 2 Subnet CIDR Block"
  default     = "10.250.2.0/24"
}

variable "fsa_1_HA_subnet_cidr" {
  description = "hub 1 LAN Subnet CIDR Block"
  default     = "10.250.3.0/24"
}


// FSA IPs

variable "fsa_1_wan_pvt_ip" {
  description = "hub 1 WAN 1 Interface IP"
  default     = ["10.250.1.10"]
}

variable "fsa_1_lan_pvt_ip" {
  description = "hub 1 WAN 2 Interface IP"
  default     = ["10.250.2.10"]
}

variable "fsa_1_ha_pvt_IP" {
  description = "hub 1 LAN Interface IP"
  default     = ["10.250.3.10"]
}


#Deployable Devices

variable "create_FSA" {}


# ------------------------------------------------------------------------------------------------------------

#                                                  Hub 1

# ------------------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------- Hub 1 VPC CIDR Block

variable "hub_1_vpc_cidr" {
  default = "10.100.0.0/16"
}


// Subnets 

variable "hub_1_wan1_subnet_cidr" {
  description = "hub 1 WAN 1 Subnet CIDR Block"
  default     = "10.100.1.0/24"
}

variable "hub_1_wan2_subnet_cidr" {
  description = "hub 1 WAN 2 Subnet CIDR Block"
  default     = "10.100.2.0/24"
}

variable "hub_1_private_subnet_cidr" {
  description = "hub 1 LAN Subnet CIDR Block"
  default     = "10.100.10.0/24"
}


// FGT IPs

variable "hub_1_wan1_pvt_ip" {
  description = "hub 1 WAN 1 Interface IP"
  default     = ["10.100.1.10"]
}

variable "hub_1_wan2_pvt_ip" {
  description = "hub 1 WAN 2 Interface IP"
  default     = ["10.100.2.10"]
}

variable "hub_1_lan_pvt_IP" {
  description = "hub 1 LAN Interface IP"
  default     = ["10.100.10.10"]
}

# Ubuntu

variable "hub_1_Ubuntu_LAN_IP" {
  description = "hub 1 Ubunutu IP"
  default     = ["10.100.10.20"]
}

# Windows

variable "hub_1_WinSrv_LAN_IP" {
  description = "hub 1 Windows Server 2019 IP"
  default     = ["10.100.10.25"]
}

# FortiManager

variable "hub_1_FMG_LAN_IP" {
  description = "hub 1 FortiManager IP"
  default     = ["10.100.10.30"]
}

# FortiAnalyzer

variable "hub_1_FAZ_LAN_IP" {
  description = "hub 1 FortiAnalyzer IP"
  default     = ["10.100.10.40"]
}

# FortiAuthenticator

variable "hub_1_FAC_LAN_IP" {
  description = "hub 1 FortiAuthenticator IP"
  default     = ["10.100.10.50"]
}

# Deployable Devices
variable "create_hub_1_windows" {}
variable "create_hub_1_linux"   {}
variable "create_hub_1_FMG"     {}
variable "create_hub_1_FAZ"     {}
variable "create_hub_1_FAC"     {}


# ------------------------------------------------------------------------------------------------------------

#                                                  hub 2

# ------------------------------------------------------------------------------------------------------------

// hub 2 VPC CIDR Block

variable "hub_2_vpc_cidr" {
  default = "10.200.0.0/16"
}


// Subnets 

variable "hub_2_wan1_subnet_cidr" {
  description = "hub 2 WAN 1 Subnet CIDR Block"
  default     = "10.200.1.0/24"
}

variable "hub_2_wan2_subnet_cidr" {
  description = "hub 2 WAN 2 Subnet CIDR Block"
  default     = "10.200.2.0/24"
}

variable "hub_2_private_subnet_cidr" {
  description = "hub 2 LAN Subnet CIDR Block"
  default     = "10.200.10.0/24"
}


// FGT IPs

variable "hub_2_wan1_pvt_ip" {
  description = "hub 2 WAN 1 Interface IP"
  default     = ["10.200.1.10"]
}

variable "hub_2_wan2_pvt_ip" {
  description = "hub 2 WAN 2 Interface IP"
  default     = ["10.200.2.10"]
}

variable "hub_2_lan_pvt_IP" {
  description = "hub 2 LAN Interface IP"
  default     = ["10.200.10.10"]
}

# Ubuntu

variable "hub_2_Ubuntu_LAN_IP" {
  description = "hub 2 Ubunutu IP"
  default     = ["10.200.10.20"]
}

# Windows

variable "hub_2_WinSrv_LAN_IP" {
  description = "hub 2 Windows Server 2019 IP"
  default     = ["10.200.10.25"]
}

#Deployable Devices
variable "create_hub_2_vpc" {}
variable "create_hub_2_fgt" {}
variable "create_hub_2_windows" {}        
variable "create_hub_2_linux" {}


# ------------------------------------------------------------------------------------------------------------

#                                                  Hub 3

# ------------------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------- Hub 2 VPC CIDR Block

variable "hub_3_vpc_cidr" {
  default = "10.250.0.0/16"
}


// Subnets 

variable "hub_3_wan1_subnet_cidr" {
  description = "spoke 1 WAN 1 Subnet CIDR Block"
  default     = "10.250.1.0/24"
}

variable "hub_3_wan2_subnet_cidr" {
  description = "spoke 1 WAN 2 Subnet CIDR Block"
  default     = "10.250.2.0/24"
}

variable "hub_3_private_subnet_cidr" {
  description = "spoke 1 LAN Subnet CIDR Block"
  default     = "10.250.10.0/24"
}


// FGT IPs

variable "hub_3_wan1_pvt_ip" {
  description = "spoke 1 WAN 1 Interface IP"
  default     = ["10.250.1.10"]
}

variable "hub_3_wan2_pvt_ip" {
  description = "spoke 1 WAN 2 Interface IP"
  default     = ["10.250.2.10"]
}

variable "hub_3_lan_pvt_IP" {
  description = "spoke 1 LAN Interface IP"
  default     = ["10.250.10.10"]
}

# Ubuntu

variable "hub_3_Ubuntu_LAN_IP" {
  description = "spoke 1 Ubunutu IP"
  default     = ["10.250.10.20"]
}

# Windows

variable "hub_3_WinSrv_LAN_IP" {
  description = "spoke 1 Windows Server 2019 IP"
  default     = ["10.250.10.25"]
}

#Deployable Devices
variable "create_hub_3_vpc" {}
variable "create_hub_3_fgt" {}
variable "create_hub_3_windows" {}        
variable "create_hub_3_linux" {}

# ------------------------------------------------------------------------------------------------------------

#                                                  spoke 1

# ------------------------------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------- Spoke 1 VPC CIDR Block

variable "spoke_1_vpc_cidr" {
  default = "10.1.0.0/16"
}


// Subnets 

variable "spoke_1_wan1_subnet_cidr" {
  description = "spoke 1 WAN 1 Subnet CIDR Block"
  default     = "10.1.1.0/24"
}

variable "spoke_1_wan2_subnet_cidr" {
  description = "spoke 1 WAN 2 Subnet CIDR Block"
  default     = "10.1.2.0/24"
}

variable "spoke_1_private_subnet_cidr" {
  description = "spoke 1 LAN Subnet CIDR Block"
  default     = "10.1.10.0/24"
}


// FGT IPs

variable "spoke_1_wan1_pvt_ip" {
  description = "spoke 1 WAN 1 Interface IP"
  default     = ["10.1.1.10"]
}

variable "spoke_1_wan2_pvt_ip" {
  description = "spoke 1 WAN 2 Interface IP"
  default     = ["10.1.2.10"]
}

variable "spoke_1_lan_pvt_IP" {
  description = "spoke 1 LAN Interface IP"
  default     = ["10.1.10.10"]
}

# Ubuntu

variable "spoke_1_Ubuntu_LAN_IP" {
  description = "spoke 1 Ubunutu IP"
  default     = ["10.1.10.20"]
}

# Windows

variable "spoke_1_WinSrv_LAN_IP" {
  description = "spoke 1 Windows Server 2019 IP"
  default     = ["10.1.10.25"]
}

#Deployable Devices
variable "create_spoke_1_vpc" {}
variable "create_spoke_1_fgt" {}
variable "create_spoke_1_windows" {}        
variable "create_spoke_1_linux" {}

# ------------------------------------------------------------------------------------------------------------

#                                                  spoke 2

# ------------------------------------------------------------------------------------------------------------

// Spoke 2 VPC CIDR Block

variable "spoke_2_vpc_cidr" {
  default = "10.2.0.0/16"
}


// Subnets 

variable "spoke_2_wan1_subnet_cidr" {
  description = "spoke 2 WAN 1 Subnet CIDR Block"
  default     = "10.2.1.0/24"
}

variable "spoke_2_wan2_subnet_cidr" {
  description = "spoke 2 WAN 2 Subnet CIDR Block"
  default     = "10.2.2.0/24"
}

variable "spoke_2_private_subnet_cidr" {
  description = "spoke 2 LAN Subnet CIDR Block"
  default     = "10.2.10.0/24"
}


// FGT IPs

variable "spoke_2_wan1_pvt_ip" {
  description = "spoke 1 WAN 1 Interface IP"
  default     = ["10.2.1.10"]
}

variable "spoke_2_wan2_pvt_ip" {
  description = "spoke 1 WAN 2 Interface IP"
  default     = ["10.2.2.10"]
}

variable "spoke_2_lan_pvt_IP" {
  description = "spoke 1 LAN Interface IP"
  default     = ["10.2.10.10"]
}

# Ubuntu

variable "spoke_2_Ubuntu_LAN_IP" {
  description = "spoke 2 Ubunutu IP"
  default     = ["10.2.10.20"]
}

# Windows

variable "spoke_2_WinSrv_LAN_IP" {
  description = "spoke 2 Windows Server 2019 IP"
  default     = ["10.2.10.25"]
}

#Deployable Devices
variable "create_spoke_2_vpc" {}
variable "create_spoke_2_fgt" {}
variable "create_spoke_2_windows" {}        
variable "create_spoke_2_linux" {}

# ------------------------------------------------------------------------------------------------------------

#                                                  spoke 3

# ------------------------------------------------------------------------------------------------------------

// Spoke 3 VPC CIDR Block

variable "spoke_3_vpc_cidr" {
  default = "10.3.0.0/16"
}


// Subnets 

variable "spoke_3_wan1_subnet_cidr" {
  description = "spoke 3 WAN 1 Subnet CIDR Block"
  default     = "10.3.1.0/24"
}

variable "spoke_3_wan2_subnet_cidr" {
  description = "spoke 3 WAN 2 Subnet CIDR Block"
  default     = "10.3.2.0/24"
}

variable "spoke_3_private_subnet_cidr" {
  description = "spoke 3 LAN Subnet CIDR Block"
  default     = "10.3.10.0/24"
}


// FGT IPs

variable "spoke_3_wan1_pvt_ip" {
  description = "spoke 1 WAN 1 Interface IP"
  default     = ["10.3.1.10"]
}

variable "spoke_3_wan2_pvt_ip" {
  description = "spoke 1 WAN 2 Interface IP"
  default     = ["10.3.2.10"]
}

variable "spoke_3_lan_pvt_IP" {
  description = "spoke 1 LAN Interface IP"
  default     = ["10.3.10.10"]
}

# Ubuntu

variable "spoke_3_Ubuntu_LAN_IP" {
  description = "spoke 3 Ubunutu IP"
  default     = ["10.3.10.30"]
}

# Windows

variable "spoke_3_WinSrv_LAN_IP" {
  description = "spoke 3 Windows Server 2019 IP"
  default     = ["10.3.10.35"]
}

#Deployable Devices
variable "create_spoke_3_vpc" {}
variable "create_spoke_3_fgt" {}
variable "create_spoke_3_windows" {}        
variable "create_spoke_3_linux" {}

# ------------------------------------------------------------------------------------------------------------

#                                                  spoke 4

# ------------------------------------------------------------------------------------------------------------

// spoke 4 VPC CIDR Block

variable "spoke_4_vpc_cidr" {
  default = "10.3.0.0/16"
}


// Subnets 

variable "spoke_4_wan1_subnet_cidr" {
  description = "spoke 4 WAN 1 Subnet CIDR Block"
  default     = "10.3.1.0/24"
}

variable "spoke_4_wan2_subnet_cidr" {
  description = "spoke 4 WAN 2 Subnet CIDR Block"
  default     = "10.3.2.0/24"
}

variable "spoke_4_private_subnet_cidr" {
  description = "spoke 4 LAN Subnet CIDR Block"
  default     = "10.3.10.0/24"
}


// FGT IPs

variable "spoke_4_wan1_pvt_ip" {
  description = "spoke 4 WAN 1 Interface IP"
  default     = ["10.3.1.10"]
}

variable "spoke_4_wan2_pvt_ip" {
  description = "spoke 4 WAN 2 Interface IP"
  default     = ["10.3.2.10"]
}

variable "spoke_4_lan_pvt_IP" {
  description = "spoke 4 LAN Interface IP"
  default     = ["10.3.10.10"]
}

# Ubuntu

variable "spoke_4_Ubuntu_LAN_IP" {
  description = "spoke 4 Ubunutu IP"
  default     = ["10.3.10.30"]
}

# Windows

variable "spoke_4_WinSrv_LAN_IP" {
  description = "spoke 4 Windows Server 2019 IP"
  default     = ["10.3.10.35"]
}

#Deployable Devices
variable "create_spoke_4_vpc" {}
variable "create_spoke_4_fgt" {}
variable "create_spoke_4_windows" {}        
variable "create_spoke_4_linux" {}


# ------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------

# -------------------------------------------------------------- AMIs

# FortiGate AMI

variable "FGT_VM_AMI" {
  description = "Public - 7.2.0 AMI"
  type        = map
  default = {
    us-east-1 = "ami-035a7ca1d22b2ac60"
  }
}

// Ubuntu 20.04 LTS
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

data "aws_ami" "latest_windows" {
  most_recent = true
  owners = ["801119661308"] # Amazon

  filter {
      name   = "name"
      values = ["Windows_Server-2022-*"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}


// AMIs are for Private FMG AWS - 7.0.1
variable "FMG_VM_AMI" {
  description = "Private - 7.0.1 AMI"
  type        = map
  default = {
    us-east-1 = "ami-01d340da51db3d804"
  }
}

// AMIs are for Private FAZ AWS - 7.0.1
variable "FAZ_VM_AMI" {
  description = "Private - 7.0.1 AMI"
  type        = map
  default = {
    us-east-1 = "ami-0da8f94dae97a1eec"
  }
}

// AMIs are for Private FAC AWS - 6.2.1
variable "FAC_VM_AMI" {
  description = "Private - 6.2.1 AMI"
  type        = map
  default = {
    us-east-1 = "ami-0956365e8654cd250"
  }
}

# -------------------------------------------------------------- VM Sizes

# FortiGate VM Size

variable "FGT_VM_Size" {
  description = "FGT Instance Size"
  default     = "t3.small"
}

# Ubuntu VM Size

variable "Ubuntu_VM_Size" {
  description = "Ubuntu Instance Size"
  default     = "t3.micro"
}

# Windows VM Size

variable "WinSrv_VM_Size" {
  description = "Windows Server Instance Size"
  default     = "t3.medium"
}

# FortiManager VM Size

variable "FMG_VM_Size" {
  description = "FMG Instance Size"
  default     = "m5.large"
}

# FortiAnalyzer VM Size

variable "FAZ_VM_Size" {
  description = "FAZ Instance Size"
  default     = "t3.large"
}

# FortiAuthenticator VM Size

variable "FAC_VM_Size" {
  description = "FAC Instance Size"
  default     = "t2.small"
}

