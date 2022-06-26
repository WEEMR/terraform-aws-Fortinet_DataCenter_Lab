// hub 1 Apache Interface

resource "aws_network_interface" "hub1_Ubuntu_WebServer_eth0" {
  count = var.create_hub_1_linux == "yes" ? 1 : 0
  provider    = aws.virginia
  description = "${var.username}_Terraform_hub_1_Apache_eth0"
  subnet_id   = var.hub_1_private_subnet_id
  private_ips = var.hub_1_Ubuntu_LAN_IP
  security_groups = [var.Private_SG]

  tags = {
    Name = "${var.username}_TF_hub_1_Ubuntu_WebServer_Eth0"
  }
}

resource "time_sleep" "wait_6mins" {
  count = var.create_hub_1_linux == "yes" ? 1 : 0
  depends_on      = [aws_instance.hub_1]
  create_duration = "360s"
}


resource "aws_instance" "hub_1_Apache" {
  count = var.create_hub_1_linux == "yes" ? 1 : 0
  provider          = aws.virginia
  depends_on        = [time_sleep.wait_6mins]
  ami               = var.Ubuntu_WebServer_AMI
  instance_type     = var.Ubuntu_VM_Size
  availability_zone = data.aws_availability_zones.AZs.names[0]
  key_name          = var.keyname

  root_block_device {
    volume_type = "standard"
    volume_size = "8"
  }

  network_interface {
    network_interface_id = aws_network_interface.hub1_Ubuntu_WebServer_eth0[count.index].id
    device_index         = 0
  }

  user_data = <<-EOF
  #!/bin/bash
  sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
  systemctl restart sshd
  service sshd restart
  #
  #     Add New Username based on "var.username"
  #
  useradd ${var.username}
  sudo usermod -aG sudo ${var.username}
  sudo mkdir /home/${var.username}
  sudo usermod --shell /bin/bash --home /home/${var.username} ${var.username}
  sudo chown -R ${var.username}:${var.username} /home/${var.username}
  cp /etc/skel/.* /home/${var.username}/
  #
  #   Configure Password
  #
  yes ${var.Password} | sudo passwd ${var.username}
  #
  #      Install Apache  
  #
  sudo apt update -y
  sudo apt install -y apache2
  #
  #      Start Apache Service
  #
  sudo systemctl start apache2
  sudo systemctl enable apache2
  #
  #      Give User permissions to modify the /var/www folder 
  #
  sudo chown -R $\${var.username}:$\${var.username} /var/www
  #
  #      Create a simple webpage to be displayed by the Apache Server
  #
  echo "<html><style>body { font-size: 15px;}</style><body><h1>Hello, Everyone &#128075</h1><h2>This is our Hub 1 Apache Server created via Terraform &#128079 &#128170; </h2></body></html>" > /var/www/html/index.html
  echo "<html><style>body{font-size:15px}</style><body><h1>Lab URLs & Diagram</h1><h4><br><br><a href="https://fmg.${var.SubHosted_Zone}:4444" target="_blank">FortiManager</a><br><br><a href="https://faz.${var.SubHosted_Zone}:4445" target="_blank">FortiAnalyzer</a><br><br><a href="https://fac.${var.SubHosted_Zone}" target="_blank">FortiAuthenticator</a><br><br><a href="https://fsa.${var.SubHosted_Zone}" target="_blank">FortiSandbox</a><br><br><br></h4><h3>Hub 1</h3><h4><a href="https://fgt-hub1.${var.SubHosted_Zone}" target="_blank">Hub 1 FortiGate</a><br><a href="https://fgt-hub1-wan1.${var.SubHosted_Zone}" target="_blank">Hub 1 WAN 1 Interface</a><br><a href="https://fgt-hub1-wan2.${var.SubHosted_Zone}" target="_blank">Hub 1 WAN 2 Interface</a><br><br><br><a href="http://webserver-hub1.${var.SubHosted_Zone}" target="_blank">Hub 1 Web Server</a><br><br>Linux SSH = linux-hub1.${var.SubHosted_Zone}:2222</h4><h3>Hub 2</h3><h4><a href="https://fgt-hub2.${var.SubHosted_Zone}" target="_blank">Hub 2 FortiGate</a><br><a href="https://fgt-hub2-wan1.${var.SubHosted_Zone}" target="_blank">Hub 2 WAN 1 Interface</a><br><a href="https://fgt-hub2-wan2.${var.SubHosted_Zone}" target="_blank">Hub 2 WAN 2 Interface</a><br><br><br><a href="http://webserver-hub2.${var.SubHosted_Zone}" target="_blank">Hub 2 Web Server</a><br><br>Linux SSH = linux-hub2.${var.SubHosted_Zone}:2222</h4><h3>Hub 3</h3><h4><a href="https://fgt-hub3.${var.SubHosted_Zone}" target="_blank">Hub 3 FortiGate</a><br><a href="https://fgt-hub3-wan1.${var.SubHosted_Zone}" target="_blank">Hub 3 WAN 1 Interface</a><br><a href="https://fgt-hub3-wan2.${var.SubHosted_Zone}" target="_blank">Hub 3 WAN 2 Interface</a><br><br><br><a href="http://webserver-hub3.${var.SubHosted_Zone}" target="_blank">Hub 3 Web Server</a><br><br>Linux SSH = linux-hub3.${var.SubHosted_Zone}:2222</h4><h3>Spoke 1</h3><h4><a href="https://fgt-spoke1.${var.SubHosted_Zone}" target="_blank">Spoke 1 FortiGate</a><br><a href="https://fgt-spoke1-wan1.${var.SubHosted_Zone}" target="_blank">Spoke 1 WAN 1 Interface</a><br><a href="https://fgt-spoke1-wan2.${var.SubHosted_Zone}" target="_blank">Spoke 1 WAN 2 Interface</a><br><br><br><a href="http://webserver-spoke1.${var.SubHosted_Zone}" target="_blank">Spoke 1 Web Server</a><br><br>Linux SSH = linux-spoke1.${var.SubHosted_Zone}:2222<br>Windows RDP = windows-spoke1.${var.SubHosted_Zone}:3389</h4><h3>Spoke 2</h3><h4><a href="https://fgt-spoke2.${var.SubHosted_Zone}" target="_blank">Spoke 2 FortiGate</a><br><a href="https://fgt-spoke2-wan1.${var.SubHosted_Zone}" target="_blank">Spoke 2 WAN 1 Interface</a><br><a href="https://fgt-spoke2-wan2.${var.SubHosted_Zone}" target="_blank">Spoke 2 WAN 2 Interface</a><br><br><br><a href="http://webserver-spoke2.${var.SubHosted_Zone}" target="_blank">Spoke 2 Web Server</a><br><br>Linux SSH = linux-spoke2.${var.SubHosted_Zone}:2222<br>Windows RDP = windows-spoke2.${var.SubHosted_Zone}:3389</h4><h3>Spoke 3</h3><h4><a href="https://fgt-spoke3.${var.SubHosted_Zone}" target="_blank">Spoke 3 FortiGate</a><br><a href="https://fgt-spoke3-wan1.${var.SubHosted_Zone}" target="_blank">Spoke 3 WAN 1 Interface</a><br><a href="https://fgt-spoke3-wan2.${var.SubHosted_Zone}" target="_blank">Spoke 3 WAN 2 Interface</a><br><br><br><a href="http://webserver-spoke3.${var.SubHosted_Zone}" target="_blank">Spoke 3 Web Server</a><br><br>Linux SSH = linux-spoke3.${var.SubHosted_Zone}:2222<br>Windows RDP = windows-spoke3.${var.SubHosted_Zone}:3389</h4><h3>Spoke 4</h3><h4><a href="https://fgt-spoke4.${var.SubHosted_Zone}" target="_blank">Spoke 4 FortiGate</a><br><a href="https://fgt-spoke4-wan1.${var.SubHosted_Zone}" target="_blank">Spoke 4 WAN 1 Interface</a><br><a href="https://fgt-spoke4-wan2.${var.SubHosted_Zone}" target="_blank">Spoke 4 WAN 2 Interface</a><br><br><br><a href="http://webserver-spoke4.${var.SubHosted_Zone}" target="_blank">Spoke 4 Web Server</a><br><br>Linux SSH = linux-spoke4.${var.SubHosted_Zone}:2222<br>Windows RDP = windows-spoke4.${var.SubHosted_Zone}:3389</h4><br><br><img src="https://terraform-bootstrapping-files.s3.amazonaws.com/PS_LAB_Images/ADVPN_Lab.png" alt="Env_1A_Diagram"></body></html>" > /var/www/html/lab.html #  #
  #
  #  Install Net Tools
  #
  sudo apt install -y net-tools
  #
  #
  #    Install Ubuntu xface Session Manager (XFACE)  
  #
  sudo apt-get install -y xubuntu-desktop
  #sudo apt install -y lxqt sddm
  #sudo apt-get remove -y gdm3
  #sudo apt autoremove -y
  #
  #    Set LXQT as the default display manager 
  #
  #sudo dpkg-reconfigure lxqt
  #
  #     Install Firefox
  #
  sudo apt install -y firefox
  #
  #     Install nmap
  #
  sudo apt install -y nmap
  #
  #     Install elinks browser
  #
  sudo apt-get install -y elinks
  #
  #     Install fzf file finder
  #
  sudo apt-get install -y fzf
  #
  #  Install pydf (graphical df)
  #
  sudo apt-get install -y pydf
  #
  #     Install lynx browser
  #
  sudo apt install -y lynx
  #
  #     Install iperf
  #
  sudo apt install -y iperf
  #
  #     Enable RDP 
  #
  sudo apt install -y xrdp
  sudo adduser xrdp ssl-cert
  #
  #    Restart the RDP service to enable it
  #
  sudo systemctl restart xrdp
  sudo reboot
  #
  #

  EOF

  tags = {
    Name = "${var.username}_TF_hub1_Ubuntu_Apache_Server"
  }
}