output "activation_id" {
  description = "The ID of the activation."
  value       = aws_ssm_activation.this.id
}

output "activation_code" {
  description = "The code to use to activate the instance."
  value       = aws_ssm_activation.this.activation_code
  sensitive   = true
}
