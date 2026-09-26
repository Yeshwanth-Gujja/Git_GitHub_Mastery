# Git Cheat Sheet

> Condensed command reference from the master notes. Use the full [command playbook](../notes/04-command-playbook.md) for detailed explanations.


## Setup & Config

```bash
# verify Git
git --version

#🎥 identity
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

 🎥 default branch
git config --global init.defaultBranch main

# inspect configuration
git config --global --list

```

## Starting a Repository

```bash
# initialize local repo
git init

#🎥 clone existing repo
git clone <url>

```

## Daily Workflow

```bash
# inspect
git status

#🎥 stage one file
git add file.txt

 🎥 stage everything in current path
git add .
# 🎥 inspect unstaged changes
git diff

# inspect staged changes
git diff --staged
# 🎥 commit
git commit -m "Add feature

# 🎥 history
git log

# compact history
git log --oneline --graph --decorate --all

```

## Branching & Switching

```bash
# list branches
git branch

#🎥 create branch
git branch feature-login

 🎥 switch branch
git checkout feature-login

# modern switch
git switch feature-login
# 🎥 create + switch
git checkout -b feature-login

# modern create + switch
git switch -c feature-login

# delete merged branch
git branch -d feature-login

```

## Remote & Collaboration

```bash
# inspect remotes
git remote -v

#🎥 add remote
git remote add origin <url>

 🎥 first push
git push -u origin main
# 🎥 first feature push
git push -u origin feature-login
# 🎥 later push
git pus

# 🎥 pull
git pull

# fetch only
git fetch origin

# remove stale remote-tracking branches
git fetch --prune

```

## Branch Integration

```bash
# merge
git merge main

# rebase
git rebase main

# continue rebase
git rebase --continue

# abort rebase
git rebase --abort

# abort merge
git merge --abort

```

## Undoing & Fixing

```bash
# discard working-tree file changes
git restore file.txt

# unstage
git restore --staged file.txt

# mixed reset
git reset HEAD~1

#🎥 soft reset
git reset --soft HEAD~1

 🎥 hard reset
git reset --hard HEAD~1
# 🎥 create inverse commit
git revert <commit>

# recover moved/deleted refs
git reflog

```

## Stash & Temporary Work

```bash
# stash
git stash

#🎥 list
git stash list

 🎥 apply
git stash apply stash@{0}

# apply + remove
git stash pop

# include untracked
git stash -u

```

## Inspecting & Debugging

```bash
# commit details
git show <commit>

# compare branches
git diff main..feature-login

# history
git log

# binary-search a regression
git bisect start
git bisect good <commit>
git bisect bad
git bisect reset

```

## Specialized Operations

```bash
# cherry-pick a commit
git cherry-pick <commit>

# release tag
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0

# worktree
git worktree add ../hotfix hotfix-production

# submodule
git submodule add <url> libs/example

# preview clean
git clean -n

```

---
