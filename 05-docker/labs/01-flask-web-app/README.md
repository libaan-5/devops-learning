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

## 5) Run the Docker container

Lessons learned:
