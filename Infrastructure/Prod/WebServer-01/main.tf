#Calling the Globalvars
module "globalvars" {
  source = "../../../Modules/globalvars"
}
# module to deploy basic networing for Staging  
module "prod-webServer" {
  source            = "../../../Modules/Webserver-G12"
  env               = var.env
  instance_type     = var.instance_type
  path_to_linux_key = var.path_to_linux_key
  maximum_size      = var.maximum_size
  minimum_size      = var.minimum_size
  desired_capacity  = var.desired_capacity
  prefix            = module.globalvars.prefix
  default_tags      = module.globalvars.default_tags

}

