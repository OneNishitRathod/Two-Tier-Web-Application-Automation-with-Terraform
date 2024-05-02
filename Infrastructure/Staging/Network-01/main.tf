#Calling the Globalvars
module "globalvars" {
  source = "../../../Modules/globalvars"
}
# module to deploy basic networing for Staging  
module "staging-networing" {
  source              = "../../../Modules/Network-G12"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  private_cidr_blocks = var.private_subnet_cidrs
  public_cidr_blocks  = var.public_subnet_cidrs
  prefix              = module.globalvars.prefix
  default_tags        = module.globalvars.default_tags

}
