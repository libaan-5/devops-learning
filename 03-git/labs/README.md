# Labs

Document your completed labs here.

## Template

When documenting a lab, include:

```markdown
# Lab: [Lab Name]

## Objective

What was the goal?

## Commands Used

(the commands you ran)

## Output

(what happened)

## Challenges

Any issues you hit and how you solved them.

## What I Learned

Key takeaways from this lab.
```

## Completed Labs

- [ ] Add your first lab





---

1️⃣ Branch Mastery
Goal: Learn branching, merging, and conflict resolution.
Steps:

Create a new branch: git checkout -b feature-branch

Edit a file and commit.

Switch back to main and make a conflicting change.

Merge: git merge feature-branch

Resolve the conflict manually, commit the merge.
Proof: Screenshot of resolved conflict + git log --graph output.

2️⃣ History Exploration
Goal: Understand commit history and visualization.
Steps:

Run git log --oneline --graph --all

Inspect a commit: git show <commit-hash>

Write a short reflection on what each flag does.
Proof: Markdown snippet showing command output and notes.

3️⃣ Stash Practice
Goal: Simulate interruptions and context switching.
Steps:

Start editing a file.

Run git stash

Switch branches, make another commit.

Return and restore: git stash pop
Proof: Screenshot of stash list before and after.

4️⃣ Rebase Experiments
Goal: Clean up messy commit history.
Steps:

Make 3–4 small commits with trivial changes.

Run git rebase -i HEAD~4

Squash and reorder commits.
Proof: Before/after git log --oneline comparison.

5️⃣ Collaboration Simulation
Goal: Practice open‑source workflow.
Steps:

Fork a repo on GitHub.

Clone your fork locally.

Make a change and push.

Create a pull request.

Review and merge.
Proof: Screenshot of merged PR.

6️⃣ Error Recovery
Goal: Learn to undo safely.
Steps:

Make a bad commit.

Try git restore, git reset, and git revert — note differences.
Proof: Markdown table comparing each command’s effect.

7️⃣ Gitignore Setup
Goal: Protect sensitive files.
Steps:

Create .gitignore with entries like *.env, node_modules/, __pycache__/.

Test by adding ignored files and running git status.
Proof: Screenshot showing ignored files not tracked.

8️⃣ Pre‑Commit Automation
Goal: Automate code checks.
Steps:

Install pre-commit: pip install pre-commit

Create .pre-commit-config.yaml with linting hooks.

Run pre-commit install

Test by committing a file that violates lint rules.
Proof: Screenshot of hook output blocking commit.

9️⃣ Real‑World Practice
Goal: Apply Git in real challenges.
Steps:

Complete OverTheWire Bandit Git levels or contribute to a small open‑source repo.

Document what you learned.
Proof: Markdown reflection + link to contribution or challenge completion.