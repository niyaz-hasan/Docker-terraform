plugin "aws" {
  enabled = true
  version = "0.27.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Configure AWS provider version constraints
rule "terraform_required_providers" {
  enabled = true
}

# Enforce version constraints
rule "terraform_required_version" {
  enabled = true
}

# Naming conventions
rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

# Enforce consistent variable types
rule "terraform_typed_variables" {
  enabled = true
}

# AWS specific rules
rule "aws_resource_missing_tags" {
  enabled = true
  tags = ["Environment", "Project", "Owner", "ManagedBy"]
}

rule "aws_instance_invalid_type" {
  enabled = true
}


rule "aws_instance_previous_type" {
  enabled = true
}


rule "aws_alb_invalid_security_group" {
  enabled = true
}


rule "aws_route_not_specified_target" {
  enabled = true
}


# Disable unused declared providers
rule "terraform_unused_declarations" {
  enabled = true
}

# Enforce consistent variable declarations
rule "terraform_documented_variables" {
  enabled = true
}

# Enforce consistent output declarations
rule "terraform_documented_outputs" {
  enabled = true
}
