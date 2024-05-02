# Output variables for Public Subnets
output "public_subnet_ids" {
  value = module.dev-networing.public_subnet_ids
}

# Output variables for VPC 
output "vpc_id" {
  value = module.dev-networing.vpc_id
}
# Output variables for Private VPC
output "private_subnet_ids" {
  value = module.dev-networing.private_subnet_ids
}


# Output variables for Internet Gateway
output "aws_internet_gateway" {
  value = module.dev-networing.aws_internet_gateway
}

# Output variables for Elastic IP

output "aws_eip" {
  value = module.dev-networing.aws_eip
}

# Output variables for Private Route

output "private_route_table" {
  value = module.dev-networing.private_route_table
}

# Output variables for Public Route Table

output "public_route_table" {
  value = module.dev-networing.public_route_table
}

# Output variables for Public Cidr Block
output "public_cidr_blocks" {
  value = module.dev-networing.public_cidr_blocks
}

# Output variables for Private CIDR block 
output "private_cidr_blocks" {
  value = module.dev-networing.private_cidr_blocks
}