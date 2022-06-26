module "FSA_1" {
  source                       = "./AWS_FSA_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  Password                     = var.Password
  keyname                      = var.keyname
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone
  Public_SubHosted_Zone_id     = module.Hub_1_Prod_VPC.Public_SubHosted_Zone_id
  create_FSA                   = var.create_FSA


  # VPC CIDR & Subnets

  fsa_1_vpc_cidr                = var.fsa_1_vpc_cidr
  # FSA 1
  fsa_1_public_subnet_cidr      = var.fsa_1_public_subnet_cidr
  fsa_1_private_subnet_cidr      = var.fsa_1_private_subnet_cidr
  fsa_1_HA_subnet_cidr        = var.fsa_1_HA_subnet_cidr

  # FSA Interface IPs

  fsa_1_wan_pvt_ip            = var.fsa_1_wan_pvt_ip
  fsa_1_lan_pvt_ip            = var.fsa_1_lan_pvt_ip
  fsa_1_ha_pvt_IP             = var.fsa_1_ha_pvt_IP
}

module "Hub_1_Prod_VPC" {
  source                       = "./AWS_Hub_1_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone

  # VPC CIDR & Subnets

  hub_1_vpc_cidr               = var.hub_1_vpc_cidr
  hub_1_wan1_subnet_cidr       = var.hub_1_wan1_subnet_cidr
  hub_1_wan2_subnet_cidr       = var.hub_1_wan2_subnet_cidr
  hub_1_private_subnet_cidr    = var.hub_1_private_subnet_cidr
}

module "hub_1" {
  source                       = "./hub_1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key

  SubHosted_Zone               = var.SubHosted_Zone

  # Deployable Devices
  
  create_hub_1_windows           = var.create_hub_1_windows
  create_hub_1_linux             = var.create_hub_1_linux
  create_hub_1_FMG               = var.create_hub_1_FMG
  create_hub_1_FAZ               = var.create_hub_1_FAZ
  create_hub_1_FAC               = var.create_hub_1_FAC


  # Global dependencies

  username                     = var.username
  Password                     = var.Password
  keyname                      = var.keyname
  virginia_region              = var.virginia_region
  Public_SubHosted_Zone_id     = module.Hub_1_Prod_VPC.Public_SubHosted_Zone_id
  #spoke_1_private_subnet_cidr  = var.spoke_1_private_subnet_cidr

  # Security Groups 
  
  default_SG                   = module.Hub_1_Prod_VPC.default_SG
  Public_SG                    = module.Hub_1_Prod_VPC.Public_SG
  Private_SG                   = module.Hub_1_Prod_VPC.Private_SG
  
  # hub 1 Specific dependencies

  hub_1_wan1_subnet_cidr       = var.hub_1_wan1_subnet_cidr
  hub_1_wan2_subnet_cidr       = var.hub_1_wan2_subnet_cidr
  hub_1_private_subnet_cidr    = var.hub_1_private_subnet_cidr

  hub_1_wan1_subnet_id         = module.Hub_1_Prod_VPC.hub_1_wan1_subnet_id
  hub_1_wan2_subnet_id         = module.Hub_1_Prod_VPC.hub_1_wan2_subnet_id
  hub_1_private_subnet_id      = module.Hub_1_Prod_VPC.hub_1_private_subnet_id
  hub_1_pvt_rt_id              = module.Hub_1_Prod_VPC.hub_1_pvt_rt_id


  # FGT, Ubuntu, Windows and FMG Private IPs

  hub_1_wan1_pvt_ip              = var.hub_1_wan1_pvt_ip
  hub_1_wan2_pvt_ip              = var.hub_1_wan2_pvt_ip
  hub_1_lan_pvt_IP               = var.hub_1_lan_pvt_IP
  hub_1_Ubuntu_LAN_IP            = var.hub_1_Ubuntu_LAN_IP
  hub_1_WinSrv_LAN_IP            = var.hub_1_WinSrv_LAN_IP
  hub_1_FMG_LAN_IP               = var.hub_1_FMG_LAN_IP
  hub_1_FAZ_LAN_IP               = var.hub_1_FAZ_LAN_IP
  hub_1_FAC_LAN_IP               = var.hub_1_FAC_LAN_IP


