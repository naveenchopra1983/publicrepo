terraform {
  source = "git::https://github.com/aws-cloud/network/tf-module-vpc.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  gap_code      = "app1"
  environment   = "prod"
  specification = "vpc"
  # Set input for VPC module
  vpc_cidr               = "10.122.0.0/21"
  front-A_cidr           = "10.122.0.0/24"
  front-B_cidr           = "10.122.1.0/24"
  appli-A_cidr           = "10.122.2.0/24"
  appli-B_cidr           = "10.122.3.0/24"
  db-A_cidr              = "10.122.4.0/24"
  db-B_cidr              = "10.122.5.0/24"

}