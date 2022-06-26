output "spoke_3_WAN1" {
  value       = var.create_spoke_3_fgt == "yes" ? aws_eip.spoke_3_WAN1[0].public_ip : 0
}

output "spoke_3_WAN2" {
  value       = var.create_spoke_3_fgt == "yes" ? aws_eip.spoke_3_WAN2[0].public_ip : 0
}

output "spoke3_FGT_DNS_Name" {
  value = var.create_spoke_3_fgt == "yes" ? aws_route53_record.spoke3_WAN_1_FGT_Public_DNS[0].fqdn : 0
}

output "spoke3_Linux_DNS_Name" {
  value = var.create_spoke_3_linux == "yes" ? aws_route53_record.spoke3_Linux_Public[0].fqdn : 0
}

output "spoke3_WebServer_Public" {
  value = var.create_spoke_3_linux == "yes" ? aws_route53_record.spoke3_WebServer_Public[0].fqdn : 0
}

output "spoke3_Windows_Public" {
  value = var.create_spoke_3_windows == "yes" ? aws_route53_record.spoke3_Windows_Public[0].fqdn : 0
}

output "spoke3_Windows_Password" {
  value = var.create_spoke_3_windows == "yes" ? aws_instance.spoke_3_WinSrv[0].password_data : 0
}