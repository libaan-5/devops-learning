terraform {
  required_providers {
    aws = {
      source  = var.aws_source
      version = var.aws_version
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

resource "aws_key_pair" "main" {
  key_name   = var.key_pair
  public_key = file("~/.ssh/id_ed25519.pub")
}

# Reference existing VPC
data "aws_vpc" "default" {
  id = var.vpc_id
}


resource "aws_instance" "this" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  associate_public_ip_address  = true
  key_name                = aws_key_pair.main.key_name
  vpc_security_group_ids = [aws_security_group.wordpress.id]
  user_data = <<-EOT
#!/bin/bash
dnf update -y
dnf install -y httpd php php-common php-fpm php-gd php-mysqlnd wget tar 

systemctl enable httpd
systemctl start httpd

systemctl enable php-fpm
systemctl start php-fpm

cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
cp -r wordpress/* .
chown -R apache:apache /var/www/html
EOT

}

# security groups

resource "aws_security_group" "wordpress" {
  name        = "wordpress"
  vpc_id      = data.aws_vpc.default.id
}


resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.wordpress.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.wordpress.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# I can repeat the resource type and simply change the rules. 
# Terraform expects me to define multiple SG rules when using the best‑practice.

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.wordpress.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


