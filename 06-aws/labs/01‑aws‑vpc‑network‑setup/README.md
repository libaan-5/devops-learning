# 01‑aws‑vpc‑network‑setup

Goal: Build a functional AWS network environment with public + private subnets, proper routing, and secure EC2 access.

Steps:

## 1) Create the VPC, and a public and private subnet.

I created a new VPC and called it ```test-new-vpc```, /16  gives 65,534 useable hosts.

<img src="images/Screenshot 2026-08-09 142619.png" alt="alt text" width="700">

I made the IPv4 CIDR block ```10.0.0.0/16```.

---

**2a) Creating the private subnet**

- I gave the private subnet CIDR block ```10.0.0.0/24``` (fitting inside the VPC).

<img src="images/Screenshot 2026-08-09 144614.png" alt="alt text" width="700">

**2b) Creating the public subnet** 

- I followed the same steps above to create the public subnet with the CIDR block ```10.0.1.0/24``` (fitting inside the VPC).

- To avoid overlap, I visited the [ipaddressguide](https://www.ipaddressguide.com/cidr) website and inserted the subnet CIDR block that I had already created ``````10.0.0.0/24``` (from the private subnet).
- This showed me what the last IP in the range was, which told me that I had to start on ```10.0.1.0/24``` for the public subnet.

<img src="images/Screenshot 2026-08-09 153954.png" alt="alt text" width="700">

## 3) EC2 Instances

**3a) Public EC2: to be launched in public subnet with public IP**

- Created an EC2 instance and named it ```public-EC2-for-VPC```. 
- To prevent myself from getting charged I paused the instance from running whilst I configured the remaining services.
- Before I created the EC2 instance, I disabled the `auto assign public IP toggle` since I would use an **Elastic IP** instead.

<img src="images/Screenshot 2026-08-09 175119.png" alt="alt text" width="700">

**3b) Private EC2: to be launched in private subnet without public IP**

- Created an EC2 instance and named it ```private-EC2-for-VPC```. 
- To prevent myself from getting charged I paused the instance from running whilst I configured the remaining services.
- Like the Public EC2 above, I disabled the `auto assign public IP toggle` since private EC2's are not meant to have public IP's.
- **Private EC2's should only be accessible via the NAT gateway.**
- Did some research and found out that it's acceptable to reuse keypairs between EC2 instances.

<img src="images/Screenshot 2026-08-09 182228.png" alt="alt text" width="700">

## 4) Internet Access

**4a) Create and attach an Internet Gateway.**

<img src="images/Screenshot 2026-08-09 233331.png" alt="alt text" width="900">

<img src="images/Screenshot 2026-08-09 233409.png" alt="alt text" width="900">

 - I found it quite straightfoward to create. **PRICE = FREE**
 

**4b) Create an Elastic IP** 

- **NO EC2 CONNECTION = COSTS MONEY** but **EC2 CONNECTION = FREE**
- I created the Elastic IP and made sure to quickly create a NAT gateway before I started to get charged for it not being attached to a NAT gateway. 

**4c) Create a NAT Gateway in the public subnet**

- The NAT gateway was created but it took a few minutes to start up.
- I made the mistake of not selecting **Manual** for the method of Elastic IP (EIP) allocation, so I ended up deleting the EIP that I created above. Not a huge blunder but will be something I will remember for the future.

## 5) Route Tables

- I set up a Public route table (public-01) with a default route via IGW.
- I also set up a Private route table with a default route via NAT Gateway. Both route tables were inside of the VPC.

<img src="images/Screenshot 2026-08-10 155535.png" alt="alt text" width="700">

- Shortly after configuring the route tables, I realised I couldn’t associate my public subnet with the public route table. 
- This happened because I had accidentally created a Regional NAT Gateway, which does not live inside a subnet and instead creates its own dedicated route table.  **KEY: Regional NGW's have no subnets.**
- AWS blocks subnet associations on a route table that is attached to a Regional NAT Gateway, which caused the error.

<img src="images/Screenshot 2026-08-10 162444.png" alt="alt text" width="700">


- This led me to delete the previous NGW and create a new NGW with a Zonal availability mode (classic). 
- After deleting the previous NGW, it disassociated the elastic IP (51.24.174.97), and I was able to create a new NGW and re-associate the original EIP.
- In the private routing table, I addded a route to the newly created NGW. 
- The route of the private routing table pointed to the old (now-deleted) RNAT ID and caused a blackhole, so I updated it to target the new Zonal NAT Gateway. 
- Another side effect of deleting the previous NGW was that the routing table that it came with was deleted so **I had to recreate the public routing table.**

<img src="images/Screenshot 2026-08-10 163114.png" alt="alt text" width="700">

# Final Routing Tables:

**PRIVATE ROUTING TABLE**

<img src="images/Screenshot 2026-08-10 163857.png" alt="alt text" width="700">

**PUBLIC ROUTING TABLE**

<img src="images/Screenshot 2026-08-10 163849.png" alt="alt text" width="700">

## 6) Security

- Public EC2 SG: allow SSH/HTTP only from your IP

- Private EC2 SG: allow only internal access (e.g. from public EC2 or Bastion host)

## Bonus)

- Deploy a Bastion Host to access the private EC2

- Enable CloudWatch monitoring on instances

- Document your setup and take clear screenshots.

Lessons learned:

1) It's acceptable to reuse keypairs between EC2 instances. 

2) Instead of a regional NAT gateway which has no subnet, **use the classic Zonal NAT Gateway.**

Why: 
- Regional NAT Gateways operate at the VPC level and are not placed in a subnet, when they are created they come with a routing table. 
- Zonal NAT Gateways are the classic type that live inside a specific public subnet and are used in most VPC architectures.

3) Elastic IP's can be created and attached automatically when creating a NAT gateway.
---

**Commands:**

- 