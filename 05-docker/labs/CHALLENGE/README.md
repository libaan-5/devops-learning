# CHALLENGE

Goal: Create a multi-container application that consists of a simple Python Flask web application and a Redis database. The Flask application should use Redis to store and retrieve data.

## Requirements

1. **Flask Web Application**:
   - A Flask app that has two routes:
     - `/`: Displays a welcome message.
     - `/count`: Increments and displays a visit count stored in Redis.

2. **Redis Database**:
   - Use Redis as a key-value store to keep track of the visit count.

3. **Dockerize Both Services**:
   - Use Docker Compose to manage the multi-container application.
   - Note: The challenge mentions creating Dockerfiles for both services. However, Redis is already available as an official Docker image, so creating a custom Dockerfile is unneeded. A better approach is to use the official Redis image and only create a Dockerfile for the Flask application.

Steps: 

---

## 0) Researching Redis Integration 

- I visted the [Redis documentation website](https://redis.io/docs/latest/develop/clients/redis-py/) to see the code I needed to get a Redis web application up and running.

![alt text](<images/Screenshot 2026-07-23 185619.png>)

---

## 1) Creating the Flask Web Application and Docker Configuration

- I tried to run `docker compose up` with the version `version: '3.8'` in the docker-compose.yml file, however it's better practice nowadays to exclude the version.

![alt text](<images/Screenshot 2026-07-23 201424.png>)

## 2) Debugging and Rebuilding the Docker Containers

- After I removed the version number from the `docker-compose.yml` file, I attempted to build the image and run the app but ran into some issues:
1) The app.py had the same function names (accidentally) for routes
2) The Redis key was previously not defined as a string, I fixed it: `visits = r.incr("visits", amount=1)`.

---

- Since the image above was defective, first I exited the container using CTRL + C. 
- Next, I ran `docker compose down` to formally shut the container down.
- Then I ran `docker compose up --build` to create a new image and then run it using the same tag from the original build.

![alt text](<images/Screenshot 2026-07-23 205407.png>)

## 3) Running the Multi-Container Application

- After the issues mentioned above were sorted out, I ran the container via `docker compose up --build` and the web application was up and running correctly.

![alt text](<images/Screenshot 2026-07-23 205153.png>)

- I ran `docker ps` to confirm that the 2 containers were up and running.

![alt text](<images/Screenshot 2026-07-23 204205.png>)

## 4) Testing the Application

![alt text](<images/Screenshot 2026-07-23 203751.png>)

- After refreshing the page on `localhost:5003/count` two more times, the visit count updated to 3 seen below.

![alt text](<images/Screenshot 2026-07-23 203756.png>)


Lessons learned:

- Docker Compose automatically creates a network.
- Inside Docker, containers communicate using service names.
- This is why in `app.py`, the host `r = redis.Redis(host="db"...)` had to match the service name in the `docker-compose.yml` file.


## Bonus

- Persistent Storage for Redis: Configure Redis to use a volume to persist its data.
- Environment Variables: Modify the Flask application to read Redis connection details from environment variables and update the docker-compose.yml accordingly.
- Scaling the Application: Scale the Flask service to run multiple instances and load balance between them using Docker Compose.