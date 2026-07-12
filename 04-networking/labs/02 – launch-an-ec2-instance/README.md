# 02-launch-ec2-and-install-nginx

Goal: Launch an EC2 instance and deploy a basic NGINX web server.

Steps:

## 1) Create an EC2 instance

Go to the AWS EC2 dashboard and click launch instance.

Choose Ubuntu Server 22.04 LTS (free‑tier eligible).

Select t2.micro instance type.

Create or select an SSH key pair.

In the security group, allow SSH (port 22) from your IP, and allow HTTP (port 80) from anywhere.

## 2) Connect to the instance

Copy the EC2 public IPv4 address.

Connect via SSH:
```ssh -i <your-key.pem> ubuntu@<EC2-PUBLIC-IP>```

## 3) Install and start NGINX

Run the following commands:
```sudo apt update
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
```

## 4) Test the server

Lessons learned:
