# Instance type
variable "instance_type" {
  default     = "t3.micro"
  description = "Type of the instance"
  type        = string
}


# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}

variable "path_to_linux_key" {
  default     = "/home/ec2-user/.ssh/Group-No-12-dev.pub"
  description = "Path to the public key to use in Linux VMs provisioning"
  type        = string
}

#Desired Capacity 
variable "desired_capacity" {
  default     = 2
  type        = number
  description = "Optimal Capacity"
}

#Minimum group size for auto scaling
variable "minimum_size" {
  default     = 2
  type        = number
  description = "Minimum group size for auto scaling"
}
#Maximum group size for auto scaling
variable "maximum_size" {
  default     = 4
  type        = number
  description = "Maximum group size for auto scaling"
}