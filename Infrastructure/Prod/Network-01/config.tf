#S3 Bucket Configuation for Prod 
terraform {
  backend "s3" {
    bucket = "prod-group12-finalproject"      // Bucket where to SAVE Terraform State
    key    = "prod-Network/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                         // Region where bucket is created
  }
}