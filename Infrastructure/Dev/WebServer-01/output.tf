/*#Bastion Public IP
output "bastion_eip" {
  value = module.dev-webServer.bastion_eip
}
*/

output "bastioLoadBalancerApp_dns_name" {
  value = module.dev-webServer.LoadBalancerApp_dns_name
}