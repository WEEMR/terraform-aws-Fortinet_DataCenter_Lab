output "hub_1_WAN1" {
  value       = aws_eip.hub_1_WAN1.public_ip
}

output "hub_1_WAN2" {
  value       = aws_eip.hub_1_WAN2.public_ip
}

output "hub1_FGT_DNS_Name" {
  value = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
}

output "hub1_Linux_DNS_Name" {
  value = var.create_hub_1_linux == "yes" ? aws_route53_record.hub1_Linux_Public[0].fqdn : 0 
}

output "hub1_WebServer_Public" {
  value = var.create_hub_1_linux == "yes" ? aws_route53_record.hub1_WebServer_Public[0].fqdn : 0
}

output "hub1_Windows_Public" {
  value = var.create_hub_1_windows == "yes" ? aws_route53_record.hub1_Windows_Public[0].fqdn : 0
}

output "hub1_Windows_Password" {
  value = var.create_hub_1_windows == "yes" ? aws_instance.hub_1_WinSrv[0].password_data : 0
}


output "hub1_FMG_For_Spokes" {
  value = var.create_hub_1_FMG == "yes" ? aws_route53_record.hub1_FMG_Public[0].fqdn : 0
}

output "hub1_FAZ_For_Spokes" {
  value = var.create_hub_1_FAZ == "yes" ? aws_route53_record.hub1_FAZ_Public[0].fqdn : 0
}

output "hub1_FMG_Public" {
  value = var.create_hub_1_FMG == "yes" ? "https://${aws_route53_record.hub1_FMG_Public[0].fqdn}:4444" : 0
}

output "hub1_FAZ_Public" {
  value = var.create_hub_1_FAZ == "yes" ? "https://${aws_route53_record.hub1_FAZ_Public[0].fqdn}:4445" : 0
}
