
# Output variables for Public Subnets
output "public_subnet_ids" {
  value = module.prod-networking.public_subnet_ids
}

# Output variables for VPC 
output "vpc_id" {
  value = module.prod-networking.vpc_id
}
# Output variables for Private VPC
output "private_subnet_ids" {
  value = module.prod-networking.private_subnet_ids
}


# Output variables for Internet Gateway
output "aws_internet_gateway" {
  value = module.prod-networking.aws_internet_gateway
}

# Output variables for Elastic IP

output "aws_eip" {
  value = module.prod-networking.aws_eip
}

# Output variables for Private Route

output "private_route_table" {
  value = module.prod-networking.private_route_table
}

# Output variables for Public Route Table

output "public_route_table" {
  value = module.prod-networking.public_route_table
}

# Output variables for Public Cidr Block
output "public_cidr_blocks" {
  value = module.prod-networking.public_cidr_blocks
}

# Output variables for Private CIDR block 
output "private_cidr_blocks" {
  value = module.prod-networking.private_cidr_blocks
}


