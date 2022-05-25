# terraform-tfe-workspace

This example will manage an advanced Terraform Cloud/Enterprise workspace connected
to a GitHub repository, including all types of variables and a couple of notification
configurations.

## Usage

To run this example, you need to execute the following commands:

```shell
$ terraform init
$ terraform plan
$ terraform apply
```

:memo: **Note:** You will need a Terraform Cloud/Enterprise API token for authentication.
You'll be prompted to insert it to provide a value for "tfc_token" variable.
See [here](https://www.terraform.io/cloud-docs/users-teams-organizations/api-tokens)
for further information.

:memo: **Note:** This root modules defines other several sensitive variables.
You'll be prompted to insert the required values by default on every "plan" and "apply" action
Choose the appropriate method to automatically specify these values, like described [here](https://www.terraform.io/language/values/variables#assigning-values-to-root-module-variables)

:warning: **Warning:** This example may create resources that cost money. Execute the command
`terraform destroy` when the resources are no longer needed.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.31.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_advanced_workspace"></a> [advanced\_workspace](#module\_advanced\_workspace) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key_id"></a> [access\_key\_id](#input\_access\_key\_id) | Access Key ID to access AWS Account | `string` | n/a | yes |
| <a name="input_secret_access_key"></a> [secret\_access\_key](#input\_secret\_access\_key) | Secret Access Key to access AWS Account | `string` | n/a | yes |
| <a name="input_secret_token"></a> [secret\_token](#input\_secret\_token) | A secret token used in some resource configuration | `string` | n/a | yes |
| <a name="input_slack_notification_url"></a> [slack\_notification\_url](#input\_slack\_notification\_url) | URL of Webhook to a Slack Channel used for Terraform Cloud Runs notifications | `string` | n/a | yes |
| <a name="input_tfc_token"></a> [tfc\_token](#input\_tfc\_token) | Token for Terraform Cloud Authentication | `string` | n/a | yes |
| <a name="input_webhooh_notification_token"></a> [webhooh\_notification\_token](#input\_webhooh\_notification\_token) | A write-only secure token for the notification configuration of 'Webhook' type | `string` | n/a | yes |
| <a name="input_webhook_notification_url"></a> [webhook\_notification\_url](#input\_webhook\_notification\_url) | The HTTP or HTTPS URL of the notification configuration where notification requests will be made | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The ID of Terraform Cloud/Enterprise workspace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
