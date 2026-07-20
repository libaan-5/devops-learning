# 01-flask-web-app

`Docker makes it surprisingly easy to package and deploy applications across different environments.

Goal: Containerize a flask web application using Docker.

Steps:

## 1) Create the flask web application.

- I ran basic flask code and got the web app running via localhost. 

![alt text](<images/Screenshot 2026-07-13 205234.png>)

- If I wanted to `pip install flask` **without Docker**, I would have had to create a virtual environment since `pip` can't install packages directly into the system Python environment.
- A virtual environment isn’t needed when **using Docker** because the container already isolates all dependencies.

## 2) Create the Dockerfile and build the image. 

I created the Dockerfile and used the command ```docker build -t hello-flask .``` to build the image. 
- ```-t hello-flask``` tags the image.
- ```.``` searches the open directory for the dockerfile to run. 

![alt text](<images/Screenshot 2026-07-13 224908.png>)

## 3) Run the Docker container


- From the terminal, I navigated to the project directory (`05-docker/labs/01-flask-web-app`) and built + ran the Docker image.
- The `-p 5000:5000` option maps port 5000 on the host machine to port 5000 inside the Docker container. This allows the Flask application running inside the container to be accessed through localhost.

![alt text](<images/Screenshot 2026-07-13 231006.png>)

- After this, the web app was successfully running with the container.

![alt text](<images/Screenshot 2026-07-13 231704.png>)

Lessons learned:
- python:3.8-slim already includes Python and pip.
- Containers are isolated from the host machine. Dependencies must be installed during the Docker image build process.
- It is common practice for real projects to have more than 1 dependency. For the ``RUN`` Dockerfile instruction, instead of ```pip install flask``` it may be ```RUN pip install -r requirements.txt```.
- To view both running and stopped containers, `docker ps -a` must be used. `docker ps` only displays currently running containers. 
---

**Docker Commands:**

- ```docker stop <container-id>``` <- Stops a container. The container still exists and can be started again.
- ``docker rm <container-id>`` <- Removes a stopped container permanently. The image is not affected.
- `docker rmi <image-id>` <- Removes a Docker image. Containers created from that image may need to be removed first.