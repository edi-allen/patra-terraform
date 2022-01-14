output "alb_dns_name" {
  value       = aws_lb.webservers.dns_name
  description = "The domain name of the load balancer"
}

output "bastion_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Public IP address of the bastion host"
}
