# 01-flask-web-app

Goal: Containerize a flask web application.

Steps:

## 1) Create the flask web application.

- I ran basic flask code and got the web app running via localhost. 

![alt text](<images/Screenshot 2026-07-13 205234.png>)

- I had to create a virtual environment since I ran into an externally-managed-environment error (PEP 668) issue. 
- This happens because newer Ubuntu-based systems follow PEP 668, which prevents pip from installing packages directly into the system Python environment.
![alt text](<images/Screenshot 2026-07-13 205751.png>)

## 2) Create a virtual environment (venv).

- Instead of installing packages globally, Python projects should use a virtual environment (venv) to isolate project dependencies.

```
python3 -m venv .venv
source .venv/bin/activate
```
- This changed the prompt to ```(.venv) ➜ flask-web-app```.

## 3) Run the flask web application. 

- With the venv activated, I was able to install flask and run the flask web app with the following commands:
```
pip install flask
python app.py
``` 

## 4) Create the dockerfile and build the image. 

I created the docker file and used the command ```docker build -t hello-flask .``` to run it. 
- ```docker build``` is the main command used to build the image.
- ```-t hello-flask``` gives the docker image a name.
- ```.``` searches the open directory for the dockerfile to run. 

![alt text](<images/Screenshot 2026-07-13 202917.png>)

- However, I ran into an issue where the docker image was not able to continue building based off a ```RUN``` command I had set.

![alt text](<images/Screenshot 2026-07-13 202911.png>)

- The affected ```RUN``` command was: ```apt install python3-pip python3-venv python-is-python3```.
- To fix it, I had to add the ```-y``` flag to the command, seen in the image below:

![alt text](<images/Screenshot 2026-07-13 205119.png>)

---

**IMPORTANT:**

I figured out that I didn't need to add ```apt install python3-pip python3-venv python-is-python3```.
- This was because ```python:3.8-slim``` already includes Python and pip. Additionally, flask was not installed.
- Therefore, I just replaced the ```RUN``` command with ```pip install flask```.

![alt text](<images/Screenshot 2026-07-13 224908.png>)

## 5) Run the Docker container

- Due to the change in the Dockerfile above, I had to rebuild the image. 
- First, I had to remove the previous stopped container.
- I checked the container logs using the container ID and found that the container had exited because Flask was not installed inside the Docker image.

![alt text](<images/Screenshot 2026-07-13 232354.png>)

- Although I believed the container was deleted since it did not appear after running ```docker ps```, it was actually stopped.
- `docker ps` only displays currently running containers. To view both running and stopped containers, `docker ps -a` must be used.
- After the container was deleted, I was allowed to delete the existing image.

![alt text](<images/Screenshot 2026-07-13 230950.png>)

---

- I moved into the web app directory using ```cd 05-docker/labs/01-flask-web-app``` and rebuilt and ran the image, creating a running container.
- The `-p 5000:5000` option maps port 5000 on the host machine to port 5000 inside the Docker container. This allows the Flask application running inside the container to be accessed through localhost.

![alt text](<images/Screenshot 2026-07-13 231006.png>)

- After this, the web app was successfully running with the container.

![alt text](<images/Screenshot 2026-07-13 231704.png>)

Lessons learned:

1.) Docker makes it surprisingly easy to package and deploy applications across different environments.

2.) python:3.8-slim already includes Python and pip.

3a.) The Flask package installed inside my local virtual environment was not available inside Docker because containers are isolated from the host machine. Dependencies must be installed during the Docker image build process.
3b.) It is common practice for real projects to have more than 1 dependency. For the ``RUN`` Dockerfile instruction, instead of ```pip install flask``` it may be ```RUN pip install -r requirements.txt```.

4.) To view both running and stopped containers, `docker ps -a` must be used.
