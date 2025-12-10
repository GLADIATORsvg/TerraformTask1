resource "github_repository_file" "pr_template" {
  repository          = local.repo_name
  file                = ".github/pull_request_template.md"
  content             = <<EOF
Describe your changes

Issue ticket number and link

Checklist before requesting a review:
- [ ] I have performed a self-review of my code
- [ ] If it is a core feature, I have added thorough tests
- [ ] Do we need to implement analytics?
- [ ] Will this be part of a product update? If yes, please write one phrase about this update
EOF
  branch              = "main"
  overwrite_on_create = true
  commit_message      = "Add PR template"
}
