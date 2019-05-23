workflow "Pipeline" {
  on = "push"
  resolves = "Test"
}

action "Lint" {
  uses = "docker://clayman083/ansible-action:1.0.0"
  args = ["ansible-lint", "."]
}

action "Test" {
  needs = "Lint"
  uses = "docker://clayman083/ansible-action:1.0.0"
  args = ["ansible-playbook", "tests/test.yml", "-i", "tests/inventory", "--syntax-check"]
}
