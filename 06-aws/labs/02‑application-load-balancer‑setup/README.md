# 02‑application-load-balancer‑setup

Goal: Deploy two EC2 instances behind an ALB. The ALB must handle all incoming traffic. EC2 instances should not be accessible directly from the internet.

This means that the ALB is the only public entry point. The EC2 instances sit in private subnets and are NOT directly reachable from the internet.

Steps:

## 1) Launch two EC2 instances in the same VPC

- It was better for me to make 2 private subnets since both EC2 instances should not be directly reachable from the internet.
- From the previous task where I setup the VPC, I had already configured a public and private route table so I reused them for the public and private subnet.

Private subnet associated to the private routing table:

<img src="images/Screenshot 2026-08-11 160756.png" alt="alt text" width="700">

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

- Creating the Target Group 
- I selected instances as the target (instead of other options like IP) and I kept everything as default 
- I then moved onto step 2 - registering the targets. I selected both EC2's and finished creating the target group. 

![alt text](<images/Screenshot 2026-08-11 183219.png>)

- The ALB will send HTTP requests to the root path / of each EC2 instance to verify they’re healthy.

<img src="images/Screenshot 2026-08-11 184043.png" alt="alt text" width="700">

## 3. Security Groups

- I created a new SG for the ALB: and I allowed it to HTTP from anywhere and kept outbounds the same.
- After creating the SG for the ALB, I finally created the ALB.

- For the EC2 SG I edited it to only allow HTTP access from the ALB SG, meaning NO direct public access to EC2.

## 4. Testing

- Visit the ALB DNS name

- Refresh to verify traffic alternates between both instances

- Confirm health checks are healthy

## Bonus (Optional)

- Add a Route53 DNS name and point it to the ALB DNS name via ALIAS record type. 

- Add an HTTPS listener with ACM

- Add an Auto Scaling Group behind the ALB

- Keep screenshots and notes for your repo.

Lessons learned:

1) I don't need to create new subnets if I already have existing ones. 
- For this assignment, I quickly caught this and decided to use public-01 (from previous assignment) with the newly created 'public-for-ALB', however I incorrectly made an additional private subnet (from previous assignment) perfectly ready to use.

2) 