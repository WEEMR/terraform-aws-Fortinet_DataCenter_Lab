resource "aws_route53_record" "spoke2_WAN1_FGT_Public_DNS" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke2-WAN1"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.spoke_2_WAN1[count.index].public_ip]
}


resource "aws_route53_health_check" "spoke_2_WAN1_Health_Check" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  fqdn              = aws_route53_record.spoke2_WAN1_FGT_Public_DNS[count.index].fqdn
  port              = 443
  type              = "HTTPS"
  failure_threshold = "1"
  request_interval  = "10"
  measure_latency   = true
  #enable_sni        = false
  

  tags = {
    Name = "${var.username}_spoke_2_WAN_1_Health_Check"
  }
}

resource "aws_route53_record" "spoke2_WAN2_FGT_Public_DNS" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke2-WAN2"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.spoke_2_WAN2[count.index].public_ip]
}

resource "aws_route53_health_check" "spoke_2_WAN2_Health_Check" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  fqdn              = aws_route53_record.spoke2_WAN2_FGT_Public_DNS[count.index].fqdn
  port              = 443
  type              = "HTTPS"
  failure_threshold = "1"
  request_interval  = "10"
  measure_latency   = true
  #enable_sni        = false

  tags = {
    Name = "${var.username}_spoke_2_WAN_2_Health_Check"
  }
}

resource "aws_route53_record" "spoke2_WAN_1_FGT_Public_DNS" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke2"
  type    = "A"
  set_identifier = "spoke_2_WAN_1"
  health_check_id = aws_route53_health_check.spoke_2_WAN1_Health_Check[count.index].id

  weighted_routing_policy {
    weight = 1
  }
  
  alias {
    name                   = aws_route53_record.spoke2_WAN1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "spoke2_WAN_2_FGT_Public_DNS" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-spoke2"
  type    = "A"
  set_identifier = "spoke_2_WAN_2"
  health_check_id = aws_route53_health_check.spoke_2_WAN2_Health_Check[count.index].id

  weighted_routing_policy {
    weight = 1
  }
  
  alias {
    name                   = aws_route53_record.spoke2_WAN2_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "time_sleep" "wait_15_seconds_Public" {
  count = var.create_spoke_2_fgt == "yes" ? 1 : 0
  depends_on      = [aws_route53_record.spoke2_WAN_1_FGT_Public_DNS]
  create_duration = "15s"
}

resource "aws_route53_record" "spoke2_Linux_Public" {
  count = var.create_spoke_2_linux == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "linux-spoke2"
  type       = "A"

  alias {
    name                   = aws_route53_record.spoke2_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "spoke2_WebServer_Public" {
  count = var.create_spoke_2_linux == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "WebServer-spoke2"
  type       = "A"

  alias {
    name                   = aws_route53_record.spoke2_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "spoke2_Windows_Public" {
  count = var.create_spoke_2_windows == "yes" ? 1 : 0
  provider = aws.spoke_2_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "Windows-spoke2"
  type       = "A"

  alias {
    name                   = aws_route53_record.spoke2_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}