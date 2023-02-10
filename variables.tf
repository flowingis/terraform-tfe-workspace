variable "name" {
  description = "(Required) Name of the workspace"
  type        = string
}

variable "organization" {
  description = "(Required) Name of the organization"
  type        = string
}

variable "description" {
  description = "(Optional) A description for the workspace"
  type        = string
  default     = ""
}

variable "allow_destroy_plan" {
  description = "(Optional) Whether destroy plans can be queued on the workspace"
  type        = bool
  default     = false
}

variable "auto_apply" {
  description = "(Optional) Whether to automatically apply changes when a Terraform plan is successful"
  type        = bool
  default     = false
}

variable "execution_mode" {
  description = "(Optional) Which execution mode to use"
  type        = string
  default     = "remote"

  validation {
    condition     = can(regex("agent|local|remote", var.execution_mode))
    error_message = "ERROR: Allowed values are \"remote\", \"local\" or \"agent\"."
  }
}

variable "assessments_enabled" {
  description = "(Optional) Whether to regularly run health assessments such as drift detection on the workspace"
  type        = bool
  default     = false
}

variable "file_triggers_enabled" {
  description = "(Optional) Whether to filter runs based on the changed files in a VCS push"
  type        = bool
  default     = true
}

variable "global_remote_state" {
  description = "(Optional) Whether the workspace allows all workspaces in the organization to access its state data during runs"
  type        = bool
  default     = false
}

variable "remote_state_consumer_ids" {
  description = "(Optional) The set of workspace IDs set as explicit remote state consumers for the given workspace"
  type        = list(string)
  default     = []
}

variable "queue_all_runs" {
  description = "(Optional) Whether the workspace should start automatically performing runs immediately after its creation"
  type        = bool
  default     = true
}

variable "speculative_enabled" {
  description = "(Optional) Whether this workspace allows speculative plans"
  type        = bool
  default     = true
}

variable "structured_run_output_enabled" {
  description = "(Optional) Whether this workspace should show output from Terraform runs using the enhanced UI when available"
  type        = bool
  default     = true
}

variable "ssh_key_id" {
  description = "(Optional) The ID of an SSH key to assign to the workspace"
  type        = string
  default     = null
}

variable "terraform_version" {
  description = "(Required) The version of Terraform to use for this workspace"
  type        = string
}

variable "trigger_prefixes" {
  description = "(Optional) List of repository-root-relative paths which describe all locations to be tracked for changes"
  type        = list(string)
  default     = null
}

variable "trigger_patterns" {
  description = "(Optional) List of glob patterns that describe the files Terraform Cloud monitors for changes. Trigger patterns are always appended to the root directory of the repository. Mutually exclusive with trigger-prefixes. Only available for Terraform Cloud"
  type        = list(string)
  default     = null
}

variable "tag_names" {
  description = "(Optional) A list of tag names for this workspace"
  type        = list(string)
  default     = []
}

variable "working_directory" {
  description = "(Optional) A relative path that Terraform will execute within"
  type        = string
  default     = null
}

variable "force_delete" {
  description = "(Optional) If this attribute is present on a workspace that is being deleted through the provider, it will use the existing force delete API. If this attribute is not present or false it will safe delete the workspace"
  type        = bool
  default     = false
}

variable "vcs_repository_identifier" {
  description = "(Optional) A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider. The format for Azure DevOps is //_git/"
  type        = string
  default     = ""
}

variable "vcs_repository_branch" {
  description = "(Optional) The repository branch that Terraform will execute from"
  type        = string
  default     = ""
}

variable "vcs_repository_ingress_submodules" {
  description = "(Optional) Whether submodules should be fetched when cloning the VCS repository"
  type        = bool
  default     = false
}

variable "oauth_token_id" {
  description = "(Optional) The token ID of the VCS connection to use"
  type        = string
  default     = ""
}

variable "vcs_repository_tags_regex" {
  description = "(Optional) (Optional) A regular expression used to trigger a Workspace run for matching Git tags. This option conflicts with trigger_patterns and trigger_prefixes. Should only set this value if the former is not being used"
  type        = string
  default     = null
}

variable "terraform_variables" {
  description = <<EOF
(Optional) Map of variables of 'Terraform' category used in the workspace

  Item syntax:
  {
    variable1_name = value1
    variable2_name = value2
    ...
  }
EOF

  type    = map(any)
  default = {}
}

