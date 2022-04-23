# terraform-tfe-workspace
Terraform module to provision and manage Terraform Cloud workspaces

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_variable.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_destroy_plan"></a> [allow\_destroy\_plan](#input\_allow\_destroy\_plan) | (Optional) Whether destroy plans can be queued on the workspace | `bool` | `false` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | (Optional) Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the workspace | `string` | `""` | no |
| <a name="input_environment_sensitive_variables"></a> [environment\_sensitive\_variables](#input\_environment\_sensitive\_variables) | (Optional) Map of sensitive variables of 'environment' category used in the workspace<br><br>Item syntax:<br>{<br>  variable1\_name = value1<br>  variable2\_name = value2<br>  ...<br>} | `map(any)` | `{}` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | (Optional) Map of variables of 'environment' category used in the workspace<br><br>Item syntax:<br>{<br>  variable1\_name = value1<br>  variable2\_name = value2<br>  ...<br>} | `map(any)` | `{}` | no |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | (Optional) Which execution mode to use | `string` | `"remote"` | no |
| <a name="input_file_triggers_enabled"></a> [file\_triggers\_enabled](#input\_file\_triggers\_enabled) | (Optional) Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | (Optional) Whether the workspace allows all workspaces in the organization to access its state data during runs | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the workspace | `string` | n/a | yes |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | (Optional) The token ID of the VCS connection to use | `string` | `""` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | (Required) Name of the organization | `string` | n/a | yes |
| <a name="input_queue_all_runs"></a> [queue\_all\_runs](#input\_queue\_all\_runs) | (Optional) Whether the workspace should start automatically performing runs immediately after its creation | `bool` | `true` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | (Optional) The set of workspace IDs set as explicit remote state consumers for the given workspace | `list(string)` | `[]` | no |
| <a name="input_speculative_enabled"></a> [speculative\_enabled](#input\_speculative\_enabled) | (Optional) Whether this workspace allows speculative plans | `bool` | `true` | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | (Optional) The ID of an SSH key to assign to the workspace | `string` | `null` | no |
| <a name="input_structured_run_output_enabled"></a> [structured\_run\_output\_enabled](#input\_structured\_run\_output\_enabled) | (Optional) Whether this workspace should show output from Terraform runs using the enhanced UI when available | `bool` | `true` | no |
| <a name="input_tag_names"></a> [tag\_names](#input\_tag\_names) | (Optional) A list of tag names for this workspace | `list(string)` | `[]` | no |
| <a name="input_terraform_hcl_sensitive_variables"></a> [terraform\_hcl\_sensitive\_variables](#input\_terraform\_hcl\_sensitive\_variables) | (Optional) Map of sensitive variables in HCL format of 'Terraform' category used in the workspace<br><br>Item syntax:<br>{<br>  variable1\_name = value1<br>  variable2\_name = value2<br>  ...<br>}<br><br>NOTE: the values must be strings, use escapes or HEREDOC like this:<br><br>{<br>  variable\_list = "[\"item1\",\"item2\"]"<br><br>  variable\_map = <<EOT<br>{<br>  key1 = value1<br>  key2 = value2<br>}<br>EOT<br>} | `map(any)` | `{}` | no |
| <a name="input_terraform_hcl_variables"></a> [terraform\_hcl\_variables](#input\_terraform\_hcl\_variables) | (Optional) Map of variables in HCL format of 'Terraform' category used in the workspace<br><br>Item syntax:<br>{<br>  variable1\_name = value1<br>  variable2\_name = value2<br>  ...<br>}<br><br>NOTE: the values must be strings, use escapes or HEREDOC like this:<br><br>{<br>  variable\_list = "[\"item1\",\"item2\"]"<br><br>  variable\_map = <<EOT<br>{<br>  key1 = value1<br>  key2 = value2<br>}<br>EOT<br>} | `map(any)` | `{}` | no |
| <a name="input_terraform_sensitive_variables"></a> [terraform\_sensitive\_variables](#input\_terraform\_sensitive\_variables) | (Optional) Map of sensitive variables of 'Terraform' category used in the workspace<br><br>Item syntax:<br>{<br>  variable1\_name = value1<br>  variable2\_name = value2<br>  ...<br>} | `map(any)` | `{}` | no |
| <a name="input_terraform_variables"></a> [terraform\_variables](#input\_terraform\_variables) | (Optional) Map of variables of 'Terraform' category used in the workspace<br><br>Item syntax:<br>{<br>  variable1\_name = value1<br>  variable2\_name = value2<br>  ...<br>} | `map(any)` | `{}` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | (Required) The version of Terraform to use for this workspace | `string` | n/a | yes |
| <a name="input_trigger_prefixes"></a> [trigger\_prefixes](#input\_trigger\_prefixes) | (Optional) List of repository-root-relative paths which describe all locations to be tracked for changes | `list(string)` | `[]` | no |
| <a name="input_variables_descriptions"></a> [variables\_descriptions](#input\_variables\_descriptions) | (Optional) Map of descriptions applied to workspace variables<br><br>Item syntax:<br>{<br>  variable1\_name = "description"<br>  variable2\_name = "description"<br>  ...<br>} | `map(string)` | `{}` | no |
| <a name="input_vcs_repository_branch"></a> [vcs\_repository\_branch](#input\_vcs\_repository\_branch) | (Optional) The repository branch that Terraform will execute from | `string` | `""` | no |
| <a name="input_vcs_repository_identifier"></a> [vcs\_repository\_identifier](#input\_vcs\_repository\_identifier) | (Optional) A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider. The format for Azure DevOps is //\_git/ | `string` | `""` | no |
| <a name="input_vcs_repository_ingress_submodules"></a> [vcs\_repository\_ingress\_submodules](#input\_vcs\_repository\_ingress\_submodules) | (Optional) Whether submodules should be fetched when cloning the VCS repository | `bool` | `false` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | (Optional) A relative path that Terraform will execute within | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The workspace ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
