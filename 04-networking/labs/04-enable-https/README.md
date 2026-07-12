# 04-enable-https

Goal: Secure the website using HTTPS via Cloudflare SSL.

Steps:

## 1) Enable Cloudflare proxy

In Cloudflare DNS, switch both records to Proxied (orange cloud).
This activates Cloudflare’s CDN and security layer.

## 2) Configure SSL mode

Go to Cloudflare → SSL/TLS.
Set SSL mode to Full (or Full (Strict) if using origin certificates).

## 3) (Optional) Install Cloudflare Origin Certificate

Generate an Origin Certificate in Cloudflare.
Upload it to your EC2 instance.
Update your NGINX config to use the certificate and key.

## 4) Restart NGINX

```sudo systemctl restart nginx```

## 5) Test HTTPS
Visit ```https://libaanolow.co.uk``` and confirm the padlock icon appears.

Lessons learned: