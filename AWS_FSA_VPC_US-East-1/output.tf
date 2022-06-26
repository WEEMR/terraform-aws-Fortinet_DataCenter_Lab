// ------------------------------- VPC

output "FSA_VPC" {
  value       = var.create_FSA == "yes" ? aws_vpc.FSA_VPC[0].id : 0
}

output "fsa_eip" {
  value       = var.create_FSA == "yes" ? aws_eip.fsa_1_wan[0].public_ip : 0
}