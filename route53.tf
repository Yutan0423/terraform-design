data "aws_route53_zone" "default" {
  name = "tantech.site"
}

resource "aws_route53_record" "default" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = data.aws_route53_zone.default.name
  type    = "A"
  alias {
    name                   = aws_lb.default.dns_name
    zone_id                = aws_lb.default.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "default_certificate" {
  name    = tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.default.domain_validation_options)[0].resource_record_value]
  zone_id = data.aws_route53_zone.default.zone_id
  ttl     = 60
}

output "domain_name" {
  value = aws_route53_record.default.name
}

