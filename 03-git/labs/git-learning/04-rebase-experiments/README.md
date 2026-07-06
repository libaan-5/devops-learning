# 03-rebase-experiments

Goal: Clean up messy commit history.

Steps:

## 1) Make 3–4 small commits with trivial changes.

- I made trivial changes by adding a new line to the same file and then committing each change.

![alt text](<images/Screenshot 2026-07-06 202125.png>)

## 2) Run git rebase -i HEAD~3

- Based on the last 3 commits that need to be squashed together.
- The command was HEAD~3 but would be bigger/shorter depending on how many need to be squashed.
- This command opened a replay buffer which allowed me to modify the commits and squash them.

## 3) Squash and reorder commits.

- I changed the last 2 commit commands from pick to squash to make it 1 larger commit.
![alt text](<images/Screenshot 2026-07-06 205315.png>)

---

- I added the commit title at the top of the squash commit message buffer.

![alt text](<images/Screenshot 2026-07-06 205330.png>)

---

I ran ```git log --oneline``` to compare the commit history before and after:
- Before to show the original git commit log
- After to confirm that the 3 commits were squashed successfully. 

**COMMIT HISTORY BEFORE**:

![alt text](<images/Screenshot 2026-07-06 210724.png>)

**COMMIT HISTORY AFTER**:

![alt text](<images/Screenshot 2026-07-06 210602.png>)

## Lessons learned:

![alt text](<images/Screenshot 2026-07-06 214331.png>)

1) Mistakes during rebase are normal — and fixable
- I made a mistake so I ran ```git reflog``` for the first time which helped me save my work. 
- I accidentally deleted the 3 trivial commits and the squash so I found an older clean commit and ran ```git reset --hard HEAD@{18}```. 
