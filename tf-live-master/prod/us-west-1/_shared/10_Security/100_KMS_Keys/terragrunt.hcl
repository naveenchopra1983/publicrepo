terraform {
  source = "git::https://github.com/aws-cloud/security/tf-module-kms-keys.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-kms-keys"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  gap_code    = "app"
  environment = "prod"
  specification = "kms-keys"
  keys = {
    data-high = {
      description = "Encrypt data with high criticality"
      extra_aliases = null
      extra_iam_policies = null
    },
    logs-high = {
      description = "Encrypt logs with high criticality"
      extra_aliases = null
      extra_iam_policies = null
    }
  }
}
