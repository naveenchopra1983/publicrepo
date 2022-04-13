terraform {
  source = "git::https://github/aws-cloud/security/tf-module-guard-duty.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-guard-duty"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  # Set input for guard-duty module
  join_master_security_account = true
}
