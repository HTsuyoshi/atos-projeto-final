output "public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_dns" {
  value = aws_instance.bastion.private_dns
}