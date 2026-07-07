# 05-collaboration-simulation

Goal: Practice open‑source workflow.
Steps:

## 1) Fork a repo on GitHub.

![alt text](<images/Screenshot 2026-07-07 142236.png>)

## 2) Clone your fork locally.

- I moved to the root folder and then I cloned the forked repo.

![alt text](<images/Screenshot 2026-07-07 144932.png>)

---

- I then moved into the cloned fork, running ```cd git_practice``` and ```code .``` to open the repo.

![alt text](<images/Screenshot 2026-07-07 145026.png>)

- After opening the repo, I wasn't sure if my directory was a Git repository so I ran ```ls -a```.
- The ```.git``` file confirmed that the directory is in fact a Git repository, so I was good to make changes and push them to GitHub.

![alt text](<images/Screenshot 2026-07-07 145235.png>)

- I updated the remote, changing it from HTTPS (requiring a Personal Access Token, PAT)) to SSH (requiring an SSH key which I had already set up). 

![alt text](<images/Screenshot 2026-07-07 171838.png>)

![alt text](<images/Screenshot 2026-07-07 204855.png>)


## 3) Make a change and push.

- I created a dedicated feature branch (```git checkout -b pr-practice```), where I created new changes.

![alt text](<images/Screenshot 2026-07-07 200743.png>)

- I couldn’t push my new branch because it didn’t have an upstream branch yet. Git required me to specify the remote branch using ```git push origin pr-practice```.

![alt text](<images/Screenshot 2026-07-07 200756.png>)

## 4) Create a pull request; review and merge.

- I had to change the base repo since it was the original repo I forked from.
- I changed the compare branch to ```pr-practice``` and the base branch to ```master``` 
- After I merged, the GitHub UI let me delete the compare branch (seen in the image below) which I did.

![alt text](<images/Screenshot 2026-07-07 201941.png>)

## Lessons learned:

1) I cannot push to the original repo so I must clone my fork (since I can't make changes to the original repo)

2) Cloning inside an existing repo does NOT create a fresh repository.  
  It simply adds a new folder inside the current project, which still belongs to the outer Git repo.  
  To get a clean, separate repo, I must clone **outside** my devops-learning directory.

3) To merge within the same repo, I needed to create a new branch and then push that new branch using ```git push origin <new-branch-name>```. 

Terms used in this file:

- origin : remote repo on github
- base : branch that receives the pull request changes
- compare : branch which you pull from