  # AMIs

  FGT_VM_AMI                    = var.FGT_VM_AMI
  Ubuntu_WebServer_AMI          = data.aws_ami.latest_ubuntu.id
  WinSrv2019_ami                = data.aws_ami.latest_windows.id
  FMG_VM_AMI                    = var.FMG_VM_AMI
  FAZ_VM_AMI                    = var.FAZ_VM_AMI
  FAC_VM_AMI                    = var.FAC_VM_AMI

  # EC2 Instances Sizes

  FGT_VM_Size                 = var.FGT_VM_Size
  Ubuntu_VM_Size              = var.Ubuntu_VM_Size
  WinSrv_VM_Size              = var.WinSrv_VM_Size
  FMG_VM_Size                 = var.FMG_VM_Size
  FAZ_VM_Size                 = var.FAZ_VM_Size
  FAC_VM_Size                 = var.FAC_VM_Size

}

module "hub_2_Prod_VPC" {
  #count = var.create_hub_2_vpc == "yes" ? 1 : 0

  source                       = "./AWS_hub_2_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone

  # VPC CIDR & Subnets

  hub_2_vpc_cidr               = var.hub_2_vpc_cidr
  hub_2_wan1_subnet_cidr       = var.hub_2_wan1_subnet_cidr
  hub_2_wan2_subnet_cidr       = var.hub_2_wan2_subnet_cidr
  hub_2_private_subnet_cidr    = var.hub_2_private_subnet_cidr

  # Deploy VPC
  create_hub_2_vpc    = var.create_hub_2_vpc
}

module "hub_2" {
  #count = var.create_hub_2_vpc == "yes" ? 1 : 0
  source                       = "./hub_2"
  access_key                   = var.access_key
  secret_key                   = var.secret_key

  # Deployable Devices

  create_hub_2_fgt               = var.create_hub_2_fgt
  create_hub_2_windows           = var.create_hub_2_windows
  create_hub_2_linux             = var.create_hub_2_linux

  # Global dependencies

  username                     = var.username
  Password                     = var.Password
  keyname                      = var.keyname
  virginia_region              = var.virginia_region
  Public_SubHosted_Zone_id       = module.Hub_1_Prod_VPC.Public_SubHosted_Zone_id
  hub1_FMG_For_Spokes            = module.hub_1.hub1_FMG_For_Spokes
  hub1_FAZ_For_Spokes            = module.hub_1.hub1_FAZ_For_Spokes

  # Security Groups 
  
  default_SG                   = module.hub_2_Prod_VPC.default_SG
  Public_SG                    = module.hub_2_Prod_VPC.Public_SG
  Private_SG                   = module.hub_2_Prod_VPC.Private_SG
  
  # hub 2 Specific dependencies

  hub_2_wan1_subnet_cidr       = var.hub_2_wan1_subnet_cidr
  hub_2_wan2_subnet_cidr       = var.hub_2_wan2_subnet_cidr
  hub_2_private_subnet_cidr    = var.hub_2_private_subnet_cidr

  hub_2_wan1_subnet_id         = module.hub_2_Prod_VPC.hub_2_wan1_subnet_id
  hub_2_wan2_subnet_id         = module.hub_2_Prod_VPC.hub_2_wan2_subnet_id
  hub_2_private_subnet_id      = module.hub_2_Prod_VPC.hub_2_private_subnet_id
  hub_2_pvt_rt_id              = module.hub_2_Prod_VPC.hub_2_pvt_rt_id


  # FGT, Ubuntu, Windows and FMG Private IPs

