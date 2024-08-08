output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "cert_validation" {
  value = aws_acm_certificate.website_cert.domain_validation_options
}