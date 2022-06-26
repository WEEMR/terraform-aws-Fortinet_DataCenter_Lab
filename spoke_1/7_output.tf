output "spoke_1_WAN1" {
  value       = var.create_spoke_1_fgt == "yes" ? aws_eip.spoke_1_WAN1[0].public_ip : 0 
}

output "spoke_1_WAN2" {
  value       = var.create_spoke_1_fgt == "yes" ? aws_eip.spoke_1_WAN2[0].public_ip : 0
}

output "spoke1_FGT_DNS_Name" {
  value = var.create_spoke_1_fgt == "yes" ? aws_route53_record.spoke1_WAN_1_FGT_Public_DNS[0].fqdn : 0
}

output "spoke1_Linux_DNS_Name" {
  value = var.create_spoke_1_linux == "yes" ? aws_route53_record.spoke1_Linux_Public[0].fqdn : 0
}

output "spoke1_WebServer_Public" {
  value = var.create_spoke_1_linux == "yes" ? aws_route53_record.spoke1_WebServer_Public[0].fqdn : 0
}

output "spoke1_Windows_Public" {
  value = var.create_spoke_1_windows == "yes" ? aws_route53_record.spoke1_Windows_Public[0].fqdn : 0
}

output "spoke1_Windows_Password" {
  value = var.create_spoke_1_windows == "yes" ? aws_instance.spoke_1_WinSrv[0].password_data : 0
}