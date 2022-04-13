terraform {
  source = "git::https://github.com/aws-cloud/security/tf-module-waf-regional.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-waf-regional"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  gap_code      = "app1"
  environment   = "prod"
  specification = "waf-norule"

  # Set input for AWS config module
  specification = "norule"
  include_rules = false

}