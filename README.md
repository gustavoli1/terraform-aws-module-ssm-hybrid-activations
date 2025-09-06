# AWS SSM Hybrid Activations Terraform Module 🚀

This module creates an AWS SSM Hybrid Activation. By default, it also creates the required IAM role and policy.

## Usage 👨‍💻

```hcl
module "ssm_activation" {
  source = "./aws-ssm-hybrid-activations"

  name               = "my-activation"
  registration_limit = 5
}
```

To use an existing IAM role, set `create_iam_role` to `false` and provide the IAM role ARN:

```hcl
module "ssm_activation" {
  source = "./aws-ssm-hybrid-activations"

  name               = "my-activation"
  iam_role           = "arn:aws:iam::123456789012:role/my-existing-role"
  create_iam_role    = false
  registration_limit = 5
}
```

## Parameter Explanations 📖

*   `name`:
    *   **What is it?** It's the name you want to give to the SSM activation.
    *   **Example:** "production-servers-activation".
    *   **Default:** If you don't specify a name, it will be `ssm-activation`.

*   `iam_role`:
    *   **What is it?** It's the ARN (Amazon Resource Name) of an existing IAM role that you want to associate with your instances. The IAM role provides the necessary permissions for the instance to communicate with the SSM service.
    *   **When to use?** Use this parameter if you already have a specific role and don't want the module to create a new one. For it to work, you need to set `create_iam_role` to `false`.
    *   **Default:** None (`""`).

*   `registration_limit`:
    *   **What is it?** Defines the maximum number of machines (instances) that can register with SSM using this activation.
    *   **Example:** If you set it to `10`, up to 10 machines can use the same activation code.
    *   **Default:** `1`.

*   `expiration_date`:
    *   **What is it?** The specific date and time when the activation will expire, in RFC3339 format (e.g., `2023-12-31T23:59:59Z`). If this is set, it takes precedence over `expiration_in_days`.
    *   **Default:** `null`. If neither `expiration_date` nor `expiration_in_days` is set, the activation will expire in 24 hours.

*   `expiration_in_days`:
    *   **What is it?** The number of days until the activation expires. This is a simpler way to set the expiration period. The value must be between 1 and 30.
    *   **When is it used?** This is used if `expiration_date` is not set.
    *   **Example:** `15` for 15 days.
    *   **Default:** `null`.

*   `description`:
    *   **What is it?** A brief description for the activation, so you and your team know what it's for.
    *   **Example:** "Activation for the marketing campaign web servers".
    *   **Default:** `SSM Hybrid Activation`.

*   `tags`:
    *   **What is it?** Allows you to add tags to the SSM activation resource. Tags are useful for organizing and controlling costs.
    *   **Example:** `{ "Environment" = "Production", "Team" = "DevOps" }`.
    *   **Default:** None (`{}`).

*   `create_iam_role`:
    *   **What is it?** A boolean value (`true` or `false`) that tells the module whether or not it should create a new IAM role for the activation.
    *   **When to use `false`?** When you already have an IAM role and will specify it in the `iam_role` parameter.
    *   **Default:** `true` (the module creates the role automatically).

*   `default_instance_name`:
    *   **What is it?** The default name that will be given to each instance that registers using this activation.
    *   **How it works:** If you set this variable, its value will be used. If you don't set it, the value of the `name` variable will be used as the default instance name instead.
    *   **Example:** "web-server".
    *   **Default:** `null`.

## Inputs 📝

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the activation. Also used as the default instance name if `default_instance_name` is not set. | string | `"ssm-activation"` | no |
| iam_role | The IAM role to associate with the managed instances. Required if `create_iam_role` is `false`. | string | `""` | no |
| registration_limit | The number of instances that can be registered using this activation. | number | `1` | no |
| expiration_date | The specific date when the activation expires (RFC3339 format). Takes precedence over `expiration_in_days`. | string | `null` | no |
| expiration_in_days | Number of days until the activation expires (1-30). Ignored if `expiration_date` is set. | number | `null` | no |
| description | A description for the activation. | string | `"SSM Hybrid Activation"` | no |
| tags | Tags to apply to the activation. | map(string) | `{}` | no |
| create_iam_role | Whether to create the IAM role for the activation. | bool | `true` | no |
| default_instance_name | The default name of the managed instance. If not set, the value of the `name` variable is used. | string | `null` | no |

## Outputs 📤

| Name | Description |
|------|-------------|
| activation_id | The ID of the activation. |
| activation_code | The code to use to activate the instance. |

