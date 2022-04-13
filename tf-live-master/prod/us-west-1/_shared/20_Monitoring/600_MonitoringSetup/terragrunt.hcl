terraform {
  source = "git::https://github.com/aws-cloud/monitoring/tf-module-monitoring-setup.git//?ref=release-1.0.0"
  #source = "../../../../../..//tf-module-monitoring-setup"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  # Set input for module
  gap_code    = "app1"
  environment = "prod"
  specification = "monitoring"
  email_notification_recipients = [
    "naveenchopra1983@gmail.com"
  ]

  email_ticketing_enabled           = true
  email_ticketing_group_database    = "Databases Team"
  email_ticketing_group_application = "Application Team"
}