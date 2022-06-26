// spoke 1 Windows Server 2019

resource "aws_network_interface" "spoke1_WinSrv_eth0" {
  count = var.create_spoke_3_windows == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  description = "WinSrv2019"
  subnet_id   = var.spoke_3_private_subnet_id
  private_ips = var.spoke_3_WinSrv_LAN_IP
  security_groups = [var.Private_SG]
  
  tags = {
    Name = "${var.username}_TF_spoke_3_WinSrv"
    Owner = var.username
    Enviroment = "${var.username}"
  }
}

resource "time_sleep" "Windows_wait_3mins" {
  count = var.create_spoke_3_windows == "yes" ? 1 : 0
  depends_on      = [aws_instance.spoke_3]
  create_duration = "180s"
}


resource "aws_instance" "spoke_3_WinSrv" {
  count = var.create_spoke_3_windows == "yes" ? 1 : 0
  provider          = aws.spoke_3_vpc
  depends_on        = [time_sleep.Windows_wait_3mins]
  ami               = var.WinSrv2019_ami
  instance_type     = var.WinSrv_VM_Size
  availability_zone = data.aws_availability_zones.AZs.names[0]
  key_name          = var.keyname
  get_password_data = true
  user_data         = data.template_file.Windows_Server2019_Config.rendered

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }
  
  
  network_interface {
    network_interface_id = aws_network_interface.spoke1_WinSrv_eth0[count.index].id
    device_index         = 0
  }


  tags = {
    Name = "${var.username}_TF_spoke_3_WinSrv2019"
  }
}

data "template_file" "Windows_Server2019_Config" {
  template = file(var.Windows_Server2019_Config)
}