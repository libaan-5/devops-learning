# 01-deploy-wordpress-using-terraform

Goal: Use Terraform to deploy a full WordPress stack on AWS.

The setup should include:

EC2 instance running WordPress
Security groups
User data or cloud-init to install dependencies
A working public endpoint
All resources provisioned via Terraform

This assignment shows how Terraform manages real infrastructure end-to-end.

Minimum Requirements

main.tf with AWS provider, EC2 resource and required settings
variables.tf for inputs
outputs.tf for instance details
User data script embedded or referenced
A successful WordPress installation

---

Steps:

## 1) Configure the AWS Provider

- Define the AWS provider block in main.tf.
- Set the region as a variable.
- Ensure your AWS credentials are available in your environment.

## 2) Define Input Variables

- Create a variables.tf file.
- Include variables for region, instance type, key pair, and VPC/subnet IDs.
- Keep defaults simple for testing.

## 3) Create a Security Group

- Allow HTTP (80) and SSH (22) inbound.
- Allow all outbound traffic.
- Reference this SG in your EC2 resource.

## 4) Write User Data for WordPress

- Use a bash script to install Apache, PHP, and WordPress.
- Embed it directly in Terraform or load it from a file.
- Ensure the script starts the web server.

## 5) Deploy the EC2 Instance

- Use aws_instance in main.tf.
- Attach the security group.
- Provide the user‑data script.
- Use a public subnet so the instance gets a public IP.

## 6) Output Useful Information

- Create outputs.tf.
- Output the public IP or public DNS.
- Use this to access WordPress in the browser.

## Evidence - working WordPress site:

- Run terraform init, terraform plan, and terraform apply.
- Wait for the instance to finish provisioning.
- Visit the public endpoint to confirm WordPress loads.

Lessons learned: