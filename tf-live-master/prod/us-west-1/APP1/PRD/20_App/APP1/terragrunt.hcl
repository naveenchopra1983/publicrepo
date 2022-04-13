terraform {
  source = "git::https://github.com/aws-cloud/application/tf-module-ec2-instance.git//?ref=release-1.0.0"
  #source = "../../../../../../..//tf-module-ec2-instance"
}

dependency "vpc" {
  config_path = "../../../../_shared/00_Network/001_VPC"
}

dependency "db" {
  config_path = "../../10_Database"
}



include {
  path = find_in_parent_folders()
}

inputs = {
  gap_code                = "app1"
  environment             = "prod"
  specification           = "app"
  ami                     = "ami-0c5a8ec45979c4d1d"
  is_windows              = true
  instance_type           = "r5.2xlarge"
  instance_count          = 4
  subnet_ids              = dependency.vpc.outputs.appli_subnets_ids
  vpc_id                  = dependency.vpc.outputs.id
  default_sg_id           = dependency.vpc.outputs.ec2_windows_default_sg_id
  backup_policy           = "prod_backup-1"
  force_no_vss            = true
  disable_api_termination = true # Set to false if you want to destroy the EC2


  # Storage
  #xvdb is for D:

  ebs_volumes = [
   {
      device_name   = "xvdb"
      snapshot_id   = "snap-0290c0e5057729ed1" # To map  D: drive
      size          = 100
      type          = "gp3"
      specification = "data"
    }


     # Extra Inbound requests allowed
   allowed_inbound = [
    {
      from_port                = 3389
      to_port                  = 3389
      protocol                 = "tcp"
      cidr_blocks              = ["10.121.162.115/32"]
      source_security_group_id = null
      description              = "Allow RDP access from Jump Server"
    }
  ]
  
  # Destination security groups to open
  allowed_destinations = [
    {
      # DB access with SSL
      from_port         = dependency.db.outputs.ssl_port
      to_port           = dependency.db.outputs.ssl_port
      protocol          = "tcp"
      security_group_id = dependency.db.outputs.security_group_id
      description       = "Allow access from APP1 application server"
    }
  ]
}
