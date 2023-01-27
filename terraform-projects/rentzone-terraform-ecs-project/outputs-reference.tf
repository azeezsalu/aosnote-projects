# website url
output "website_url" {
  value     = join ("", ["https://", <record name>, ".", <domain name>])
}