  hub_2_wan1_pvt_ip              = var.hub_2_wan1_pvt_ip
  hub_2_wan2_pvt_ip              = var.hub_2_wan2_pvt_ip
  hub_2_lan_pvt_IP               = var.hub_2_lan_pvt_IP
  hub_2_Ubuntu_LAN_IP            = var.hub_2_Ubuntu_LAN_IP
  hub_2_WinSrv_LAN_IP            = var.hub_2_WinSrv_LAN_IP


  # AMIs

  FGT_VM_AMI                    = var.FGT_VM_AMI
  Ubuntu_WebServer_AMI          = data.aws_ami.latest_ubuntu.id
  WinSrv2019_ami                = data.aws_ami.latest_windows.id

  # EC2 Instances Sizes

  FGT_VM_Size                 = var.FGT_VM_Size
  Ubuntu_VM_Size              = var.Ubuntu_VM_Size
  WinSrv_VM_Size              = var.WinSrv_VM_Size
  FMG_VM_Size                 = var.FMG_VM_Size

}

# ---------------------------

module "Hub_3_Prod_VPC" {
  source                       = "./AWS_Hub_3_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone

  # VPC CIDR & Subnets

  hub_3_vpc_cidr                = var.hub_3_vpc_cidr

  # Spoke 1
  hub_3_wan1_subnet_cidr     = var.hub_3_wan1_subnet_cidr
  hub_3_wan2_subnet_cidr     = var.hub_3_wan2_subnet_cidr
  hub_3_private_subnet_cidr  = var.hub_3_private_subnet_cidr

  # Deploy VPC
  create_hub_3_vpc    = var.create_hub_3_vpc
}

module "hub_3" {
  source                         = "./hub_3"
  access_key                     = var.access_key
  secret_key                     = var.secret_key

  # Deployable Devices

  create_hub_3_fgt               = var.create_hub_3_fgt
  create_hub_3_windows           = var.create_hub_3_windows
  create_hub_3_linux             = var.create_hub_3_linux

  # Global dependencies

  username                       = var.username
  Password                       = var.Password
  keyname                        = var.keyname
  virginia_region                = var.virginia_region
  Public_SubHosted_Zone_id       = module.Hub_1_Prod_VPC.Public_SubHosted_Zone_id
  hub1_FMG_For_Spokes            = module.hub_1.hub1_FMG_For_Spokes
  hub_1_private_subnet_cidr      = var.hub_1_private_subnet_cidr

  # Security Groups 
  
  default_SG                     = module.Hub_3_Prod_VPC.default_SG
  Public_SG                      = module.Hub_3_Prod_VPC.Public_SG
  Private_SG                     = module.Hub_3_Prod_VPC.Private_SG
  
  # spoke 1 Specific dependencies

  hub_3_wan1_subnet_cidr       = var.hub_3_wan1_subnet_cidr
  hub_3_wan2_subnet_cidr       = var.hub_3_wan2_subnet_cidr
  hub_3_private_subnet_cidr    = var.hub_3_private_subnet_cidr

  hub_3_wan1_subnet_id         = module.Hub_3_Prod_VPC.hub_3_wan1_subnet_id
  hub_3_wan2_subnet_id         = module.Hub_3_Prod_VPC.hub_3_wan2_subnet_id
  hub_3_private_subnet_id      = module.Hub_3_Prod_VPC.hub_3_private_subnet_id
  hub_3_pvt_rt_id              = module.Hub_3_Prod_VPC.hub_3_pvt_rt_id


  # FGT, Ubuntu, Windows and FMG Private IPs

  hub_3_wan1_pvt_ip            = var.hub_3_wan1_pvt_ip
  hub_3_wan2_pvt_ip            = var.hub_3_wan2_pvt_ip
  hub_3_lan_pvt_IP             = var.hub_3_lan_pvt_IP
  hub_3_Ubuntu_LAN_IP          = var.hub_3_Ubuntu_LAN_IP
  hub_3_WinSrv_LAN_IP          = var.hub_3_WinSrv_LAN_IP


