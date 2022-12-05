# terraform-tfe-workspace

This example will manage a simple Terraform Cloud/Enterprise workspace without
connecting it to the GitHub repository.

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

:warning: **Warning:** This example may create resources that cost money. Execute the command
`terraform destroy` when the resources are no longer needed.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.39.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_simple_workspace"></a> [simple\_workspace](#module\_simple\_workspace) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tfc_token"></a> [tfc\_token](#input\_tfc\_token) | Token for Terraform Cloud Authentication | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The ID of Terraform Cloud/Enterprise workspace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
