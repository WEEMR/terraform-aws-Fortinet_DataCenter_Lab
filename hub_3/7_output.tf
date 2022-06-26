output "hub_3_WAN1" {
  value       = var.create_hub_3_fgt == "yes" ? aws_eip.hub_3_WAN1[0].public_ip : 0
}

output "hub_3_WAN2" {
  value       = var.create_hub_3_fgt == "yes" ? aws_eip.hub_3_WAN2[0].public_ip : 0
}

output "hub3_FGT_DNS_Name" {
  value = var.create_hub_3_fgt == "yes" ? aws_route53_record.hub3_WAN_1_FGT_Public_DNS[0].fqdn : 0
}

output "hub3_Linux_DNS_Name" {
  value =  var.create_hub_3_linux == "yes" ? aws_route53_record.hub3_Linux_Public[0].fqdn : 0
}

output "hub3_WebServer_Public" {
  value = var.create_hub_3_linux == "yes" ? aws_route53_record.hub3_WebServer_Public[0].fqdn : 0
}


output "hub3_Windows_Public" {
  value =  var.create_hub_3_windows == "yes" ? aws_route53_record.hub3_Windows_Public[0].fqdn : 0
}

output "hub3_Windows_Password" {
  value = var.create_hub_3_windows == "yes" ? aws_instance.hub_3_WinSrv[0].password_data : 0
}
