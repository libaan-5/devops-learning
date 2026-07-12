# 03-configure-dns

Goal: Connect your domain to the EC2 instance using Cloudflare DNS.

Steps:

## 0) Visitors not able to access the website yet

- Visitors are currently not able to acces the website ```libaanolow.co.uk``` since there are currently no DNS records.

![alt text](<images/Screenshot 2026-07-12 135849.png>)

## 1) Add an A record

- Go to Cloudflare → DNS → Records.
- Create an A record

## 2) Add a CNAME record for www

## 3) Test the server after DNS propagation

Cloudflare will update globally within seconds to minutes.

- Visit:
```http://libaanolow.co.uk
http://www.libaanolow.co.uk```

- Confirm the NGINX landing page loads.

Lessons learned: