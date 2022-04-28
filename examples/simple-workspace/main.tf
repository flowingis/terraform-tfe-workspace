terraform {
  required_version = "~> 1.1.0"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.31.0"
    }
  }
}

provider "tfe" {
  token = var.tfc_token
}

module "simple_workspace" {
  source = "../../"

  name              = "simple-workspace"
  organization      = "myorg"
  description       = "A simple Terraform Cloud/Enterprise workspace"
  terraform_version = "1.1.9"

  terraform_variables = {
    string_variable = "stringvalue"
    number_variable = 1
    bool_variable   = true
  }

  variables_descriptions = {
    string_variable = "A variable containing a value in string format"
    number_variable = "A variable containing a value in number format"
    bool_variable   = "A variable containing a value in boolean format"
  }
}
