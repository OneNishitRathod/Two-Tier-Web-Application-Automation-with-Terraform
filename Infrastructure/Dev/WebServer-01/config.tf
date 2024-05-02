terraform {
  backend "s3" {
    bucket = "dev-group12-finalproject"        // Bucket where to SAVE Terraform State
    key    = "dev-WebServer/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                           // Region where bucket is created
  }
}