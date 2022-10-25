terraform {
  backend "s3" {
    bucket = "terraform-dev-project-state"
    key    = "terraform/backend"
    region = "eu-west-1"
  }

}
