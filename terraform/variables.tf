variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
}

variable "github_owner" {
  type        = string
  description = "GitHub username or organization"
}

variable "repo_name" {
  type        = string
  description = "Repository name"
}

variable "deploy_public_key" {
  type        = string
  description = "Deploy key (public part)"
}

variable "pat_value" {
  type        = string
  description = "PAT value to store in GitHub Actions Secret"
}
