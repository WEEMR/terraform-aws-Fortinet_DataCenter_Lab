output "spoke_2_WAN1" {
  value       = var.create_spoke_2_fgt == "yes" ? aws_eip.spoke_2_WAN1[0].public_ip : 0
}

output "spoke_2_WAN2" {
  value       = var.create_spoke_2_fgt == "yes" ? aws_eip.spoke_2_WAN2[0].public_ip : 0
}

output "spoke2_FGT_DNS_Name" {
  value = var.create_spoke_2_fgt == "yes" ? aws_route53_record.spoke2_WAN_1_FGT_Public_DNS[0].fqdn : 0
}

output "spoke2_Linux_DNS_Name" {
  value = var.create_spoke_2_linux == "yes" ? aws_route53_record.spoke2_Linux_Public[0].fqdn : 0
}

output "spoke2_WebServer_Public" {
  value = var.create_spoke_2_linux == "yes" ? aws_route53_record.spoke2_WebServer_Public[0].fqdn : 0
}

output "spoke2_Windows_Public" {
  value = var.create_spoke_2_windows == "yes" ? aws_route53_record.spoke2_Windows_Public[0].fqdn : 0
}

output "spoke2_Windows_Password" {
  value = var.create_spoke_2_windows == "yes" ? aws_instance.spoke_2_WinSrv[0].password_data : 0
}