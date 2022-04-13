terraform_version_constraint = "0.12.20"

remote_state {
  backend = "s3"
  config = {
    bucket         = "prod-s3-awsterra-state"
    key            = "global/${path_relative_to_include()}/terraform.tfstate"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:us-east-1:795153100861:key/116acc76-9043-4852-a0dd-715c2f7ae44c"
    dynamodb_table = "prod-awsterra-lock"
    profile        = "aws-prod-account"
    region         = "us-east-1"
  }
}

inputs = {
  # Set general inputs
  profile = "aws-prod-account"
  region  = "us-east-1"
  account = "prod"
}