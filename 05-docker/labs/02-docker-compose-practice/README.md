

Lessons learned:

- It's better practice to use `docker-compose.yml`, which replaces the need to add the environment variables in the terminal (manual `manual docker run -e`). 
- Next time, I will not hardcode secrets into `app.py` since `.env` exists and it's more secure. 
- Below in the image, the secrets were hardcoded in `app.py` for the simple demonstration.

![alt text](<images/Screenshot 2026-07-20 134857.png>)