variable "terraform_hcl_variables" {
  description = <<EOF
(Optional) Map of variables in HCL format of 'Terraform' category used in the workspace

  Item syntax:
  {
    variable1_name = value1
    variable2_name = value2
    ...
  }

NOTE: you can specifies values in HCL format directly, like this:

  {
    variable_list = ["item1","item2"]

    variable_map = {
      key1 = value1
      key2 = value2
    }
  }
}
EOF

  type    = any
  default = {}
}

variable "terraform_sensitive_variables" {
  description = <<EOF
(Optional) Map of sensitive variables of 'Terraform' category used in the workspace

Item syntax:
{
  variable1_name = value1
  variable2_name = value2
  ...
}
EOF

  type    = map(any)
  default = {}
}

variable "terraform_hcl_sensitive_variables" {
  description = <<EOF
(Optional) Map of sensitive variables in HCL format of 'Terraform' category used in the workspace

  Item syntax:
  {
    variable1_name = value1
    variable2_name = value2
    ...
  }

NOTE: you can specifies values in HCL format directly, like this:

  {
    variable_list = ["item1","item2"]

    variable_map = {
      key1 = value1
      key2 = value2
    }
  }
EOF

  type    = any
  default = {}
}

variable "environment_variables" {
  description = <<EOF
(Optional) Map of variables of 'environment' category used in the workspace

  Item syntax:
  {
    variable1_name = value1
    variable2_name = value2
    ...
  }
EOF

  type    = map(any)
  default = {}
}

variable "environment_sensitive_variables" {
  description = <<EOF
(Optional) Map of sensitive variables of 'environment' category used in the workspace

  Item syntax:
  {
    variable1_name = value1
    variable2_name = value2
    ...
  }
EOF

  type    = map(any)
  default = {}
}

variable "variables_descriptions" {
  description = <<EOF
(Optional) Map of descriptions applied to workspace variables

  Item syntax:
  {
    variable1_name = "description"
    variable2_name = "description"
    ...
  }
EOF

  type    = map(string)
  default = {}
}

variable "run_triggers" {
  description = "List of source workspaces IDs that trigger runs in this workspace"
  type        = list(string)
  default     = []
}

variable "notification_webhook_configuration" {
  description = <<EOT
(Optional) List of notification configuration of 'Webhook' type

  Item syntax:
  [
    {
      name = "webhook_1"
      enabled = true
      token = "mysupersecrettoken1"
      url = "https://myendpoint1.domain.ext"
      triggers = [
        "created",
        "planning",
        "needs_attention",
        "applying",
        "completed",
        "errored"
      ]
    },
    {
      name = "webhook_2"
      enabled = false
      token = "mysupersecrettoken2"
      url = "https://myendpoint2.domain.ext"
    },
    {
      ...
    }
  ]
EOT

  type = list(object({
    name     = string,
    enabled  = bool,
    token    = string,
    url      = string,
    triggers = list(string) #Optional
  }))

  default = []
}

variable "notification_slack_configuration" {
  description = <<EOT
(Optional) List of notification configuration of 'Slack' type

  Item syntax:
  [
    {
      name = "webhook_1"
      enabled = true
      url = "https://hooks.slack.com/services/VeryLongHash1"
      triggers = [
        "created",
        "planning",
        "needs_attention",
        "applying",
        "completed",
        "errored"
      ]
    },
    {
      name = "webhook_2"
      enabled = false
      url = "https://hooks.slack.com/services/VeryLongHash2"
    },
    {
      ...
    }
  ]
EOT

  type = list(object({
    name     = string,
    enabled  = bool,
    url      = string,
    triggers = list(string) #Optional
  }))

  default = []
}

variable "notification_microsoft_teams_configuration" {
  description = <<EOT
(Optional) List of notification configuration of 'Microsoft Teams' type

  Item syntax:
  [
    {
      name = "webhook_1"
      enabled = true
      url = "https://ms1234567890abcde.webhook.office.com"
      triggers = [
        "created",
        "planning",
        "needs_attention",
        "applying",
        "completed",
        "errored"
      ]
    },
    {
      name = "webhook_2"
      enabled = false
      url = "https://ms0987654321edcba.webhook.office.com"
    },
    {
      ...
    }
  ]
EOT

  type = list(object({
    name     = string,
    enabled  = bool,
    url      = string,
    triggers = list(string) #Optional
  }))

  default = []
}

variable "variable_set_ids" {
  description = "(Optional) List of variable set ids applied to this workspace"
  type        = list(string)
  default     = []
}

variable "project_id" {
  description = "(Optional) ID of the project where the workspace should be created"
  type        = string
  default     = ""
}
