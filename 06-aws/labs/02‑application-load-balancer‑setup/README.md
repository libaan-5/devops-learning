# 02‑application-load-balancer‑setup

Goal: Deploy two EC2 instances behind an ALB. The ALB must handle all incoming traffic. EC2 instances should not be accessible directly from the internet.

This means that the ALB is the only public entry point. The EC2 instances sit in private subnets and are NOT directly reachable from the internet.

Steps:

## Architecture Diagram

- Created an architecture diagram for the assignment
- This architecture diagram was created iteratively as I progressed with the assignment (e.g. updating the AZ names).
- A bastion was created and deleted to SSH into the private EC2's (with no IP) to verify httpd was running.
- Removed the bastion and switched to SSM for cost + it's the modern AWS-recommended pattern + this assignment didn't need one.

<img src="images/Screenshot 2026-08-12 212306.png" alt="alt text" width="700">

## 1) Launch two EC2 instances in the same VPC

- It was better for me to make 2 private subnets since both EC2 instances should not be directly reachable from the internet.
- From the previous task where I setup the VPC, I had already configured a public and private route table so I reused them for the public and private subnet.

Private subnet associated to the private routing table:

<img src="images/Screenshot 2026-08-12 223505.png" alt="alt text" width="700">

Public subnet associated to the public routing table:

<img src="images/Screenshot 2026-08-11 160808.png" alt="alt text" width="700">

- Next I launched 2 EC2 instances in the private subnet I created previously.
- I had to create seperate private subnets because I had to use different availability zones to ensure high availability.
- On both EC2 instances, I installed a simple web server using user-data, each returning different content for testing. 
- [This is the code](https://stackoverflow.com/a/56925421) that I used below:

Server A
```
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd

AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

echo "<h1>Server A in AZ $AZ</h1>" > /var/www/html/index.html
```

Server B
```
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd

AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

echo "<h1>Server B in AZ $AZ</h1>" > /var/www/html/index.html
```

## 2) Create an ALB in two public subnets

<img src="images/Screenshot 2026-08-11 181959.png" alt="alt text" width="700">

- I attached the public subnets to the Application Load balancer
- I also made the ALB internet facing and configured it to IPv4.

<img src="images/Screenshot 2026-08-11 182311.png" alt="alt text" width="700">

- I made sure to keep the listener as the default option, protocol: HTTP (port 80).
- I needed to create a Target Group so I clicked on the blue link that says “create target group”.
<img src="images/Screenshot 2026-08-11 182720.png" alt="alt text" width="700">

**Creating the Target Group** 
- I selected instances as the target (instead of other options like IP) and I kept everything as default 
- I then moved onto step 2 - registering the targets. I selected both EC2's and finished creating the target group. 

<img src="images/Screenshot 2026-08-11 183219.png" alt="alt text" width="700">

- The ALB will send HTTP requests to the root path / of each EC2 instance to verify they’re healthy.

<img src="images/Screenshot 2026-08-11 184043.png" alt="alt text" width="700">

## 3. Security Groups

- I created a new SG for the ALB: and I allowed it to HTTP from anywhere and kept outbounds the same.
- After creating the SG for the ALB, I finally created the ALB.

- For the EC2 SG I edited it to only allow HTTP access from the ALB SG, meaning NO direct public access to EC2.

## 4. Testing

**Visiting the ALB DNS name**
- Visible in the bottom right of the screenshot, I copied it into my browser.

<img src="images/Screenshot 2026-08-12 234612.png" alt="alt text" width="700">

**Error when visiting the ALB DNS - 502 Bad Gateway** 
- It tried to forward the request to a target (one of the private EC2 instances).
- The private subnets' route table (private-RT-for-VPC) only had the local route — no 0.0.0.0/0 → NAT Gateway entry. 
- I created a NAT gateway and added it as a route.
- Previosly the user-data script `yum install -y httpd` silently failed (no route to Amazon's package repos). Since the httpd did not install nothing was listening on port 80 resulting in the 502 error above.

**Unable to SSH into EC2 instances (no IP)** 
- I applyied an IAM role to each instance and I was then able to connect to the private EC2's by rebooting the instances (the SSM was taking a long time load and finally finished loading after rebooting).
- At the bottom you can see I manually installed httpd on both private EC2s, and I ran `curl localhost` to see the echo command from the user-data.

<img src="images/Screenshot 2026-08-12 234127.png" alt="alt text" width="700">

---

- I refreshed to verify that traffic alternates between both instances:

<img src="images/Screenshot 2026-08-12 233940.png" alt="alt text" width="700">

<img src="images/Screenshot 2026-08-12 233935.png" alt="alt text" width="700">

- Confirmed that health checks were healthy:

![alt text](<images/Screenshot 2026-08-12 234251.png>)

## Bonus (Optional)

- Add a Route53 DNS name and point it to the ALB DNS name via ALIAS record type. 

- Add an HTTPS listener with ACM

- Add an Auto Scaling Group behind the ALB

- Keep screenshots and notes for your repo.

Lessons learned:

1.) I didn't need to create a bastion to SSH in and verify httpd was running (since the private EC2s had no public IP), AWS Systems Manager Session Manager is cheaper, more modern, and not something the brief actually required.

2.) Private subnets need outbound internet too, not just no inbound access. My user-data script's `yum install -y httpd` failed silently at boot with no NAT route, this caused the 502 from the ALB.

3a.) SG rules should reference other SGs, not IPs, when the source is an AWS resource. 
- I set my private EC2's SSH rule to my own IP instead of the bastion's SG, so nothing could actually connect. 

3b.) SG's have this quirk where you can't delete and re-add as an SG-referenced rule (can't edit a CIDR rule into one).

4.) My instances didn't appear in Session Manager until I rebooted them (the SSM Agent seems to cache credentials at boot).

5.) NAT Gateways, Application Load Balancers, Elastic IP's, instances and volumes all cost money, delete all and stop instances if they're useful.