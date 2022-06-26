output "spoke_4_WAN1" {
  value       = var.create_spoke_4_fgt == "yes" ? aws_eip.spoke_4_WAN1[0].public_ip : 0
}

output "spoke_4_WAN2" {
  value       = var.create_spoke_4_fgt == "yes" ? aws_eip.spoke_4_WAN2[0].public_ip : 0
}

output "spoke4_FGT_DNS_Name" {
  value = var.create_spoke_4_fgt == "yes" ? aws_route53_record.spoke4_WAN_1_FGT_Public_DNS[0].fqdn : 0
}

output "spoke4_Linux_DNS_Name" {
  value = var.create_spoke_4_linux == "yes" ? aws_route53_record.spoke4_Linux_Public[0].fqdn : 0
}

output "spoke4_WebServer_Public" {
  value = var.create_spoke_4_linux == "yes" ? aws_route53_record.spoke4_WebServer_Public[0].fqdn : 0
}

output "spoke4_Windows_Public" {
  value = var.create_spoke_4_windows == "yes" ? aws_route53_record.spoke4_Windows_Public[0].fqdn : 0
}

output "spoke4_Windows_Password" {
  value = var.create_spoke_4_windows == "yes" ? aws_instance.spoke_4_WinSrv[0].password_data : 0
}