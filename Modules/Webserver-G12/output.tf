#LoadBalancerApp_dns_name
output "LoadBalancerApp_dns_name" {
  value       = aws_lb.LoadBalancerApp.dns_name
}