  # AMIs

  FGT_VM_AMI                    = var.FGT_VM_AMI
  Ubuntu_WebServer_AMI          = data.aws_ami.latest_ubuntu.id
  WinSrv2019_ami                = data.aws_ami.latest_windows.id

  # EC2 Instances Sizes

  FGT_VM_Size                 = var.FGT_VM_Size
  Ubuntu_VM_Size              = var.Ubuntu_VM_Size
  WinSrv_VM_Size              = var.WinSrv_VM_Size

}


module "Spoke_1_Prod_VPC" {
  source                       = "./AWS_Spoke_1_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone

  # VPC CIDR & Subnets

  spoke_1_vpc_cidr                = var.spoke_1_vpc_cidr

  # Spoke 1
  spoke_1_wan1_subnet_cidr     = var.spoke_1_wan1_subnet_cidr
  spoke_1_wan2_subnet_cidr     = var.spoke_1_wan2_subnet_cidr
  spoke_1_private_subnet_cidr  = var.spoke_1_private_subnet_cidr

  # Deploy VPC
  create_spoke_1_vpc    = var.create_spoke_1_vpc
}

module "spoke_1" {
  source                         = "./spoke_1"
  access_key                     = var.access_key
  secret_key                     = var.secret_key

  # Deployable Devices
  create_spoke_1_fgt               = var.create_spoke_1_fgt
  create_spoke_1_windows           = var.create_spoke_1_windows
  create_spoke_1_linux             = var.create_spoke_1_linux

  # Global dependencies

  username                       = var.username
  Password                       = var.Password
  keyname                        = var.keyname
  virginia_region                = var.virginia_region
  Public_SubHosted_Zone_id       = module.Hub_1_Prod_VPC.Public_SubHosted_Zone_id
  hub1_FMG_For_Spokes            = module.hub_1.hub1_FMG_For_Spokes
  hub1_FAZ_For_Spokes            = module.hub_1.hub1_FAZ_For_Spokes
  hub_1_private_subnet_cidr      = var.hub_1_private_subnet_cidr

  # Security Groups 
  
  default_SG                     = module.Spoke_1_Prod_VPC.default_SG
  Public_SG                      = module.Spoke_1_Prod_VPC.Public_SG
  Private_SG                     = module.Spoke_1_Prod_VPC.Private_SG
  
  # spoke 1 Specific dependencies

  spoke_1_wan1_subnet_cidr       = var.spoke_1_wan1_subnet_cidr
  spoke_1_wan2_subnet_cidr       = var.spoke_1_wan2_subnet_cidr
  spoke_1_private_subnet_cidr    = var.spoke_1_private_subnet_cidr

  spoke_1_wan1_subnet_id         = module.Spoke_1_Prod_VPC.spoke_1_wan1_subnet_id
  spoke_1_wan2_subnet_id         = module.Spoke_1_Prod_VPC.spoke_1_wan2_subnet_id
  spoke_1_private_subnet_id      = module.Spoke_1_Prod_VPC.spoke_1_private_subnet_id
  spoke_1_pvt_rt_id              = module.Spoke_1_Prod_VPC.spoke_1_pvt_rt_id


  # FGT, Ubuntu, Windows and FMG Private IPs

  spoke_1_wan1_pvt_ip            = var.spoke_1_wan1_pvt_ip
  spoke_1_wan2_pvt_ip            = var.spoke_1_wan2_pvt_ip
  spoke_1_lan_pvt_IP             = var.spoke_1_lan_pvt_IP
  spoke_1_Ubuntu_LAN_IP          = var.spoke_1_Ubuntu_LAN_IP
  spoke_1_WinSrv_LAN_IP          = var.spoke_1_WinSrv_LAN_IP


  # AMIs

  FGT_VM_AMI                    = var.FGT_VM_AMI
  Ubuntu_WebServer_AMI          = data.aws_ami.latest_ubuntu.id
  WinSrv2019_ami                = data.aws_ami.latest_windows.id

