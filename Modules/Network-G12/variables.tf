# Default tags
variable "default_tags" {
  default     = {}
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix Ref from Globalvars
variable "prefix" {
  type        = string
  description = "Default Prefix Name Final Project G12"
}


# VPC CIDR range
variable "vpc_cidr" {

  type        = string
  description = "VPC to host static web site"
}

# Variable to signal the current environment 
variable "env" {

  type        = string
  description = "Deployment Environment"
}

# Provision Private subnets in custom VPC
variable "private_cidr_blocks" {

  type        = list(string)
  description = "Private Subnet CIDRs"
}

# Provision public subnets in custom VPC
variable "public_cidr_blocks" {

  type        = list(string)
  description = "public Subnet CIDRs"
  
}