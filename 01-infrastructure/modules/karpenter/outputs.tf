output "interruption_queue_name" {
  value = aws_sqs_queue.karpenter_interruption.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.karpenter.name
}