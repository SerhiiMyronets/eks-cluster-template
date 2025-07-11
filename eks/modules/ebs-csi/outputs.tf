output "ebs_csi_role_arn" {
  value       = aws_iam_role.ebs_csi_driver.arn
  description = "IAM role ARN for the EBS CSI Driver"
}