  # EC2 Instances Sizes

  FGT_VM_Size                 = var.FGT_VM_Size
  Ubuntu_VM_Size              = var.Ubuntu_VM_Size
  WinSrv_VM_Size              = var.WinSrv_VM_Size

}

module "Spoke_2_Prod_VPC" {
  source                       = "./AWS_Spoke_2_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone

  # VPC CIDR & Subnets

  spoke_2_vpc_cidr                = var.spoke_2_vpc_cidr

  # Spoke 1
  spoke_2_wan1_subnet_cidr     = var.spoke_2_wan1_subnet_cidr
  spoke_2_wan2_subnet_cidr     = var.spoke_2_wan2_subnet_cidr
  spoke_2_private_subnet_cidr  = var.spoke_2_private_subnet_cidr

  # Deploy VPC
  create_spoke_2_vpc    = var.create_spoke_2_vpc
}

module "spoke_2" {
  source                         = "./spoke_2"
  access_key                     = var.access_key
  secret_key                     = var.secret_key

  # Deployable Devices
  create_spoke_2_fgt               = var.create_spoke_2_fgt
  create_spoke_2_windows           = var.create_spoke_2_windows
  create_spoke_2_linux             = var.create_spoke_2_linux

  # Global dependencies

  username                       = var.username
  Password                       = var.Password
  keyname                        = var.keyname
  virginia_region                = var.virginia_region
  Public_SubHosted_Zone_id       = module.Hub_1_Prod_VPC.Public_SubHosted_Zone_id
  hub1_FMG_For_Spokes            = module.hub_1.hub1_FMG_For_Spokes
  hub1_FAZ_For_Spokes            = module.hub_1.hub1_FAZ_For_Spokes
  hub_1_private_subnet_cidr      = var.hub_1_private_subnet_cidr

  # Security Groups 
  
  default_SG                     = module.Spoke_2_Prod_VPC.default_SG
  Public_SG                      = module.Spoke_2_Prod_VPC.Public_SG
  Private_SG                     = module.Spoke_2_Prod_VPC.Private_SG
  
  # spoke 2 Specific dependencies

  spoke_2_wan1_subnet_cidr       = var.spoke_2_wan1_subnet_cidr
  spoke_2_wan2_subnet_cidr       = var.spoke_2_wan2_subnet_cidr
  spoke_2_private_subnet_cidr    = var.spoke_2_private_subnet_cidr

  spoke_2_wan1_subnet_id         = module.Spoke_2_Prod_VPC.spoke_2_wan1_subnet_id
  spoke_2_wan2_subnet_id         = module.Spoke_2_Prod_VPC.spoke_2_wan2_subnet_id
  spoke_2_private_subnet_id      = module.Spoke_2_Prod_VPC.spoke_2_private_subnet_id
  spoke_2_pvt_rt_id              = module.Spoke_2_Prod_VPC.spoke_2_pvt_rt_id


  # FGT, Ubuntu, Windows and FMG Private IPs

  spoke_2_wan1_pvt_ip            = var.spoke_2_wan1_pvt_ip
  spoke_2_wan2_pvt_ip            = var.spoke_2_wan2_pvt_ip
  spoke_2_lan_pvt_IP             = var.spoke_2_lan_pvt_IP
  spoke_2_Ubuntu_LAN_IP          = var.spoke_2_Ubuntu_LAN_IP
  spoke_2_WinSrv_LAN_IP          = var.spoke_2_WinSrv_LAN_IP

  # AMIs

  FGT_VM_AMI                    = var.FGT_VM_AMI
  Ubuntu_WebServer_AMI          = data.aws_ami.latest_ubuntu.id
  WinSrv2019_ami                = data.aws_ami.latest_windows.id

  # EC2 Instances Sizes

