provider "aws" {
  region = "us-east-1"
}

module "ssm_activation" {
  source = "../../"

  name                    = "POC-SSM-OnPrem-Role"
  registration_limit      = 10
  default_instance_name   = "Elasticsearch-OnPrem"
  expiration_in_days      = 15
}

output "activation_id" {
  description = "The ID of the activation."
  value       = module.ssm_activation.activation_id
}

output "activation_code" {
  description = "The code to use to activate the instance."
  value       = module.ssm_activation.activation_code
  sensitive   = true
}
