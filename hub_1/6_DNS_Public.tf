resource "aws_route53_record" "hub1_WAN1_FGT_Public_DNS" {
  provider = aws.virginia
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-hub1-WAN1"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.hub_1_WAN1.public_ip]
}

resource "aws_route53_health_check" "Hub_1_WAN1_Health_Check" {
  fqdn              = aws_route53_record.hub1_WAN1_FGT_Public_DNS.fqdn
  port              = 443
  type              = "HTTPS"
  failure_threshold = "1"
  request_interval  = "10"
  measure_latency   = true
  

  tags = {
    Name = "${var.username}_Hub_1_WAN_1_Health_Check"
  }
}

resource "aws_route53_record" "hub1_WAN2_FGT_Public_DNS" {
  provider = aws.virginia
  zone_id = var.Public_SubHosted_Zone_id
  name    = "FGT-hub1-WAN2"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.hub_1_WAN2.public_ip]
}

resource "aws_route53_health_check" "Hub_1_WAN2_Health_Check" {
  fqdn              = aws_route53_record.hub1_WAN2_FGT_Public_DNS.fqdn
  port              = 443
  type              = "HTTPS"
  failure_threshold = "1"
  request_interval  = "10"
  measure_latency   = true

  tags = {
    Name = "${var.username}_Hub_1_WAN_2_Health_Check"
  }
}

resource "aws_route53_record" "hub1_WAN_1_FGT_Public_DNS" {
  provider = aws.virginia
  zone_id = var.Public_SubHosted_Zone_id
  type    = "A"
  name    = "FGT-Hub1"
  set_identifier = "Hub_1_WAN_1"
  health_check_id = aws_route53_health_check.Hub_1_WAN1_Health_Check.id

  weighted_routing_policy {
    weight = 1
  }
  
  alias {
    name                   = aws_route53_record.hub1_WAN1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hub1_WAN_2_FGT_Public_DNS" {
  provider = aws.virginia
  zone_id = var.Public_SubHosted_Zone_id
  type    = "A"
  name    = "FGT-Hub1"
  set_identifier = "Hub_1_WAN_2"
  health_check_id = aws_route53_health_check.Hub_1_WAN2_Health_Check.id


  weighted_routing_policy {
    weight = 1
  }
  
  alias {
    name                   = aws_route53_record.hub1_WAN2_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}


resource "time_sleep" "wait_15_seconds_Public" {
  depends_on      = [aws_route53_record.hub1_WAN_2_FGT_Public_DNS]
  create_duration = "15s"
}

resource "aws_route53_record" "hub1_Linux_Public" {
  count = var.create_hub_1_linux == "yes" ? 1 : 0
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "linux-hub1"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "hub1_WebServer_Public" {
  count = var.create_hub_1_linux == "yes" ? 1 : 0
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "WebServer-hub1"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hub1_Windows_Public" {
  count = var.create_hub_1_windows == "yes" ? 1 : 0
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "Windows-hub1"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hub1_FMG_Public" {
  count = var.create_hub_1_FMG == "yes" ? 1 : 0
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "fmg"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hub1_FAZ_Public" {
  count = var.create_hub_1_FAZ == "yes" ? 1 : 0
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "FAZ"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hub1_FAC_Public" {
  count = var.create_hub_1_FAC == "yes" ? 1 : 0
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "FAC"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ssl_vpn" {
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "vpn"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "lab" {
  count = var.create_hub_1_linux == "yes" ? 1 : 0
  provider = aws.virginia
  depends_on = [time_sleep.wait_15_seconds_Public]
  zone_id = var.Public_SubHosted_Zone_id
  name       = "lab"
  type       = "A"

  alias {
    name                   = aws_route53_record.hub1_WAN_1_FGT_Public_DNS.fqdn
    zone_id                = var.Public_SubHosted_Zone_id
    evaluate_target_health = true
  }
}