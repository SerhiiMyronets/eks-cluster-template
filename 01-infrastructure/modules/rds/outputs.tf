output "db_password_ssm_name" {
  description = "SSM parameter name for DB password"
  value       = aws_ssm_parameter.db_password.name
}

output "db_credential_arns" {
  value = [aws_ssm_parameter.db_password.arn, aws_ssm_parameter.db_host.arn, aws_ssm_parameter.db_username.arn]
}