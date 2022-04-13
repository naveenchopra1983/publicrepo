terraform {
  source = "git::https://github.com/aws-cloud/network/tf-module-application-load-balancer.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-application-load-balancer"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../../_shared/00_Network/001_VPC"
}

inputs = {
  # Set generics inputs
  gap_code       = "app1"
  environment    = "prod"


  # Set input for ALB module
  vpc_id          = dependency.vpc.outputs.id
  subnets_ids     = dependency.vpc.outputs.front_subnets_ids
  ssl_domain_name = "*.mywebsite.com"

  forward_rules = [
    {
      rule_name        = "to-app1webservers"
      target_type      = "instance"
      port             = 443
      protocol         = "HTTPS"
      conditions       = [
        { path_pattern = { values  = ["*"] } }
      ]
    }
  ]
}