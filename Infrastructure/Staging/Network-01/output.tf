

# Output variables for Public Subnets
output "public_subnet_ids" {
  value = module.staging-networing.public_subnet_ids
}

# Output variables for VPC 
output "vpc_id" {
  value = module.staging-networing.vpc_id
}
# Output variables for Private VPC
output "private_subnet_ids" {
  value = module.staging-networing.private_subnet_ids
}


# Output variables for Internet Gateway
output "aws_internet_gateway" {
  value = module.staging-networing.aws_internet_gateway
}

# Output variables for Elastic IP

output "aws_eip" {
  value = module.staging-networing.aws_eip
}

# Output variables for Private Route

output "private_route_table" {
  value = module.staging-networing.private_route_table
}

# Output variables for Public Route Table

output "public_route_table" {
  value = module.staging-networing.public_route_table
}

# Output variables for Public Cidr Block
output "public_cidr_blocks" {
  value = module.staging-networing.public_cidr_blocks
}

# Output variables for Private CIDR block 
output "private_cidr_blocks" {
  value = module.staging-networing.private_cidr_blocks
}