  FGT_VM_Size                 = var.FGT_VM_Size
  Ubuntu_VM_Size              = var.Ubuntu_VM_Size
  WinSrv_VM_Size              = var.WinSrv_VM_Size

}

module "spoke_3_Prod_VPC" {
  source                       = "./AWS_Spoke_3_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone

  # VPC CIDR & Subnets

  spoke_3_vpc_cidr                = var.spoke_3_vpc_cidr

  # Spoke 1
  spoke_3_wan1_subnet_cidr     = var.spoke_3_wan1_subnet_cidr
  spoke_3_wan2_subnet_cidr     = var.spoke_3_wan2_subnet_cidr
  spoke_3_private_subnet_cidr  = var.spoke_3_private_subnet_cidr

  # Deploy VPC
  create_spoke_3_vpc    = var.create_spoke_3_vpc
}

module "spoke_3" {
  source                         = "./spoke_3"
  access_key                     = var.access_key
  secret_key                     = var.secret_key

  # Deployable Devices
  create_spoke_3_fgt               = var.create_spoke_3_fgt
  create_spoke_3_windows           = var.create_spoke_3_windows
  create_spoke_3_linux             = var.create_spoke_3_linux

  # Global dependencies

  username                       = var.username
  Password                       = var.Password
  keyname                        = var.keyname
  virginia_region                = var.virginia_region
  Public_SubHosted_Zone_id       = module.Hub_1_Prod_VPC.Public_SubHosted_Zone_id
  hub1_FMG_For_Spokes            = module.hub_1.hub1_FMG_For_Spokes
  hub1_FAZ_For_Spokes            = module.hub_1.hub1_FAZ_For_Spokes
  hub_1_private_subnet_cidr      = var.hub_1_private_subnet_cidr

  # Security Groups 
  
  default_SG                     = module.spoke_3_Prod_VPC.default_SG
  Public_SG                      = module.spoke_3_Prod_VPC.Public_SG
  Private_SG                     = module.spoke_3_Prod_VPC.Private_SG
  
  # spoke 2 Specific dependencies

  spoke_3_wan1_subnet_cidr       = var.spoke_3_wan1_subnet_cidr
  spoke_3_wan2_subnet_cidr       = var.spoke_3_wan2_subnet_cidr
  spoke_3_private_subnet_cidr    = var.spoke_3_private_subnet_cidr

  spoke_3_wan1_subnet_id         = module.spoke_3_Prod_VPC.spoke_3_wan1_subnet_id
  spoke_3_wan2_subnet_id         = module.spoke_3_Prod_VPC.spoke_3_wan2_subnet_id
  spoke_3_private_subnet_id      = module.spoke_3_Prod_VPC.spoke_3_private_subnet_id
  spoke_3_pvt_rt_id              = module.spoke_3_Prod_VPC.spoke_3_pvt_rt_id


  # FGT, Ubuntu, Windows and FMG Private IPs

  spoke_3_wan1_pvt_ip            = var.spoke_3_wan1_pvt_ip
  spoke_3_wan2_pvt_ip            = var.spoke_3_wan2_pvt_ip
  spoke_3_lan_pvt_IP             = var.spoke_3_lan_pvt_IP
  spoke_3_Ubuntu_LAN_IP          = var.spoke_3_Ubuntu_LAN_IP
  spoke_3_WinSrv_LAN_IP          = var.spoke_3_WinSrv_LAN_IP

  # AMIs

  FGT_VM_AMI                    = var.FGT_VM_AMI
  Ubuntu_WebServer_AMI          = data.aws_ami.latest_ubuntu.id
  WinSrv2019_ami                = data.aws_ami.latest_windows.id

  # EC2 Instances Sizes

  FGT_VM_Size                 = var.FGT_VM_Size
  Ubuntu_VM_Size              = var.Ubuntu_VM_Size
  WinSrv_VM_Size              = var.WinSrv_VM_Size

}

