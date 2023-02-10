# terraform-tfe-workspace
Terraform module to provision and manage Terraform Cloud workspaces

## Features

- Definition of a Terraform Cloud Workspace with following available settings, including items in:
  - General
  - Notifications [*]
  - Run Triggers
  - Version Control
- Variables
- Variable Set assignments

:warning: For Notifications configuration, only "webhook", "slack" and "microsoft-teams" types are supported at the moment

## Usage

### Simple workspace with local run mode
```
module "workspace_only_for_remote_state" {
  source  = "flowingis/workspace/tfe"
  version = "0.5.0"

  name         = "my-workspace-name"
  organization = "my-organization"
  description  = "Simple workspace that only manages the remote state for some resource on AWS"

  terraform_version = "1.3.7"
  execution_mode    = "local"

  terraform_variables = {
      environment = "dev"
      project     = "myproject"
    }
  )

  variables_descriptions = merge(
    {
      environment = "The environment of the project"
      region      = "The name of the project"
    }
  )

  tag_names = [
    "project:myproject",
    "environment:dev",
  ]
}
```

### Advanced workspace with remote run mode
```
module "my_workspace" {
  source  = "flowingis/workspace/tfe"
  version = "0.5.0"

  name         = "my-workspace-name"
  organization = "my-organization"
  description  = "Advanced workspace with remote run mode"

  terraform_version = "1.3.7"

  queue_all_runs            = false
  working_directory         = "/my/sub/path"
  vcs_repository_identifier = "my-github-org/my-repo"
  vcs_repository_branch     = "main"

  oauth_token_id = var.oauth_token_id #NOTE: sensitive value

  terraform_variables = {
      environment = "core"
      project     = "core"
      region      = "eu-west-1"
    }
  )

  environment_sensitive_variables = {
    AWS_ACCESS_KEY_ID     = var.access_key_id #NOTE: sensitive value
    AWS_SECRET_ACCESS_KEY = var.secret_access_key #NOTE: sensitive value
  }

  variables_descriptions = {
      environment           = "The environment of the project"
      project               = "The name of the project"
      region                = "The AWS region where shared resources are deployed"
      AWS_ACCESS_KEY_ID     = "Access Key ID to access AWS Account"
      AWS_SECRET_ACCESS_KEY = "Secret Access Key to access AWS Account"
    }
  )

  tag_names = [
    "project:core",
    "environment:core",
    "region:eu-west-1"
  ]
}
```

## Integrations

