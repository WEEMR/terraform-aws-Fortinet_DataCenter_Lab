resource "aws_route53_record" "fsa1_Public_DNS" {
  provider = aws.fsa_1_vpc
  zone_id = var.Public_SubHosted_Zone_id
  count = var.create_FSA == "yes" ? 1 : 0
  name    = "fsa"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.fsa_1_wan[count.index].public_ip]
}