terraform {
  backend "s3" {
    bucket = "terra-state-mpr"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}