It is possible to integrate this module with [tfe-variable-set module](https://registry.terraform.io/modules/flowingis/variable-set/tfe/latest), in order to assign one or more variable sets to the workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | >= 0.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_notification_configuration.microsoft_teams](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration) | resource |
| [tfe_notification_configuration.slack](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration) | resource |
| [tfe_notification_configuration.webhook](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration) | resource |
| [tfe_run_trigger.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/run_trigger) | resource |
| [tfe_variable.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace_variable_set.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_destroy_plan"></a> [allow\_destroy\_plan](#input\_allow\_destroy\_plan) | (Optional) Whether destroy plans can be queued on the workspace | `bool` | `false` | no |
| <a name="input_assessments_enabled"></a> [assessments\_enabled](#input\_assessments\_enabled) | (Optional) Whether to regularly run health assessments such as drift detection on the workspace | `bool` | `false` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | (Optional) Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the workspace | `string` | `""` | no |
| <a name="input_environment_sensitive_variables"></a> [environment\_sensitive\_variables](#input\_environment\_sensitive\_variables) | (Optional) Map of sensitive variables of 'environment' category used in the workspace<br><br>  Item syntax:<br>  {<br>    variable1\_name = value1<br>    variable2\_name = value2<br>    ...<br>  } | `map(any)` | `{}` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | (Optional) Map of variables of 'environment' category used in the workspace<br><br>  Item syntax:<br>  {<br>    variable1\_name = value1<br>    variable2\_name = value2<br>    ...<br>  } | `map(any)` | `{}` | no |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | (Optional) Which execution mode to use | `string` | `"remote"` | no |
| <a name="input_file_triggers_enabled"></a> [file\_triggers\_enabled](#input\_file\_triggers\_enabled) | (Optional) Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | (Optional) If this attribute is present on a workspace that is being deleted through the provider, it will use the existing force delete API. If this attribute is not present or false it will safe delete the workspace | `bool` | `false` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | (Optional) Whether the workspace allows all workspaces in the organization to access its state data during runs | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the workspace | `string` | n/a | yes |
| <a name="input_notification_microsoft_teams_configuration"></a> [notification\_microsoft\_teams\_configuration](#input\_notification\_microsoft\_teams\_configuration) | (Optional) List of notification configuration of 'Microsoft Teams' type<br><br>  Item syntax:<br>  [<br>    {<br>      name = "webhook\_1"<br>      enabled = true<br>      url = "https://ms1234567890abcde.webhook.office.com"<br>      triggers = [<br>        "created",<br>        "planning",<br>        "needs\_attention",<br>        "applying",<br>        "completed",<br>        "errored"<br>      ]<br>    },<br>    {<br>      name = "webhook\_2"<br>      enabled = false<br>      url = "https://ms0987654321edcba.webhook.office.com"<br>    },<br>    {<br>      ...<br>    }<br>  ] | <pre>list(object({<br>    name     = string,<br>    enabled  = bool,<br>    url      = string,<br>    triggers = list(string) #Optional<br>  }))</pre> | `[]` | no |
| <a name="input_notification_slack_configuration"></a> [notification\_slack\_configuration](#input\_notification\_slack\_configuration) | (Optional) List of notification configuration of 'Slack' type<br><br>  Item syntax:<br>  [<br>    {<br>      name = "webhook\_1"<br>      enabled = true<br>      url = "https://hooks.slack.com/services/VeryLongHash1"<br>      triggers = [<br>        "created",<br>        "planning",<br>        "needs\_attention",<br>        "applying",<br>        "completed",<br>        "errored"<br>      ]<br>    },<br>    {<br>      name = "webhook\_2"<br>      enabled = false<br>      url = "https://hooks.slack.com/services/VeryLongHash2"<br>    },<br>    {<br>      ...<br>    }<br>  ] | <pre>list(object({<br>    name     = string,<br>    enabled  = bool,<br>    url      = string,<br>    triggers = list(string) #Optional<br>  }))</pre> | `[]` | no |
| <a name="input_notification_webhook_configuration"></a> [notification\_webhook\_configuration](#input\_notification\_webhook\_configuration) | (Optional) List of notification configuration of 'Webhook' type<br><br>  Item syntax:<br>  [<br>    {<br>      name = "webhook\_1"<br>      enabled = true<br>      token = "mysupersecrettoken1"<br>      url = "https://myendpoint1.domain.ext"<br>      triggers = [<br>        "created",<br>        "planning",<br>        "needs\_attention",<br>        "applying",<br>        "completed",<br>        "errored"<br>      ]<br>    },<br>    {<br>      name = "webhook\_2"<br>      enabled = false<br>      token = "mysupersecrettoken2"<br>      url = "https://myendpoint2.domain.ext"<br>    },<br>    {<br>      ...<br>    }<br>  ] | <pre>list(object({<br>    name     = string,<br>    enabled  = bool,<br>    token    = string,<br>    url      = string,<br>    triggers = list(string) #Optional<br>  }))</pre> | `[]` | no |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | (Optional) The token ID of the VCS connection to use | `string` | `""` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | (Required) Name of the organization | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID of the project where the workspace should be created | `string` | `""` | no |
| <a name="input_queue_all_runs"></a> [queue\_all\_runs](#input\_queue\_all\_runs) | (Optional) Whether the workspace should start automatically performing runs immediately after its creation | `bool` | `true` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | (Optional) The set of workspace IDs set as explicit remote state consumers for the given workspace | `list(string)` | `[]` | no |
| <a name="input_run_triggers"></a> [run\_triggers](#input\_run\_triggers) | List of source workspaces IDs that trigger runs in this workspace | `list(string)` | `[]` | no |
| <a name="input_speculative_enabled"></a> [speculative\_enabled](#input\_speculative\_enabled) | (Optional) Whether this workspace allows speculative plans | `bool` | `true` | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | (Optional) The ID of an SSH key to assign to the workspace | `string` | `null` | no |
| <a name="input_structured_run_output_enabled"></a> [structured\_run\_output\_enabled](#input\_structured\_run\_output\_enabled) | (Optional) Whether this workspace should show output from Terraform runs using the enhanced UI when available | `bool` | `true` | no |
| <a name="input_tag_names"></a> [tag\_names](#input\_tag\_names) | (Optional) A list of tag names for this workspace | `list(string)` | `[]` | no |
| <a name="input_terraform_hcl_sensitive_variables"></a> [terraform\_hcl\_sensitive\_variables](#input\_terraform\_hcl\_sensitive\_variables) | (Optional) Map of sensitive variables in HCL format of 'Terraform' category used in the workspace<br><br>  Item syntax:<br>  {<br>    variable1\_name = value1<br>    variable2\_name = value2<br>    ...<br>  }<br><br>NOTE: you can specifies values in HCL format directly, like this:<br><br>  {<br>    variable\_list = ["item1","item2"]<br><br>    variable\_map = {<br>      key1 = value1<br>      key2 = value2<br>    }<br>  } | `any` | `{}` | no |
| <a name="input_terraform_hcl_variables"></a> [terraform\_hcl\_variables](#input\_terraform\_hcl\_variables) | (Optional) Map of variables in HCL format of 'Terraform' category used in the workspace<br><br>  Item syntax:<br>  {<br>    variable1\_name = value1<br>    variable2\_name = value2<br>    ...<br>  }<br><br>NOTE: you can specifies values in HCL format directly, like this:<br><br>  {<br>    variable\_list = ["item1","item2"]<br><br>    variable\_map = {<br>      key1 = value1<br>      key2 = value2<br>    }<br>  }<br>} | `any` | `{}` | no |
| <a name="input_terraform_sensitive_variables"></a> [terraform\_sensitive\_variables](#input\_terraform\_sensitive\_variables) | (Optional) Map of sensitive variables of 'Terraform' category used in the workspace<br><br>Item syntax:<br>{<br>  variable1\_name = value1<br>  variable2\_name = value2<br>  ...<br>} | `map(any)` | `{}` | no |
| <a name="input_terraform_variables"></a> [terraform\_variables](#input\_terraform\_variables) | (Optional) Map of variables of 'Terraform' category used in the workspace<br><br>  Item syntax:<br>  {<br>    variable1\_name = value1<br>    variable2\_name = value2<br>    ...<br>  } | `map(any)` | `{}` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | (Required) The version of Terraform to use for this workspace | `string` | n/a | yes |
| <a name="input_trigger_patterns"></a> [trigger\_patterns](#input\_trigger\_patterns) | (Optional) List of glob patterns that describe the files Terraform Cloud monitors for changes. Trigger patterns are always appended to the root directory of the repository. Mutually exclusive with trigger-prefixes. Only available for Terraform Cloud | `list(string)` | `null` | no |
| <a name="input_trigger_prefixes"></a> [trigger\_prefixes](#input\_trigger\_prefixes) | (Optional) List of repository-root-relative paths which describe all locations to be tracked for changes | `list(string)` | `null` | no |
| <a name="input_variable_set_ids"></a> [variable\_set\_ids](#input\_variable\_set\_ids) | List of variable set ids applied to this workspace | `list(string)` | `[]` | no |
| <a name="input_variables_descriptions"></a> [variables\_descriptions](#input\_variables\_descriptions) | (Optional) Map of descriptions applied to workspace variables<br><br>  Item syntax:<br>  {<br>    variable1\_name = "description"<br>    variable2\_name = "description"<br>    ...<br>  } | `map(string)` | `{}` | no |
| <a name="input_vcs_repository_branch"></a> [vcs\_repository\_branch](#input\_vcs\_repository\_branch) | (Optional) The repository branch that Terraform will execute from | `string` | `""` | no |
| <a name="input_vcs_repository_identifier"></a> [vcs\_repository\_identifier](#input\_vcs\_repository\_identifier) | (Optional) A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider. The format for Azure DevOps is //\_git/ | `string` | `""` | no |
| <a name="input_vcs_repository_ingress_submodules"></a> [vcs\_repository\_ingress\_submodules](#input\_vcs\_repository\_ingress\_submodules) | (Optional) Whether submodules should be fetched when cloning the VCS repository | `bool` | `false` | no |
| <a name="input_vcs_repository_tags_regex"></a> [vcs\_repository\_tags\_regex](#input\_vcs\_repository\_tags\_regex) | (Optional) (Optional) A regular expression used to trigger a Workspace run for matching Git tags. This option conflicts with trigger\_patterns and trigger\_prefixes. Should only set this value if the former is not being used | `string` | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | (Optional) A relative path that Terraform will execute within | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The workspace ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
