#### ---------------- COLLABORATOR ---------------- ####
resource "github_repository_collaborator" "softserve" {
  repository = var.repo_name
  username   = "softservedata"
  permission = "push"
}

#### ---------------- DEVELOP BRANCH ---------------- ####
resource "github_branch" "develop" {
  repository = var.repo_name
  branch     = "develop"
}

resource "github_branch_default" "default" {
  repository = var.repo_name
  branch     = github_branch.develop.branch
}

#### ---------------- BRANCH PROTECTIONS ---------------- ####
resource "github_branch_protection" "develop_protection" {
  repository_id        = var.repo_name
  pattern              = "develop"
  enforce_admins       = true
  require_pull_request = true

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    required_approving_review_count = 2
  }
}

resource "github_branch_protection" "main_protection" {
  repository_id        = var.repo_name
  pattern              = "main"
  enforce_admins       = true
  require_pull_request = true

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    required_approving_review_count = 1
  }
}

#### ---------------- PR TEMPLATE ---------------- ####
resource "github_repository_file" "pr_template" {
  repository      = var.repo_name
  file            = ".github/pull_request_template.md"
  content         = file("${path.module}/pull_request_template.md")
  branch          = github_branch.develop.branch
  commit_message  = "Add PR template"
}

#### ---------------- DEPLOY KEY ---------------- ####
resource "github_repository_deploy_key" "deploy_key" {
  title      = "DEPLOY_KEY"
  repository = var.repo_name
  key        = var.deploy_public_key
  read_only  = false
}

#### ---------------- ACTIONS SECRET ---------------- ####
resource "github_actions_secret" "pat" {
  repository      = var.repo_name
  secret_name     = "PAT"
  plaintext_value = var.pat_value
}
