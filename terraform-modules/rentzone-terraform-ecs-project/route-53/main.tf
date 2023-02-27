# get hosted zone details
data "aws_route53_zone" "hosted_zone" {
  name = 
}

# create a record set in route 53
resource "aws_route53_record" "site_domain" {
  zone_id = 
  name    = 
  type    = 

  alias {
    name                   = 
    zone_id                = 
    evaluate_target_health = 
  }
}