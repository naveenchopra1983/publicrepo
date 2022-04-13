terraform {
  source = "git::https://github.com/aws-cloud/application/tf-module-ec2-instance.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-ec2-instance"
}

dependency "vpc" {
  config_path = "../../../_shared/00_Network/001_VPC"
}

dependency "app_servers_app1" {
  config_path = "../20_App/APP1"
}

dependency "load_balancer_apps" {
  config_path = "../40_Load_Balancer"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  gap_code                = "app1"
  environment             = "prod"
  specification           = "web"
  ami                     = "ami-0c5a8ec45979c4d1d"
  is_windows              = true
  instance_type           = "m5.large"
  instance_count          = 2
  subnet_ids              = dependency.vpc.outputs.appli_subnets_ids
  vpc_id                  = dependency.vpc.outputs.id
  default_sg_id           = dependency.vpc.outputs.ec2_windows_default_sg_id
  backup_policy           = "prod_backup-1"
  force_no_vss            = true
  disable_api_termination = true

  # Storage
  #xvdb is for D: 
  ebs_volumes = [
   {
      device_name   = "xvdb"
      snapshot_id   = "snap-0290c0e5057729ed1" # To map Ds: drive
      size          = 100
      type          = "gp3"
      specification = "data"
    }
  ]

  # Extra Inbound requests allowed
  allowed_inbound = [
    {
      from_port                = 3389
      to_port                  = 3389
      protocol                 = "tcp"
      cidr_blocks              = ["10.121.162.115/32"]
      source_security_group_id = null
      description              = "Allow RDP access from Jump Server"
    },
    {
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      cidr_blocks              = null
      source_security_group_id = dependency.load_balancer_siebel.outputs.security_group_id
      description              = "Allow HTTPS from APP1 load balancer"
    }
  ]

  # Destination security groups to open
  allowed_destinations = [
    {
      # Application server access
      from_port         = 2321
      to_port           = 2321
      protocol          = "tcp"
      security_group_id = dependency.app_servers_app1.outputs.security_group_id
      description       = "Allow access from APP1 Web servers"
    }
  ]

  # Register instances into the load balancer target group
  target_group_arns = [
    dependency.load_balancer_siebel.outputs.target_group_arns_by_rule_name["to-app1webservers"]    
  ]
}
