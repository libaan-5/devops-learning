# 03-stash-practice

Goal: Simulate interruptions and context switching.
Steps:

## 1) Create a file.

![alt text](image.png)

## 2) Edit a file.

## 3) Create a new branch and then git stash

- ```git checkout -b stash-test``` creates a new branch and switches to it automatically. 

![alt text](<Screenshot 2026-07-04 204333.png>)

- The ```--include-untracked``` option includes untracked items when stashing.  

![alt text](image.png)

## 4) Check the stashed changes: git stash list

- ```git stash list``` shows all of the stashed changes, with the latest commited change.
- ```git stash list``` works on any branch, making it a global command. This allows for safe context switching/interruptions, making it a useful feature. 

![alt text](<Screenshot 2026-07-04 205017.png>)

## 5) Switch branches, make another commit.

## 6) Return and restore: git stash pop
Proof: Screenshot of stash list before and after.


Notes learned:

- git stash isn't required if a file doesn't exist across both branches. However it's required if a file is edited (and is different) across multiple branches. 