variable "name" {
  description = "Name of the workspace"
  type        = string
}

variable "organization" {
  description = "Name of the organization"
  type        = string
}

variable "description" {
  description = "A description for the workspace"
  type        = string
}

variable "allow_destroy_plan" {
  description = "Whether destroy plans can be queued on the workspace"
  type        = bool
  default     = false
}

variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful"
  type        = bool
  default     = false
}

variable "execution_mode" {
  description = "Which execution mode to use"
  type        = string
  default     = "remote"
}

variable "file_triggers_enabled" {
  description = "Whether to filter runs based on the changed files in a VCS push"
  type        = bool
  default     = true
}

variable "global_remote_state" {
  description = "Whether the workspace allows all workspaces in the organization to access its state data during runs"
  type        = bool
  default     = false
}

variable "remote_state_consumer_ids" {
  description = "The set of workspace IDs set as explicit remote state consumers for the given workspace"
  type        = list(string)
  default     = []
}

variable "queue_all_runs" {
  description = "Whether the workspace should start automatically performing runs immediately after its creation"
  type        = bool
  default     = true
}

variable "speculative_enabled" {
  description = "Whether this workspace allows speculative plans"
  type        = bool
  default     = true
}

variable "structured_run_output_enabled" {
  description = "Whether this workspace should show output from Terraform runs using the enhanced UI when available"
  type        = bool
  default     = true
}

variable "ssh_key_id" {
  description = "The ID of an SSH key to assign to the workspace"
  type        = string
  default     = null
}

variable "terraform_version" {
  description = "The version of Terraform to use for this workspace"
  type        = string
}

variable "trigger_prefixes" {
  description = "List of repository-root-relative paths which describe all locations to be tracked for changes"
  type        = list(string)
  default     = []
}

variable "tag_names" {
  description = "A list of tag names for this workspace"
  type        = list(string)
  default     = []
}

variable "working_directory" {
  description = "A relative path that Terraform will execute within"
  type        = string
  default     = null
}

variable "vcs_repository_identifier" {
  description = "A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider. The format for Azure DevOps is //_git/"
  type        = string
  default     = ""
}

variable "vcs_repository_branch" {
  description = "The repository branch that Terraform will execute from"
  type        = string
  default     = ""
}

variable "vcs_repository_ingress_submodules" {
  description = "Whether submodules should be fetched when cloning the VCS repository"
  type        = bool
  default     = false
}

variable "oauth_client_id" {
  description = "ID of the OAuth client"
  type        = string
  default     = ""
}

variable "terraform_variables" {
  description = <<EOF
List of map of variables of 'Terraform' category used in the workspace

Item syntax:
{
  key = "foo" [required]
  value = "bar" [required]
  description = "baz" [optional]
}
EOF

  type    = list(any)
  default = []
}

variable "terraform_hcl_variables" {
  description = <<EOF
List of map of variables in HCL format of 'Terraform' category used in the workspace

Item syntax:
{
  key = "foo" [required]
  value = "bar" [required]
  description = "baz" [optional]
}
EOF

  type    = list(any)
  default = []
}

variable "terraform_sensitive_variables" {
  description = <<EOF
Map of sensitive variables of 'Terraform' category used in the workspace

Item syntax:
{
  key = "foo" [required]
  value = "bar" [required]
  description = "baz" [optional]
}
EOF

  type      = list(any)
  default   = []
  sensitive = true
}

variable "terraform_hcl_sensitive_variables" {
  description = <<EOF
Map of sensitive variables in HCL format of 'Terraform' category used in the workspace"

Item syntax:
{
  key = "foo" [required]
  value = "bar" [required]
  description = "baz" [optional]
}
EOF

  type      = list(any)
  default   = []
  sensitive = true
}

variable "environment_variables" {
  description = <<EOF
Map of variables of 'environment' category used in the workspace"

Item syntax:
{
  key = "foo" [required]
  value = "bar" [required]
  description = "baz" [optional]
}
EOF

  type    = list(any)
  default = []
}

variable "environment_sensitive_variables" {
  description = <<EOF
Map of sensitive variables of 'environment' category used in the workspace"

Item syntax:
{
  key = "foo" [required]
  value = "bar" [required]
  description = "baz" [optional]
}
EOF

  type      = list(any)
  default   = []
  sensitive = true
}
