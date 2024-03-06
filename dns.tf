data "aws_route53_zone" "hex7" {
  name = "hex7.com."
}


resource "aws_route53_record" "greenup" {
  zone_id = data.aws_route53_zone.hex7.zone_id
  name    = "greenup.hex7.com."
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.greenup.domain_name
    zone_id                = aws_cloudfront_distribution.greenup.hosted_zone_id
    evaluate_target_health = true
  }
}
