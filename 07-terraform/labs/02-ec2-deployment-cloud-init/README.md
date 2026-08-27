# 02-ec2-deployment-cloud-init

Goal: Configure a cloud-init file and use Terraform to automate an EC2 deployment.

Demonstrate:
- How Terraform uses user_data or user_data_base64
- How cloud-init automates instance configuration
- How to structure Terraform for clarity (variables, outputs, modules if needed)

Steps:

## 1) Write a cloud-init YAML file

- Instead of having the shebang line `#!/bin/bash`, I swapped it to the Cloud-config YAML format.

<img src="images/Screenshot 2026-08-26 132737.png" alt="alt text" width="700">

## 2) Install and configure software on boot (e.g. NGINX or Apache)

## 3) Pass cloud-init to the EC2 instance through Terraform

## 4)Ensure the instance comes online fully configured with no manual steps



Lessons learned:
 
- cloud-init = a Linux bootstrapping system (tool) that runs on the EC2 instance automatically at startup. It's installed by default.
- user-data = the script/commands you give cloud-init to execute”  

- systemctl enable = Configures the service to start automatically on boot. systemctl enable does NOT start the service immediately.
e.g. Nginx will auto-start every time the EC2 instance boots (persistent boot configuration).
- systemctl start = Starts the service right now. 

- Both commands control systemd services (the init system).