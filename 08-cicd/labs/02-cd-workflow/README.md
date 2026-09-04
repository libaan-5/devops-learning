# 02-cd-workflow

Goal: Build a simple CD workflow that deploys an application or updates an environment automatically.

- I created a [new repository](https://github.com/libaan-5/actions-lab) for this lab since .github/workflows would be outside of this markdown files scope.
- The yml file for this lab can be found [here](https://github.com/libaan-5/actions-lab/blob/main/.github/workflows/run-docker-image.yml).

Steps:


## 1) Reused existing Docker Image from Docker Lab 1.

- I iteratively began creating the yml file, allowing it to run on push and on workflow_dispatch.

## 2) In the yml file, I ran into this error:

```
The push refers to repository [docker.io/libaano/hello-flask-cd]
c1ddebec0858: Preparing
c434d48a85c2: Preparing
b2404c8075e4: Preparing
d2a2207b52a4: Preparing
5d2d143f3d7f: Preparing
c3772b569c3a: Preparing
8d853c8add5d: Preparing
8d853c8add5d: Waiting
c3772b569c3a: Waiting
unauthorized: access token has insufficient scopes
Error: Process completed with exit code 1.
```

- GitHub Actions did not have authorisation to push the Docker image to Docker Hub.
- I had to add a step where it would gain the necessary permissions.  

## 3) Creating the Personal Access Token (PAT)

- I gave it read, write and delete permissions.
- The expiry time on the token was kept as the default (never) - that's probably too much time seeing as the access permissions are very strong. 
- Will consider taking down the token for security reasons.

<img src="images/Screenshot (24).png" alt="alt text" width="700">

## 4) Added the PAT tokens as secrets

- From the Personal Access Tokens (PAT) I generated, I added them as secrets to GitHub (DOCKERHUB_TOKEN and DOCKERHUB_USERNAME).

<img src="images/Screenshot (23).png" alt="alt text" width="700">


## Evidence of the pipeline running correctly:

- Below, all of the steps can be seen as completed successfully.

<img src="images/Screenshot (22).png" alt="alt text" width="700">

---

---



---

- To confirm that the lab requirements was met, I visited my repositories on Docker hub and saw the created repo there.

<img src="images/Screenshot (21).png" alt="alt text" width="700">


Lessons learned:

1.) GitHub Actions can't run on localhost as it uses runners, localhost is for your own local machine. There is no connection between them.

2.) 