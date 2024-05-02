#Defining the Global Vars
#defining Default Tags
output "default_tags" {
  value = {
    "App"   = "Web-Application-TerraformAutomation"
    "Project" = "Final-Project-ACS730"
  }
}

# Default Prefix 
output "prefix" {
  value     = "Group-No-12"
}