resource "aws_iam_role" "ssm_role" {
  count = var.create_iam_role ? 1 : 0

  name = var.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  count = var.create_iam_role ? 1 : 0

  role       = aws_iam_role.ssm_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

locals {
  expiration_date_from_days = var.expiration_in_days != null ? timeadd(timestamp(), "${var.expiration_in_days * 24}h") : null
  final_expiration_date     = coalesce(var.expiration_date, local.expiration_date_from_days)
}

resource "aws_ssm_activation" "this" {
  name                      = coalesce(var.default_instance_name, var.name)
  description               = var.description
  iam_role                  = var.create_iam_role ? aws_iam_role.ssm_role[0].name : var.iam_role
  registration_limit        = var.registration_limit
  expiration_date           = local.final_expiration_date
  tags                      = var.tags

  depends_on = [aws_iam_role_policy_attachment.ssm_policy_attachment]
}