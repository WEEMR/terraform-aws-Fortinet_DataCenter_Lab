// ------------------------------- VPC

output "SDWAN_VPC" {
  value       = var.create_spoke_1_vpc == "yes" ? aws_vpc.SDWAN_VPC[0].id : 0
}

// ------------------------------- Security Groups 


output "default_SG" {
  value = var.create_spoke_1_vpc == "yes" ? aws_default_security_group.default_SG[0].id : 0
}

output "Public_SG" {
  value = var.create_spoke_1_vpc == "yes" ? aws_security_group.Public_SG[0].id : 0
}

output "Private_SG" {
  value = var.create_spoke_1_vpc == "yes" ? aws_security_group.Private_SG[0].id : 0
}

// ------------------------------- spoke 1

output "spoke_1_wan1_subnet_id" {
  value       = var.create_spoke_1_vpc == "yes" ? aws_subnet.spoke_1_wan1_subnet[0].id : 0
}

output "spoke_1_wan2_subnet_id" {
  value       = var.create_spoke_1_vpc == "yes" ? aws_subnet.spoke_1_wan2_subnet[0].id : 0
}

output "spoke_1_private_subnet_id" {
  value       = var.create_spoke_1_vpc == "yes" ? aws_subnet.spoke_1_private_subnet[0].id : 0
}

output "spoke_1_pvt_rt_id" {
  value       = var.create_spoke_1_vpc == "yes" ? aws_route_table.spoke_1_pvt_rt[0].id : 0
}
