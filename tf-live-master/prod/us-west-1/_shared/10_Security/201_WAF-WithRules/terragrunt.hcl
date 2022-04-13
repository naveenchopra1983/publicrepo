terraform {
  source = "git::https://github.com/aws-cloud/security/tf-module-waf-regional.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-waf-regional"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  gap_code    = "app1"
  environment = "prod"
  specification = "waf-with-rules"

  # Set input for AWS WAF module

  enable_logging = true
  kms_key_arn    = "arn:aws:kms:eu-west-1:795153100861:key/116acc76-9043-4852-a0dd-715c2f7ae44c"

  # Rules configuration
  whitelist-multipart       = true
  bruteforce-protected-urls = [ "/processlogin" ]
  whitelisted-urls = [
    # ===================== #
    # application
    # ===================== #

    # LiveCycle calls to /portal/livecycle/public/MYAPP_CertifMgt/ProcessForm_REST.do (content-type = application/pdf)
    "/livecycle/public/",
    "/portal/livecycle/public/"
  ]
}