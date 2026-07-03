# 01-branch-mastery

Goal: Learn branching, merging, and conflict resolution.

Steps:

## 1) Create a new branch 'branch-mastery':

![alt text](<Screenshot 2026-07-01 121427.png>)

## 2) Navigate to the 'git practice' directory:

![alt text](<Screenshot 2026-07-01 121812.png>)

## 3) In the newly created branch, make local unstaged changes.
- I added images in the created branch which I meant to have in the main branch.

![alt text](<Screenshot 2026-07-01 125342.png>)

## 4) In the newly created branch, stage and commit the changes. 

- I didn't capture an image of myself committing the changes but ```git log --oneline``` shows the latest commit on the new branch.  

![alt text](<Screenshot 2026-07-01 163039.png>)

## 5) Merge the feature branch onto main branch. 

- There were some untracked/modified files I needed to handle before I could merge.

![alt text](<Screenshot 2026-07-01 163946 2.png>)

---

- I first staged both files, confirming with ```git status```.

![alt text](<Screenshot 2026-07-01 163946 3.png>)

- Next, I added more images/changes and then used ```git commit --amend``` to add the changes to the previous commit.
- I did this to keep the commit history clean.

![alt text](<Screenshot 2026-07-01 163946 4.png>)

---

- I switched back to main using ```git checkout main``` and then decided to merge.
- Merging was not possible initially because there was a merge conflict, created by accidentally updating this file on both branches. 
- I accepted the current changes on the main branch and the merge conflict was handled smoothly. After resolving the conflict, Git allowed the merge to complete, producing a merge commit on GitHub. 

![alt text](<Screenshot 2026-07-03 102250.png>)

## 6) Delete the feature branch

- I deleted the feature branch after I finished merging to follow trunk-based-development.

![alt text](<Screenshot 2026-07-03 114140.png>)



