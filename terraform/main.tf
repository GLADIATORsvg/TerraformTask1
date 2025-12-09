#### ---------------- COLLABORATOR ---------------- ####
resource "github_repository_collaborator" "softserve" {
  repository = local.repo_name
  username   = "softservedata"
  permission = "push"
}

#### ---------------- DEVELOP BRANCH ---------------- ####
resource "github_branch" "develop_branch" {
  repository = local.repo_name
  branch     = "develop"
}

resource "github_branch_default" "default_branch_default" {
  repository = local.repo_name
  branch     = github_branch.develop_branch.branch
}

#### ---------------- BRANCH PROTECTIONS ---------------- ####
resource "github_branch_protection" "develop_protec_rules" {
  repository_id        = var.repo_name
  pattern              = "develop"
  
  required_pull_request_reviews {
    required_approving_review_count = 2
  }
}

resource "github_branch_protection" "main_protect_rules" {
  repository_id        = local.repo_name
  pattern              = "main"

  required_pull_request_reviews {
    require_code_owner_reviews      = true
    required_approving_review_count = 0
  }
}

#### ---------------- PR TEMPLATE ---------------- ####
resource "github_repository_file" "codeowners" {
  repository          = local.repo_name
  file                = ".github/CODEOWNERS"
  content             = "* @softservedata"
  branch              = "main"
  overwrite_on_create = true
}

resource "github_repository_file" "main_pr_template" {
  repository          = local.repo_name
  file                = ".github/pull_request_template.md"
  content             = local.pr_tmplt_content
  branch              = "main"
  overwrite_on_create = true
}

resource "github_repository_file" "develop_pr_template" {
  repository          = local.repo_name
  file                = ".github/pull_request_template.md"
  content             = local.pr_tmplt_content
  branch              = "main"
  overwrite_on_create = true
  depends_on          = [github_branch.develop_branch]
}

#### ---------------- DEPLOY KEY ---------------- ####
resource "github_repository_deploy_key" "deploy_key" {
  title      = "DEPLOY_KEY"
  repository = var.repo_name
  key        = "ssh-rsa AAAAB3Nza..."
}

#### ---------------- ACTIONS SECRET ---------------- ####
resource "github_actions_secret" "pat" {
  repository      = var.repo_name
  secret_name     = "PAT"
  plaintext_value = var.pat_value
}
