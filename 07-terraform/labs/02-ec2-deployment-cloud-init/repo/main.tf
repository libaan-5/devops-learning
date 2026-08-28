terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# Reference existing VPC
data "aws_vpc" "default" {
  id = var.vpc_id
}

# Reference existing keypair
data "aws_key_pair" "example" {
  key_name           = var.key_pair
  include_public_key = true
}

# Create EC2 instance
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  associate_public_ip_address  = true
  key_name                = data.aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data = <<-EOT
#cloud-config
package_update: true
packages:
  - nginx
runcmd:
  - systemctl enable nginx
  - systemctl start nginx
EOT
}

# security group

resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id # referenced the data block id to ensure that the vpc is validated. 
}

# ssh - port 22
# only my IP should be able to access the EC2 instance

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "82.5.65.246/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# http - port 80
# fine for public to EC2 instance

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}