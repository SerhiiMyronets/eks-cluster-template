output "certificate_arn" {
  description = "ARN of the validated wildcard ACM certificate"
  value       = aws_acm_certificate.this.arn
}

output "zone_name" {
  description = "Created Route 53 zone name"
  value       = aws_route53_zone.this.name
}
