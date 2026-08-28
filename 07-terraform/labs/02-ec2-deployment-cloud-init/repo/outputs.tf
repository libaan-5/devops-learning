output "instance_public_ip" {
  description = "Public IP of the WordPress EC2 instance"
  value       = aws_instance.example.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the WordPress EC2 instance"
  value       = aws_instance.example.public_dns
}
