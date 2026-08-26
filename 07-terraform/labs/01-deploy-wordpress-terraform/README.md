# 01-deploy-wordpress-terraform

Goal: Deploy a full WordPress stack on an AWS EC2 instance, provisioned via terraform. This assignment shows how Terraform manages real infrastructure end-to-end.

Minimum Requirements

- main.tf with AWS provider, EC2 resource and required settings.
- variables.tf for inputs.
- outputs.tf for instance details.
- User data script embedded referenced.
- A successful WordPress installation.

Steps:

## 1) Configure the AWS Provider and define input variables

- I defined the AWS provider block in 'main.tf' using the Hashicorp documentation.

- I created a variables.tf file.
- Examples of variables that I created:
    - I set the region as a variable in a seperate 'variables.tf' file (referenced as var.region).
    - vpc ID, security group ID, AMI, instance type, subnet ID, keypair name

- I kept defaults simple for testing.
- I didn't create defaults for resources Terraform is supposed to create (e.g. such as the keypair and IDs).

## 2) Create a Security Group

- I created an SG in the EC2 resource.
- I allowed HTTP (80) and SSH (22) inbound and allowed all outbound traffic.

- Below, I can repeat the resource type to make multiple rules and I can change the rules. 
- Terraform expects me to define multiple SG rules for best‑practice.

<img src="images/Screenshot 2026-08-26 094948.png" alt="alt text" width="700">

## 3) Write User Data for WordPress

- Use a bash script to install Apache, PHP, and WordPress.
- Embed it directly in Terraform or load it from a file.
- Ensure the script starts the web server.

- I ran terraform apply and provisioned the infrastructure.
- I navigated to the DNS in the output and entered that in my search bar, selecting the `http://` protocol.
- I noticed that I did not have MySQL installed in the user data.

<img src="images/Screenshot 2026-08-25 223500.png" alt="alt text" width="700">

## 4) Deploy the EC2 Instance

- Use aws_instance in main.tf.
- Attach the security group.
- Use a public subnet so the instance gets a public IP.

- I created outputs.tf which I used to output useful information.
- It output the public IP and public DNS in the terminal and used it to access WordPress in the browser.


<img src="images/Screenshot 2026-08-25 225823.png" alt="alt text" width="700">

## Evidence - working WordPress site:

- I ran terraform init, terraform plan, and terraform apply.
- I waited for the instance to finish provisioning.
- I visited the URL and made sure I was using 'http' to confirm that WordPress loads.

<img src="images/Screenshot 2026-08-25 224631.png" alt="alt text" width="700">

Lessons learned:

- The server I used (Amazon Linux 2023) does not use apt for installation (since that is for ubuntu), it uses dnf. 
- I SSH'ed into the EC2 instance and then ran commands such as installing MySQL which I then added to the user-data to ensure that WordPress would run.

Documents that I used to help with this lab (specifically with the user-data):
1) https://developer.wordpress.org/advanced-administration/before-install/howto-install/#step-1-download-and-extract
2) https://serverguy.dev/web-server/how-to-host-wordpress-on-apache-serve/
