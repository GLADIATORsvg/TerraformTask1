variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "GitHub username or organization"
}

variable "repo_name" {
  type        = string
  description = "GitHub repository name"
}

variable "deploy_key_public" {
  type        = string
  description = "Public part of deploy key (for DEPLOY_KEY)"
}

variable "pat_value" {
  type        = string
  description = "PAT value to store in GitHub Actions Secret"
  sensitive   = true
}

variable "pr_template_content" {
  type        = string
  description = "Content of pull_request_template.md"
}
