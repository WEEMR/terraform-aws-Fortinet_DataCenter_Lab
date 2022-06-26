resource "aws_route53_record" "hub3_WAN1_FGT_Public_DNS" {
  count = var.create_hub_3_fgt == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-hub3-WAN1"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.hub_3_WAN1[count.index].public_ip]
}

resource "aws_route53_health_check" "hub_3_WAN1_Health_Check" {
  count = var.create_hub_3_fgt == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  fqdn              = aws_route53_record.hub3_WAN1_FGT_Public_DNS[count.index].fqdn
  port              = 443
  type              = "HTTPS"
  failure_threshold = "1"
  request_interval  = "10"
  measure_latency   = true
  #enable_sni        = false
  

  tags = {
    Name = "${var.username}_hub_3_WAN_1_Health_Check"
  }
}

resource "aws_route53_record" "hub3_WAN2_FGT_Public_DNS" {
  count = var.create_hub_3_fgt == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-hub3-WAN2"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.hub_3_WAN2[count.index].public_ip]
}

resource "aws_route53_health_check" "hub_3_WAN2_Health_Check" {
  count = var.create_hub_3_fgt == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  fqdn              = aws_route53_record.hub3_WAN2_FGT_Public_DNS[count.index].fqdn
  port              = 443
  type              = "HTTPS"
  failure_threshold = "1"
  request_interval  = "10"
  measure_latency   = true
  #enable_sni        = false

  tags = {
    Name = "${var.username}_hub_3_WAN_3_Health_Check"
  }
}

resource "aws_route53_record" "hub3_WAN_1_FGT_Public_DNS" {
  count = var.create_hub_3_fgt == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-hub3"
  type    = "A"
  set_identifier = "hub_3_WAN_1"
  health_check_id = aws_route53_health_check.hub_3_WAN1_Health_Check[count.index].id

  weighted_routing_policy {
    weight = 1
  }
  
  alias {
    name                   = aws_route53_record.hub3_WAN1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hub3_WAN_3_FGT_Public_DNS" {
  count = var.create_hub_3_fgt == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-hub3"
  type    = "A"
  set_identifier = "hub_3_WAN_3"
  health_check_id = aws_route53_health_check.hub_3_WAN2_Health_Check[count.index].id

  weighted_routing_policy {
    weight = 1
  }
  
  alias {
    name                   = aws_route53_record.hub3_WAN2_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "time_sleep" "wait_15_seconds_Public" {
  count = var.create_hub_3_linux == "yes" ? 1 : 0
  depends_on      = [aws_route53_record.hub3_WAN_1_FGT_Public_DNS]
  create_duration = "15s"
}

resource "aws_route53_record" "hub3_Linux_Public" {
  count = var.create_hub_3_linux == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "linux-hub3"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub3_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "hub3_WebServer_Public" {
  count = var.create_hub_3_linux == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "WebServer-hub3"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub3_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "hub3_Windows_Public" {
  count = var.create_hub_3_windows == "yes" ? 1 : 0
  provider = aws.hub_3_vpc
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "Windows-hub3"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub3_WAN_1_FGT_Public_DNS[count.index].fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}