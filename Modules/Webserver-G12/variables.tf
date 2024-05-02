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

# Instance type
variable "instance_type" {

  description = "Type of the instance"
  type        = string
}


# Variable to signal the current environment 
variable "env" {

  type        = string
  description = "Deployment Environment"
}

#Maximum capacity for the Auto scaling group
variable "desired_capacity" {

  type        = number
  description = "Maximum capacity for the Auto scaling group"
}

#Minimum group size for auto scaling
variable "minimum_size" {

  type        = number
  description = "Minimum group size for auto scaling"
}
#Maximum group size for auto scaling
variable "maximum_size" {

  type        = number
  description = "Maximum group size for auto scaling"
}

variable "path_to_linux_key" {

  description = "Path to the public key to use in Linux VMs provisioning"
  type        = string
}



