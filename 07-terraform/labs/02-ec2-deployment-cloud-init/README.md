# Terraform Cloud-Init Project

Goal: Configure a cloud-init file and use Terraform to automate an EC2 deployment.

Demonstrate:
- How Terraform uses user_data or user_data_base64
- How cloud-init automates instance configuration
- How to structure Terraform for clarity (variables, outputs, modules if needed)

Steps:

## 1) Write a cloud-init YAML file

- Instead of having the shebang line `#!/bin/bash`, I swapped it to the Cloud-config YAML format.

<img src="images/Screenshot 2026-08-26 132737.png" alt="alt text" width="700">

## 2) Configure software on boot (e.g. NGINX or Apache) via cloud-init to the EC2 instance through Terraform

- After running terraform plan, there are a lot of resource attributes/values that are known/known after running terraform apply.
- Near the bottom, private_ip and private_dns are known after applying, and I chose to simply add them as output blocks in outputs.tf so I could visit the http URL after launching the EC2 instance.

<img src="images/Screenshot 2026-08-28 103623.png" alt="alt text" width="700">

## 3)Ensure the instance comes online fully configured with no manual steps

The instance came online with no manual steps, all I did was:
- Run terraform plan and terraform apply (required to launch any infrastructure)
- Typing yes to accept the terraform apply changes (Terraform’s built‑in safety confirmation, not a manual configuration step.)

<img src="images/Screenshot 2026-08-28 104440.png" alt="alt text" width="700">

---

Below, nginx displays showing that the terraform code worked and the lab was completed.

<img src="images/Screenshot 2026-08-28 104246.png" alt="alt text" width="700">

Lessons learned:

- Terraform does not allow variables in required_providers for source or version. These must be known during Terraform's initialization, before normal variables are evaluated.

- Every single data block in Terraform must be referenced using the `data.<TYPE>.<NAME>` prefix.  
 
Definitions:

cloud-init
- A Linux bootstrapping system (tool) that runs on the EC2 instance automatically at startup. It's installed by default.

user-data 
- The script/commands you give cloud-init to execute”  

systemctl enable
- Configures the service to start automatically on boot. systemctl enable does NOT start the service immediately.
- Example: Nginx will auto-start every time the EC2 instance boots (persistent boot configuration).

systemctl start 
- Starts the service right now. 
- Both systemctl commands control systemd services (the init system).
