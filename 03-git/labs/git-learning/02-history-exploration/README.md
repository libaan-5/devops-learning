# 02-history-exploration

Goal: Understand commit history and visualization.

Steps:

## 1) Run git log --oneline --graph --all
- Since I was used to running ```git log --oneline```, this was surprising to learn about. 
- This command is definitely a lot better than the former to see the commit history as a graph formatqg. 
![alt text](<Screenshot 2026-07-03 162501.png>)

## 2) Inspect a commit: git show <commit-hash>

- Running ```git show``` with no specified commit hash shows the head. 

![alt text](<Screenshot 2026-07-03 163344.png>)

---

- However, after running ```git log --oneline``` to find a commit hash to specify ```git show b75e280```, I was able to show the specified commits changes.

![alt text](<Screenshot 2026-07-03 163718.png>)


## 3) Reflection on options

```--oneline```

- This option used in ```git log```, shows the git history in a clean readable format. 
- It only showing the commit hashes and the commit messages. 

---

```--graph```

- This shows the commits in a graph format (ASCII graph).
- It shows the branches that were created and how they merge.

----

```--all```

- This option specifies all branches to show the project history.
- If this option is not specified, ```git log``` will only run on the current branch. 

---

```git show <commit>```

- Displays the commit’s metadata (author, date, message) and the diff of what changed in that commit.
- Defaults to showing HEAD when no commit is specified.