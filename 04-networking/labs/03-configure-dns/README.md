# 03-configure-dns

Goal: Connect the domain ```libaanolow.co.uk``` to the EC2 instance using Cloudflare DNS.

Steps:

## 0) [BEFORE] Website not reachable

- Before adding DNS records, visitors could not access: ```libaanolow.co.uk``` because the domain had no A record pointing to the EC2 instance.

![alt text](<images/Screenshot 2026-07-12 135849.png>)

## 1) Add an A record

- I went to to Cloudflare → DNS → Records and created an A record.
- I added the public IPv4 that was assigned to my EC2 instance to the record. 

![alt text](<images/Screenshot 2026-07-12 204215.png>)

- Type: A
- Name: @
- Content: Public IPv4 of my EC2 instance
- Proxy: DNS only (grey cloud)

## 2) Add a CNAME record for www

## 3) [AFTER] Test the server after DNS propagation

Cloudflare will update globally within seconds to minutes.

- After visiting the website ```http://libaanolow.co.uk```, it wasn't initially loading.
- However, after running ```sudo systemd-resolve --flush-caches``` which flushed the cache the website was able to load. 

![alt text](<images/Screenshot 2026-07-12 204040.png>)


Lessons learned:

When making an A record:
- If Name = ```@``` -> ```libaanolow.co.uk``` → your EC2 IP
- If Name = ```www``` -> ```www.libaanolow.co.uk``` → your EC2 IP