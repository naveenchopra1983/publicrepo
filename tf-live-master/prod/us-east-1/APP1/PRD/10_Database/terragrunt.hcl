terraform {
  source = "git::https://github.com/aws-cloud/data/tf-module-rds.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-rds"
}

dependency "vpc" {
  config_path = "../../../_shared/00_Network/001_VPC"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  gap_code                   = "app1"
  environment                = "prod"
  specification           =    "db"
  number                     = "1"
  db_name                    = "APP1PRODDB"
  engine                     = "oracle-se"
  engine_version             = "19.0.0.0.ru-2022-01.rur-2022-01.r1"
  license_model              = "bring-your-own-license"
  instance_type              = "db.r5.4xlarge"
  backup_retention_period    = "prod"
  enable_backup_dr           = true
  auto_minor_version_upgrade = false
  allocated_storage          = 1500
  max_allocated_storage      = 2000
  #availability_zone          = "eu-west-1a"
  multi_az                   = true
 
  # Network configuration
  subnet_ids          = dependency.vpc.outputs.db_subnets_ids
  vpc_id              = dependency.vpc.outputs.id

  allowed_cidr_blocks = [
    "10.122.2.0/24",  # Allow access from AZ1 App servers appli-A_cidr
    "10.122.3.0/24", # Allow access from AZ2  App servers appli-B_cidr
	]

   allowed_cidr_blocks_unsecure = [

  ]

  # Database configuration
  instance_parameters = [
 	{
      name         = "optimizer_features_enable"
      value        = "19.0.0.0"
      #apply_method = "pending-reboot"
    },
    {
      name         = "memory_target"
      value        = "0"
      apply_method = "pending-reboot"
    },
    {
      name         = "memory_max_target"
      value        = "0"
      apply_method = "pending-reboot"
    },
    {
      name         = "shared_pool_size"
      value        = "1048576000"
      apply_method = "pending-reboot"
    },
    {
      name         = "workarea_size_policy"
      value        = "auto"
      apply_method = "pending-reboot"
    },
    {
      name         = "open_cursors"
      value        = "3000"
      apply_method = "pending-reboot"
    },
    {
      name         = "cursor_sharing"
      value        = "exact"
      apply_method = "pending-reboot"
    },
    {
      name         = "session_cached_cursors"
      value        = "50"
      apply_method = "pending-reboot"
    },
    {
      name         = "processes"
      value        = "2500"
      apply_method = "pending-reboot"
    },
    {
      name         = "statistics_level"
      value        = "typical"
      apply_method = "pending-reboot"
    },
    {
      name         = "optimizer_dynamic_sampling"
      value        = "1"
      apply_method = "pending-reboot"
    },
    {
      name         = "optimizer_index_caching"
      value        = "0"
      /* apply_method = "pending-reboot" */
    },
    {
      name         = "optimizer_index_cost_adj"
      value        = "1"
      apply_method = "pending-reboot"
    },
    {
      name         = "optimizer_mode"
      value        = "all_rows"
      apply_method = "pending-reboot"
    },
    {
      name         = "optimizer_adaptive_reporting_only"
      value        = "false"
      apply_method = "pending-reboot"
    },
    {
      name         = "query_rewrite_enabled"
      value        = "false"
      apply_method = "pending-reboot"
    },
    {
      name         = "parallel_adaptive_multi_user"
      value        = "true"
      apply_method = "pending-reboot"
    },
    {
      name         = "_optimizer_max_permutations"
      value        = "100"
      apply_method = "pending-reboot"
    },
    {
      name         = "_like_with_bind_as_equality"
      value        = "true"
      apply_method = "pending-reboot"
    },
    {
      name         = "_always_semi_join"
      value        = "off"
      apply_method = "pending-reboot"
    },
    {
      name         = "_b_tree_bitmap_plans"
      value        = "false"
      apply_method = "pending-reboot"
    },
    {
      name         = "_no_or_expansion"
      value        = "false"
      apply_method = "pending-reboot"
     },
     {
       name         = "_partition_view_enabled"
       value        = "false"
       apply_method = "pending-reboot"
     },
     {
       name         = "undo_retention"
       value        = "39600"
       apply_method = "pending-reboot"
     },
     {
       name         = "star_transformation_enabled"
       value        = "false"
       apply_method = "pending-reboot"
     }
   ]
}