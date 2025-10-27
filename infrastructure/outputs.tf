output "bastion_host_ip_address" {
  value       = aws_instance.bastion-host.public_ip
  description = "The Public Ip Address of the Bastion Host"
}

output "cicd_host_ip_address" {
  value       = aws_instance.cicd-host.private_ip
  description = "The Private Ip Address of the Bastion Host"
}
