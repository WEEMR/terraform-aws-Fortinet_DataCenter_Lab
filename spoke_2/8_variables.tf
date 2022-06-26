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

#Deployable Devices
variable "create_spoke_2_fgt" {}
variable "create_spoke_2_windows" {}        
variable "create_spoke_2_linux" {}


# DNS Zone ID
variable "Public_SubHosted_Zone_id" {}

# Global Dependencies

variable "default_SG" {}
variable "Public_SG" {}
variable "Private_SG" {}
variable "hub_1_private_subnet_cidr" {}

# spoke 1 Subnet IDs Dependencies

variable "spoke_2_wan1_subnet_id" {}

variable "spoke_2_wan2_subnet_id" {}

variable "spoke_2_private_subnet_id" {}

variable "spoke_2_pvt_rt_id" {}

# spoke 1 Subnets CIDR Blocks

variable "spoke_2_wan1_subnet_cidr" {}

variable "spoke_2_wan2_subnet_cidr" {}

variable "spoke_2_private_subnet_cidr" {}

# spoke 1 Interfaces IPs 

variable "spoke_2_wan1_pvt_ip" {}

variable "spoke_2_wan2_pvt_ip" {}

variable "spoke_2_lan_pvt_IP" {}

# Linux Interface IP 

variable "spoke_2_Ubuntu_LAN_IP" {}

# Windows Server Interface IP

variable "spoke_2_WinSrv_LAN_IP" {}

# FMG and FAZ FQDNs

variable "hub1_FMG_For_Spokes" {}

variable "hub1_FAZ_For_Spokes" {}

# -------------------------------------------------------------- AMIs

variable "FGT_VM_AMI" {}

variable "Ubuntu_WebServer_AMI" {}

variable "WinSrv2019_ami" {}

# -------------------------------------------------------------- VM Sizes

variable "FGT_VM_Size" {}

variable "Ubuntu_VM_Size" {}

variable "WinSrv_VM_Size" {}

# -------------------------------------------------------------- FGT Configuration File

variable "spoke2_Configurations" {
  type    = string
  default = "spoke2_fgtvm.conf"
}

# -------------------------------------------------------------- Windows Server Configuration File

variable "Windows_Server2019_Config" {
  type = string
  default = "WinSrv_conf"
}