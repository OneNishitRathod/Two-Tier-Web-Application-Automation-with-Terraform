terraform {
  backend "s3" {
    bucket = "staging-group12-finalproject"        // Bucket where to SAVE Terraform State
    key    = "staging-WebServer/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                           // Region where bucket is created
  }
}