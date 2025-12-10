locals {
  repo_name = var.repo_name
  pr_tmplt_content  = var.pr_template_content
}


resource "github_repository_collaborator" "softserve" {
  repository = local.repo_name
  username   = "softservedata"
  permission = "push"
}


resource "github_branch" "develop_branch" {
  repository     = local.repo_name
  branch         = "develop"
  source_branch  = "main"
}

resource "github_branch_default" "default_branch" {
  repository = local.repo_name
  branch     = github_branch.develop_branch.branch
}


resource "github_branch_protection" "develop_protection" {
  repository_id = github_repository.repo.node_id
  pattern       = "develop"

  required_pull_request_reviews {
    required_approving_review_count = 2
  }

  enforce_admins = true
}

resource "github_branch_protection" "main_protection" {
  repository_id = github_repository.repo.node_id
  pattern       = "main"

  required_pull_request_reviews {
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }

  enforce_admins = true
}


resource "github_repository_file" "pr_template" {
  repository          = local.repo_name
  file                = ".github/pull_request_template.md"
  content             = local.pr_tmplt_content
  branch              = "main"
  overwrite_on_create = true
  commit_message      = "Add PR template"
}


resource "github_repository_file" "codeowners" {
  repository          = local.repo_name
  file                = ".github/CODEOWNERS"
  content             = "* @softservedata"
  branch              = "main"
  overwrite_on_create = true
  commit_message      = "Add CODEOWNERS"
}


resource "github_repository_deploy_key" "deploy_key" {
  title      = "DEPLOY_KEY"
  repository = local.repo_name
  key        = var.deploy_key_public
  read_only  = false
}


resource "github_actions_secret" "pat" {
  repository      = local.repo_name
  secret_name     = "PAT"
  plaintext_value = var.pat_value
}
