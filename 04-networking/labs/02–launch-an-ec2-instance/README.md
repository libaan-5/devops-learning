# 02-launch-ec2-and-install-nginx

Goal: Launch an EC2 instance and deploy a basic NGINX web server.

Steps:

## 1) Create an EC2 instance

- First, I went to the AWS EC2 dashboard and clicked launch instance.
- I chose Amazon Linux 2023 AMI 2023.12.20260710.0 x86_64 HVM kernel-6.18 (free‑tier eligible). 
- I also Selected t3.micro instance type and created an SSH key pair.
- In the security group, I allowed HTTP traffic from the internet (0.0.0.0/0) ```(port 80)``` and I also allowed SSH traffic from Anywhere (0.0.0.0/0) ```(port 22)```.

![alt text](images/image.png)

## 2) Connect to the instance

- After dragging the ```.pem``` file into my terminal, it gave me the file path for Windows as ``` C:\Users\libaa\Downloads\website-key-pair.pem ```
- This meant that I had to prefix the fiepath with /mnt/c instead, and change the filepath from backslashes ```(\)``` to forward slashes ```(/)```.

![alt text](<images/Screenshot 2026-07-12 181953.png>)

- Connect via SSH:
- ```chmod 400``` is necessary to ensure the keypair is only readable by the user group (me), which is intended as a security feature.
```
chmod 400 website-key-pair.pem
ssh -i "website-key-pair.pem" ec2-user@ec2-16-170-201-254.eu-north-1.compute.amazonaws.com
```

## 3) Install and start NGINX

- Run the following commands:
```sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
```

## 4) Test the server

- I copied the EC2 public IPv4 address and visited the IP ```http://16.170.201.254/``` on my browser.

![alt text](<images/Screenshot 2026-07-12 182625.png>)

---

- I made sure to prefix ```http``` instead of ```https``` since it was not enabled.

![alt text](<images/Screenshot 2026-07-12 184743.png>)

---

- After the EC2 was running and the nginx install/start commands were ran, this was displayed which shows that nginx was successfully installed. 
- Previously, if I visited the public IPv4, nothing would appear so this is a good sign as it shows me signs of life.

![alt text](<images/Screenshot 2026-07-12 182613.png>)


Lessons learned:

- HTTP traffic from the internet is ```(port 80)``` and SSH traffic from Anywhere is ```(port 22)```.