module "spoke_4_Prod_VPC" {
  source                       = "./AWS_spoke_4_VPC_US-East-1"
  access_key                   = var.access_key
  secret_key                   = var.secret_key
  username                     = var.username
  virginia_region              = var.virginia_region
  Public_Hosted_Zone           = var.Public_Hosted_Zone
  SubHosted_Zone               = var.SubHosted_Zone

  # VPC CIDR & Subnets

  spoke_4_vpc_cidr                = var.spoke_4_vpc_cidr

  # Spoke 1
  spoke_4_wan1_subnet_cidr     = var.spoke_4_wan1_subnet_cidr
  spoke_4_wan2_subnet_cidr     = var.spoke_4_wan2_subnet_cidr
  spoke_4_private_subnet_cidr  = var.spoke_4_private_subnet_cidr

  # Deploy VPC
  create_spoke_4_vpc    = var.create_spoke_4_vpc
}

module "spoke_4" {
  source                         = "./spoke_4"
  access_key                     = var.access_key
  secret_key                     = var.secret_key

  # Deployable Devices
  create_spoke_4_fgt             = var.create_spoke_4_fgt
  create_spoke_4_windows           = var.create_spoke_4_windows
  create_spoke_4_linux             = var.create_spoke_4_linux

  # Global dependencies

  username                       = var.username
  Password                       = var.Password
  keyname                        = var.keyname
  virginia_region                = var.virginia_region
  Public_SubHosted_Zone_id       = module.Hub_1_Prod_VPC.Public_SubHosted_Zone_id
  hub1_FMG_For_Spokes            = module.hub_1.hub1_FMG_For_Spokes
  hub1_FAZ_For_Spokes            = module.hub_1.hub1_FAZ_For_Spokes
  hub_1_private_subnet_cidr      = var.hub_1_private_subnet_cidr

  # Security Groups 
  
  default_SG                     = module.spoke_4_Prod_VPC.default_SG
  Public_SG                      = module.spoke_4_Prod_VPC.Public_SG
  Private_SG                     = module.spoke_4_Prod_VPC.Private_SG
  
  # spoke 2 Specific dependencies

  spoke_4_wan1_subnet_cidr       = var.spoke_4_wan1_subnet_cidr
  spoke_4_wan2_subnet_cidr       = var.spoke_4_wan2_subnet_cidr
  spoke_4_private_subnet_cidr    = var.spoke_4_private_subnet_cidr

  spoke_4_wan1_subnet_id         = module.spoke_4_Prod_VPC.spoke_4_wan1_subnet_id
  spoke_4_wan2_subnet_id         = module.spoke_4_Prod_VPC.spoke_4_wan2_subnet_id
  spoke_4_private_subnet_id      = module.spoke_4_Prod_VPC.spoke_4_private_subnet_id
  spoke_4_pvt_rt_id              = module.spoke_4_Prod_VPC.spoke_4_pvt_rt_id


  # FGT, Ubuntu, Windows and FMG Private IPs

  spoke_4_wan1_pvt_ip            = var.spoke_4_wan1_pvt_ip
  spoke_4_wan2_pvt_ip            = var.spoke_4_wan2_pvt_ip
  spoke_4_lan_pvt_IP             = var.spoke_4_lan_pvt_IP
  spoke_4_Ubuntu_LAN_IP          = var.spoke_4_Ubuntu_LAN_IP
  spoke_4_WinSrv_LAN_IP          = var.spoke_4_WinSrv_LAN_IP

  # AMIs

  FGT_VM_AMI                    = var.FGT_VM_AMI
  Ubuntu_WebServer_AMI          = data.aws_ami.latest_ubuntu.id
  WinSrv2019_ami                = data.aws_ami.latest_windows.id

  # EC2 Instances Sizes

  FGT_VM_Size                 = var.FGT_VM_Size
  Ubuntu_VM_Size              = var.Ubuntu_VM_Size
  WinSrv_VM_Size              = var.WinSrv_VM_Size

}
