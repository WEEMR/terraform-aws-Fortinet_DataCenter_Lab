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
variable "create_hub_1_windows" {}        
variable "create_hub_1_linux"   {}
variable "create_hub_1_FMG"     {}
variable "create_hub_1_FAZ"     {}
variable "create_hub_1_FAC"     {}


# DNS Zone ID
variable "Public_SubHosted_Zone_id" {}
variable "SubHosted_Zone" {}

# Global Dependencies

variable "default_SG" {}
variable "Public_SG" {}
variable "Private_SG" {}

# hub 1 Subnet IDs Dependencies

variable "hub_1_wan1_subnet_id" {}

variable "hub_1_wan2_subnet_id" {}

variable "hub_1_private_subnet_id" {}

variable "hub_1_pvt_rt_id" {}

# hub 1 Subnets CIDR Blocks

variable "hub_1_wan1_subnet_cidr" {}

variable "hub_1_wan2_subnet_cidr" {}

variable "hub_1_private_subnet_cidr" {}

# hub 1 Interfaces IPs 

variable "hub_1_wan1_pvt_ip" {}

variable "hub_1_wan2_pvt_ip" {}

variable "hub_1_lan_pvt_IP" {}

# Linux Interface IP 

variable "hub_1_Ubuntu_LAN_IP" {}

# Windows Server Interface IP

variable "hub_1_WinSrv_LAN_IP" {}

# FortiManager Interface IP

variable "hub_1_FMG_LAN_IP" {}

# FortiAnalyzer Interface IP

variable "hub_1_FAZ_LAN_IP" {}

# FortiAuthenticator Interface IP

variable "hub_1_FAC_LAN_IP" {}

# -------------------------------------------------------------- AMIs

variable "FGT_VM_AMI" {}

variable "Ubuntu_WebServer_AMI" {}

variable "WinSrv2019_ami" {}

variable "FMG_VM_AMI" {}

variable "FAZ_VM_AMI" {}

variable "FAC_VM_AMI" {}

# -------------------------------------------------------------- VM Sizes

variable "FGT_VM_Size" {}

variable "Ubuntu_VM_Size" {}

variable "WinSrv_VM_Size" {}

variable "FMG_VM_Size" {}

variable "FAZ_VM_Size" {}

variable "FAC_VM_Size" {}

# -------------------------------------------------------------- FGT Configuration File

variable "hub1_Configurations" {
  type    = string
  default = "hub1_fgtvm.conf"
}

# -------------------------------------------------------------- Windows Server Configuration File

variable "Windows_Server2019_Config" {
  type = string
  default = "WinSrv_conf"
}