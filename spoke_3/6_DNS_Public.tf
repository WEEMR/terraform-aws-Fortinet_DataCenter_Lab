resource "aws_route53_record" "spoke3_WAN1_FGT_Public_DNS" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke3-WAN1"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.spoke_3_WAN1[count.index].public_ip]
}


resource "aws_route53_health_check" "spoke_3_WAN1_Health_Check" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  fqdn              = aws_route53_record.spoke3_WAN1_FGT_Public_DNS[count.index].fqdn
  port              = 443
  type              = "HTTPS"
  failure_threshold = "1"
  request_interval  = "10"
  measure_latency   = true
  #enable_sni        = false
  

  tags = {
    Name = "${var.username}_spoke_3_WAN_1_Health_Check"
  }
}

resource "aws_route53_record" "spoke3_WAN2_FGT_Public_DNS" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke3-WAN2"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.spoke_3_WAN2[count.index].public_ip]
}

resource "aws_route53_health_check" "spoke_3_WAN2_Health_Check" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  fqdn              = aws_route53_record.spoke3_WAN2_FGT_Public_DNS[count.index].fqdn
  port              = 443
  type              = "HTTPS"
  failure_threshold = "1"
  request_interval  = "10"
  measure_latency   = true
  #enable_sni        = false

  tags = {
    Name = "${var.username}_spoke_3_WAN_2_Health_Check"
  }
}

resource "aws_route53_record" "spoke3_WAN_1_FGT_Public_DNS" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke3"
  type    = "A"
  set_identifier = "spoke_3_WAN_1"
  health_check_id = aws_route53_health_check.spoke_3_WAN1_Health_Check[count.index].id

  weighted_routing_policy {
    weight = 1
  }
  
  alias {
    name                   = aws_route53_record.spoke3_WAN1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "spoke3_WAN_2_FGT_Public_DNS" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke3"
  type    = "A"
  set_identifier = "spoke_3_WAN_2"
  health_check_id = aws_route53_health_check.spoke_3_WAN2_Health_Check[count.index].id

  weighted_routing_policy {
    weight = 1
  }
  
  alias {
    name                   = aws_route53_record.spoke3_WAN2_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "time_sleep" "wait_15_seconds_Public" {
  count = var.create_spoke_3_fgt == "yes" ? 1 : 0
  depends_on      = [aws_route53_record.spoke3_WAN_1_FGT_Public_DNS]
  create_duration = "15s"
}

resource "aws_route53_record" "spoke3_Linux_Public" {
  count = var.create_spoke_3_linux == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "linux-spoke3"
  type       = "A"

  alias {
    name                   = aws_route53_record.spoke3_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "spoke3_WebServer_Public" {
  count = var.create_spoke_3_linux == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "WebServer-spoke3"
  type       = "A"

  alias {
    name                   = aws_route53_record.spoke3_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "spoke3_Windows_Public" {
  count = var.create_spoke_3_windows == "yes" ? 1 : 0
  provider = aws.spoke_3_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "Windows-spoke3"
  type       = "A"

  alias {
    name                   = aws_route53_record.spoke3_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}