variable "repo_name" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "repo_owner" {
  description = "GitHub organization or user that owns the repository"
  type        = string
}

variable "github_token" {
  description = "GitHub PAT used by Terraform"
  type        = string
  sensitive   = true
}

variable "deploy_public_key" {
  description = "Public key for DEPLOY_KEY"
  type        = string
}

variable "pat_value" {
  description = "PAT secret for GitHub Actions"
  type        = string
  sensitive   = true
}

