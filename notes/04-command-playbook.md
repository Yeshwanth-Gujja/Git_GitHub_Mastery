# 4. Command Playbook — Detailed Reference

This section is the detailed command reference, organized around the Git state each command reads or changes.

This section is the practical command reference. The goal is not to memorize flags mechanically. For each command, understand the state Git reads, the state it changes, and the situations in which the command is appropriate.

A useful rule before running an unfamiliar command:

```text
1. Check the current state → git status
2. Inspect the change/history if necessary
3. Decide which Git state you want
4. Use the command that moves you there
5. Check git status again
```

## 4.1 `git init`

`git init` creates a new Git repository in a directory. It creates Git's administrative data, normally inside `.git/`, while leaving your existing project files where they are.

```bash
git init
git init <directory>
git init --initial-branch=main
git init -b main
```

### Common forms

```bash
git init
```
Initializes the current directory.

```bash
git init my-project
```
Creates the directory if necessary and initializes a repository there.

```bash
git init -b main
```
Initializes the repository with `main` as the initial branch.

```bash
git init --bare
```
Creates a **bare repository**. A bare repository has no normal working tree and is commonly used as a server-side repository or central remote.

### What changes internally

Before `git init`, the directory is just an ordinary directory.

After `git init`, Git creates repository metadata such as:

```text
project/
├── your files
└── .git/
```

The `.git` directory contains the repository's object database, references, index, configuration, `HEAD`, logs, and other internal state.

### Important edge cases

- Running `git init` inside an existing repository generally reinitializes the existing repository rather than creating a second independent repository.
- If you initialize a repository in a directory that is already inside another repository, Git normally operates with the nearest repository unless a nested repository is deliberately created.
- `git init --bare` is different from normal initialization because there is no working tree for ordinary file editing.

---

## 4.2 `git clone`

`git clone` creates a new local repository from an existing repository. It normally downloads repository objects, creates a working tree, configures `origin`, and checks out the repository's default branch.

```bash
git clone <url>
git clone <url> <directory>
```

### Important variations

```bash
git clone --branch <branch> <url>
git clone -b <branch> <url>
```
Clone and check out a particular branch.

```bash
git clone --single-branch --branch develop <url>
```
Clone only the requested branch instead of fetching the normal set of branch refs.

```bash
git clone --depth 1 <url>
```
Create a shallow clone containing limited history. Useful for CI or situations where complete history is unnecessary.

```bash
git clone --depth 10 <url>
```
Keep a specified amount of recent history.

```bash
git clone --no-checkout <url>
```
Clone the repository without initially checking out files into the working tree.

```bash
git clone --bare <url>
```
Create a bare clone, normally used for repository hosting or server-side operations.

```bash
git clone --mirror <url>
```
Create a mirror containing all refs. This is mainly used for repository mirroring/backup rather than normal development.

```bash
git clone --recurse-submodules <url>
```
Clone the repository and initialize its submodules recursively.

### What happens after cloning

A normal clone gives you approximately:

```text
Remote repository
    ↓ clone
Local repository + working tree
    ↓
origin → remote repository URL
```

The remote-tracking branch `origin/main` represents the last fetched state of the remote's `main` branch. Your local `main` is a separate local branch.

### Common mistakes

- `git clone` is normally used when the repository already exists remotely. `git init` is normally used when starting a new local repository.
- `--depth 1` is not a full-history clone; some history-dependent operations may be limited until more history is fetched.
- A cloned repository does not mean every future remote update automatically appears locally. You still need `fetch`, `pull`, or another integration workflow.

---

## 4.3 `git status`

`git status` reports the current repository state. It is one of the safest and most useful commands in Git because it tells you what Git believes is happening before you perform another operation.

```bash
git status
git status --short
git status --branch
git status --short --branch
git status --porcelain
git status --porcelain=v1
git status --porcelain=v2
```

### What `git status` tells you

Depending on the situation, it can show:

- current branch
- whether the branch is ahead of or behind its upstream
- modified tracked files
- staged changes
- untracked files
- merge conflicts
- files that have been renamed/deleted
- information about an ongoing merge, rebase, cherry-pick, or other operation

### Working-tree vs staged changes

```text
Changes not staged for commit
```
means the working tree differs from the index.

```text
Changes to be committed
```
means the index differs from the current `HEAD` commit.

```text
Untracked files
```
means Git sees files that are not currently tracked by the repository.

### Short format

```bash
git status --short
```

The compact format is useful when checking status frequently or writing scripts. The two-column status codes distinguish index state from working-tree state.

Example:

```text
 M app.py
M README.md
?? notes.txt
```

Conceptually:

```text
 M → working-tree modification
M → staged modification
?? → untracked
```

### Important habit

If you are unsure what Git is about to do, run:

```bash
git status
git diff
git diff --staged
```

---

## 4.4 `git add`

`git add` updates the **index/staging area** with the content currently present in the working tree. It does not create a commit.

The important mental model is:

```text
Working Tree
   ↓ git add
Index
   ↓ git commit
Commit
```

### Common forms

```bash
git add <file>
git add <directory>
git add .
git add -A
git add --all
git add -u
git add --update
git add -p
git add --patch
```

### `git add <file>`

Stages one specific path.

```bash
git add app.py
```

Useful when you want a focused commit.

### `git add .`

Stages changes under the current directory according to Git's pathspec behavior.

```bash
git add .
```

Do not blindly treat this as identical to every form of `git add -A`; the path from which the command is run matters.

### `git add -A`

Stages additions, modifications, and deletions across the repository.

```bash
git add -A
```

This is useful when you intentionally want the index to represent all current changes.

### `git add -u`

Stages modifications and deletions of already tracked files, but does not stage new untracked files.

```bash
git add -u
```

### Interactive staging

```bash
git add -p
```

Lets you review individual hunks and choose which parts should enter the next commit.

This is extremely useful when one file contains multiple logical changes and you want clean commits.

### Intent-to-add

```bash
git add -N <file>
```

Records that an untracked file should be considered by certain diff/status operations without immediately staging its complete contents.

### Important edge case: file changes after staging

Suppose:

```text
1. edit app.py
2. git add app.py
3. edit app.py again
```

The first version is staged, while the second edit is only in the working tree.

Therefore:

```bash
git diff
```
shows the second edit, while:

```bash
git diff --staged
```
shows the version that is currently staged.

A commit records the staged version, not every current working-tree change.

---

## 4.5 `git commit`

`git commit` creates a new commit from the content currently represented by the index.

A commit records a project state plus metadata such as:

- author
- committer
- timestamps
- commit message
- parent commit(s)
- tree representing the tracked file state

### Basic forms

```bash
git commit
git commit -m "Add login validation"
git commit -a -m "Fix validation"
git commit -am "Fix validation"
```

### `-m`

Supply the commit message directly.

```bash
git commit -m "Add login validation"
```

### `-a` / `-am`

Automatically stage modifications and deletions to already tracked files before committing.

```bash
git commit -am "Fix login validation"
```

It **does not stage new untracked files**.

If `new.py` is untracked, this will not include it:

```bash
git commit -am "Add new functionality"
```

You must first use:

```bash
git add new.py
git commit -m "Add new functionality"
```

### Amend the latest commit

```bash
git commit --amend
```

Replace the latest commit with a new commit using the current index and optionally a new message.

```bash
git commit --amend -m "Correct commit message"
```

Keep the previous message:

```bash
git commit --amend --no-edit
```

Typical use:

```bash
git add forgotten-file.py
git commit --amend --no-edit
```

This changes the latest commit rather than creating another commit.

### Empty commit

```bash
git commit --allow-empty -m "Trigger CI"
```

Creates a commit even when there are no file changes. Useful in specific automation/workflow situations.

### Sign a commit

```bash
git commit -S -m "Add release fix"
git commit --gpg-sign -m "Add release fix"
```

Used when commit signing is configured.

### Fixup commit

```bash
git commit --fixup=<commit>
```

Creates a commit intended to be automatically folded into another commit during an interactive rebase with autosquash.

### What gets committed?

Only the **index** is committed.

```text
Working Tree   → current edits
Index       → selected snapshot
HEAD       → previous commit

 git commit
   ↓
new commit created from Index
```

This is why staging exists: it lets you construct the exact next commit.

---

## 4.6 Commit message style

A good commit message describes the change represented by the commit.

Prefer:

```text
Add login validation
Fix null pointer in payment service
Update API documentation
Remove deprecated endpoint
```

Avoid vague messages:

```text
update
changes
stuff
fix
work
final
```

The imperative style is common because the message can be read as:

```text
If applied, this commit will: Add login validation.
```

Keep commits logically focused. A single commit containing unrelated database changes, UI changes, documentation changes, and dependency upgrades is harder to review and revert.

---

## 4.7 `git log`

`git log` displays commit history. It is one of the primary commands for understanding how the current repository reached its present state.

### Basic forms

```bash
git log
git log --oneline
git log --graph
git log --decorate
git log --all
git log --stat
git log -p
```

### Useful combinations

```bash
git log --oneline --decorate
git log --graph --oneline --decorate --all
git log --stat
git log -p
```

### Limit commits

```bash
git log -n 5
git log --max-count=5
git log --since="1 week ago"
git log --until="2026-09-26"
```

### Filter by author

```bash
git log --author="Yeshwanth"
```

### Search commit messages

```bash
git log --grep="login"
```

### Follow one file

```bash
git log -- path/to/file.py
git log --follow -- path/to/file.py
```

`--follow` can continue history across a file rename in common cases.

### Show branches visually

```bash
git log --graph --oneline --decorate --all
```

This is one of the most useful history commands when learning branches and merges.

### Search by content changes

```bash
git log -S"someFunction"
git log -G"regex-pattern"
```

`-S` searches for changes in the number of occurrences of a string; `-G` searches changed lines using a regular expression.

### Exit the pager

Press:

```text
q
```

---

## 4.8 `git show`

`git show` displays an object, most commonly a commit, and by default shows its metadata and patch.

```bash
git show
 git show HEAD
git show HEAD~1
git show <commit>
```

### Useful variations

```bash
git show --stat <commit>
git show --name-only <commit>
git show --name-status <commit>
git show --format=fuller <commit>
git show --summary <commit>
```

Show a particular file from a commit:

```bash
git show <commit>:path/to/file.py
```

This reads the file as it existed in that commit.

### Why use `git show`?

Use it when `git log` tells you **which commit** you care about and you now want to know **exactly what that commit contained**.

---

## 4.9 `git diff`

`git diff` compares Git states and shows line-level changes.

The most important distinction is what is being compared.

```bash
git diff
```
Working tree vs index.

```bash
git diff --staged
```
Index vs `HEAD`.

```bash
git diff HEAD
```
Working tree + index vs `HEAD`.

### Compare commits

```bash
git diff <commit1> <commit2>
```

### Compare branches

```bash
git diff main..feature
```

This asks for the difference between the two named tips.

For commit-range semantics where you care about changes reachable from one side but not another, understand the difference between two-dot and three-dot notation:

```bash
git diff main..feature
git diff main...feature
```

`main...feature` compares the merge-base of the two branches to `feature`, which is often useful for reviewing what a feature branch introduces relative to its common base.

### File-specific diff

```bash
git diff -- app.py
git diff --staged -- app.py
```

The `--` separates revisions/options from paths.

### Useful options

```bash
git diff --stat
git diff --name-only
git diff --name-status
git diff --word-diff
git diff --color-moved
```

### Practical pre-commit check

```bash
git diff
git diff --staged
git status
```

The first checks what is still unstaged; the second checks exactly what the next commit will contain.

---

## 4.10 `git branch`

A branch is a movable reference to a commit. `git branch` manages local branch references; it does not itself switch the working tree to another branch.

### List branches

```bash
git branch
git branch -a
git branch -r
git branch -vv
```

- `-a` → local + remote-tracking branches
- `-r` → remote-tracking branches
- `-vv` → verbose branch/tracking information

### Create a branch

```bash
git branch feature-login
git branch feature-login main
```

The second form creates `feature-login` starting at `main`'s current commit.

### Rename

```bash
git branch -m new-name
git branch -M new-name
```

`-M` forces the rename if necessary.

Rename another local branch:

```bash
git branch -m old-name new-name
```

### Delete

```bash
git branch -d feature-login
git branch -D feature-login
```

`-d` performs a safety check and normally refuses to delete an unmerged branch.

`-D` force-deletes the local branch reference.

### Delete a remote-tracking branch

```bash
git branch -dr origin/feature-login
```

For removing a branch from the actual remote, use `git push`:

```bash
git push origin --delete feature-login
```

### Copy a branch

```bash
git branch -c old-name new-name
git branch -C old-name new-name
```

`-C` is the force form.

### Create a branch at a specific point

```bash
git branch feature-login <commit>
git branch feature-login origin/main
```

Remember: creating a branch does not switch to it.

---

## 4.11 `git checkout`

`git checkout` is an older, overloaded command that can switch branches, create branches, enter detached HEAD state, and restore file content.

Modern Git commonly uses `git switch` for branch movement and `git restore` for file restoration because the responsibilities are clearer.

### Branch switching

```bash
git checkout main
git checkout feature-login
```

### Create and switch

```bash
git checkout -b feature-login
git checkout -b feature-login main
```

### Detached HEAD

```bash
git checkout <commit>
git checkout --detach <commit>
```

### Restore a file using checkout

```bash
git checkout -- app.py
git checkout <commit> -- app.py
```

The first restores the file from the current `HEAD` version; the second obtains the file content from another commit.

### Force switching

```bash
git checkout -f main
```

This can discard conflicting local working-tree changes. Use only when you understand what will be lost.

### Important distinction

```text
checkout branch    → switch branch
checkout commit    → detached HEAD
checkout -- file    → restore file
```

This overload is the reason `switch` and `restore` were introduced.

---

## 4.12 `git switch`

`git switch` is focused on changing branches and entering detached HEAD state.

```bash
git switch main
git switch feature-login
git switch -c feature-login
git switch -c feature-login main
```

### Create from another starting point

```bash
git switch -c feature-login origin/main
```

### Detached HEAD

```bash
git switch --detach <commit>
git switch --detach origin/main
```

### Create from a remote-tracking branch

```bash
git switch -c feature-login --track origin/feature-login
```

Often Git can infer the tracking relationship automatically when the names make the relationship obvious.

### Force switching

```bash
git switch --discard-changes main
```

This discards local changes that prevent switching. Treat it as destructive.

### Main distinction

```text
git switch → branches / HEAD movement
git restore → file content / staging state
```

---

## 4.13 `git restore`

`git restore` is designed specifically for restoring file content and staging state.

### Discard working-tree changes

```bash
git restore app.py
```

This restores the file from the index, discarding unstaged modifications.

### Unstage a file

```bash
git restore --staged app.py
```

This changes the index but leaves the working-tree content alone.

### Restore and unstage

```bash
git restore --staged --worktree app.py
git restore -SW app.py
```

### Restore from a commit

```bash
git restore --source=<commit> app.py
```

Restore a file's content from another commit into the working tree.

Restore and stage it:

```bash
git restore --source=<commit> --staged --worktree app.py
```

### Important mental model

```text
git restore file
  → change working tree

git restore --staged file
  → change index
```

It does not move the branch pointer like `git reset`.

---

## 4.14 `git remote`

A remote is a named reference to another Git repository.

### List remotes

```bash
git remote
git remote -v
```

### Add a remote

```bash
git remote add origin <url>
```

### Rename a remote

```bash
git remote rename origin upstream
```

### Remove a remote

```bash
git remote remove origin
git remote rm origin
```

### Change URL

```bash
git remote set-url origin <new-url>
```

View configured URLs:

```bash
git remote get-url origin
git remote get-url --all origin
```

### Inspect remote branches and configuration

```bash
git remote show origin
git remote -v
```

Remember:

```text
origin → local name for a remote repository
origin/main → local remote-tracking reference
main → local branch
```

They are related but are not the same reference.

---

## 4.15 `git push`

`git push` transfers local commits and refs to a remote repository.

### Basic forms

```bash
git push
git push origin main
git push origin feature-login
```

### Set upstream

```bash
git push -u origin feature-login
git push --set-upstream origin feature-login
```

After tracking is established, later commands can often be:

```bash
git push
git pull
```

### Push all local branches

```bash
git push --all origin
```

### Push tags

```bash
git push origin v1.0.0
git push origin --tags
```

### Delete a remote branch

```bash
git push origin --delete feature-login
```

### Force push

```bash
git push --force
```

This can overwrite remote history. It is dangerous on shared branches.

Prefer:

```bash
git push --force-with-lease
```

`--force-with-lease` adds a safety check so you are less likely to overwrite remote work that you have not seen.

### Other useful variations

```bash
git push --dry-run
git push --porcelain
git push --follow-tags
git push --prune
```

- `--dry-run` → show what would be pushed without actually pushing.
- `--follow-tags` → push annotated tags reachable from the commits being pushed.
- `--prune` → remove remote branches that no longer have corresponding local refs in the relevant push mapping.

### Critical rule

`git push` does not normally merge remote changes into your branch. It publishes your local refs to the remote.

---

## 4.16 `git fetch`

`git fetch` downloads objects and updates remote-tracking references without integrating those changes into your current local branch.

```bash
git fetch
git fetch origin
git fetch origin main
```

### Fetch all remotes

```bash
git fetch --all
```

### Remove stale remote-tracking references

```bash
git fetch --prune
git remote prune origin
```

### Fetch tags

Modern fetch behavior may obtain relevant tags automatically, but explicit tag fetching is possible:

```bash
git fetch origin --tags
```

### Fetch without changing your current files

This is the central distinction:

```text
remote repository
   ↓ git fetch
local objects + origin/* refs
   ↓
current local branch is not automatically merged/rebased
```

After fetching, inspect:

```bash
git log main..origin/main --oneline
git diff main..origin/main
```

Then choose merge, rebase, reset, or another integration strategy.

---

## 4.17 `git pull`

`git pull` is a convenience operation that first fetches remote changes and then integrates them into the current branch.

Conceptually:

```text
git pull
≈ git fetch
+ integration
```

The integration can be a merge or a rebase depending on options/configuration.

### Basic forms

```bash
git pull
git pull origin main
```

### Rebase instead of merge

```bash
git pull --rebase
git pull --rebase origin main
```

### Fast-forward only

```bash
git pull --ff-only
```

This refuses to create a merge commit when a fast-forward is not possible.

### No rebase / explicit merge behavior

```bash
git pull --no-rebase
```

### Prune during pull

```bash
git pull --prune
```

### Important configuration

```bash
git config --global pull.rebase true
git config --global pull.ff only
```

Do not configure these blindly on a team; understand the team's expected history policy first.

### Why `fetch` can be safer for learning

`fetch` separates downloading from integration:

```bash
git fetch origin
git log main..origin/main --oneline
git diff main..origin/main
git merge origin/main
```

You can inspect before changing your branch.

---

## 4.18 `git merge`

`git merge` integrates another branch into the **current branch**.

This sentence is critical:

```bash
git switch feature-login
git merge main
```

means:

```text
Merge main INTO feature-login.
```

It does not mean merge the feature into `main`.

### Basic forms

```bash
git merge main
git merge feature-login
```

### Fast-forward merge

If the current branch is an ancestor of the branch being merged, Git can simply move the current branch reference forward.

```text
A---B---C main
     \
     D---E feature
```

If `main` has not diverged, merging can simply move `main` to `E`.

### Force a merge commit

```bash
git merge --no-ff feature-login
```

Even when a fast-forward is possible, create a merge commit.

### Require fast-forward

```bash
git merge --ff-only feature-login
```

Fail instead of creating a merge commit when fast-forward is impossible.

### Squash merge

```bash
git merge --squash feature-login
git commit -m "Add login feature"
```

Creates the working-tree/index result of the merge without creating a normal merge commit automatically. You then commit the combined changes yourself.

### Abort

```bash
git merge --abort
```

Attempts to return to the pre-merge state when a merge is in progress.

### Continue after conflict

After resolving files:

```bash
git add <resolved-files>
git commit
```

Some workflows can use:

```bash
git merge --continue
```

when supported by the current Git operation state.

### Conflict markers

A conflicted text file can contain markers such as:

```text
<<<<<<< HEAD
current branch content
=======
other branch content
>>>>>>> main
```

You must edit the file into the desired final state, remove the markers, stage the resolution, and complete the merge.

---

## 4.19 `git rebase`

`git rebase` moves or replays commits onto a new base. Unlike merge, it creates new commit identities for the replayed commits.

Typical workflow:

```bash
git switch feature-login
git rebase main
```

Conceptually:

```text
Before:
A---B---C main
   \
   D---E feature

After:
A---B---C---D'---E' feature
```

### Continue / abort / skip

```bash
git rebase --continue
git rebase --abort
git rebase --skip
```

### Interactive rebase

```bash
git rebase -i HEAD~3
```

Useful for cleaning recent local history.

Common interactive actions:

```text
pick  keep commit
reword change message
edit  stop and modify commit
squash combine with previous commit
fixup  combine while discarding this commit's message
drop  remove commit
```

### Autosquash

```bash
git rebase -i --autosquash HEAD~5
```

Works with commits created using `--fixup` or `--squash` conventions.

### Rebase onto another base

```bash
git rebase --onto main old-base feature-login
```

This is an advanced history-rewriting operation. Understand exactly which commits are being selected before using it.

### Rebase a branch onto its upstream

```bash
git rebase origin/main
```

### Important warning

Rebase rewrites commit history. Avoid rebasing commits that other developers have already based their own work on unless the team explicitly expects that workflow.

If a rebased branch has already been pushed and policy permits rewriting it:

```bash
git push --force-with-lease
```

### Rebase vs merge

Neither is universally "better".

```text
merge → preserves existing branch topology
rebase → rewrites/replays commits onto a new base
```

---

## 4.20 `git reset`

`git reset` moves the current branch reference and can also change the index and working tree depending on its mode.

This command is easiest to understand by separating three states:

```text
HEAD / current commit
Index / staging area
Working tree
```

### Soft reset

```bash
git reset --soft <commit>
```

Moves the current branch to `<commit>` while leaving the index and working tree containing the changes represented by the commits that were removed from the branch tip.

Useful for reconstructing recent commits.

Example:

```bash
git reset --soft HEAD~2
```

The last two commits disappear from the current branch's visible tip, but their combined changes remain staged.

### Mixed reset

```bash
git reset --mixed <commit>
git reset <commit>
```

Mixed is the default mode.

It moves the branch and resets the index to the target commit while leaving working-tree changes intact.

```text
branch → target commit
index → target commit
working tree → retains changes
```

### Hard reset

```bash
git reset --hard <commit>
```

Moves the branch, resets the index, and makes the working tree match the target commit.

This can destroy uncommitted changes.

### Keep working-tree changes when possible

```bash
git reset --keep <commit>
```

Useful in some situations where you want to move `HEAD` while preserving local changes that do not conflict with the reset.

### Merge reset

```bash
git reset --merge <commit>
```

An advanced mode that attempts to preserve local changes while resetting index/working-tree state appropriately around merge situations.

### Path reset / unstage

```bash
git reset HEAD -- app.py
```

This is the older syntax for unstaging a file. Modern Git commonly uses:

```bash
git restore --staged app.py
```

### `HEAD~` and `HEAD^`

```bash
git reset --hard HEAD~1
git reset --hard HEAD~2
git reset --hard HEAD^
```

`HEAD~1` means the first-parent predecessor in the normal linear-history sense. `HEAD^` refers to a parent; parent notation becomes especially important for merge commits.

### Critical distinction

`reset` changes the branch reference and potentially index/worktree state. It is primarily a **history/state manipulation tool**, not simply a generic "undo" command.

---

## 4.21 `git revert`

`git revert` creates a **new commit** that reverses the changes introduced by an earlier commit.

```bash
git revert <commit>
```

Example:

```text
A---B---C
    \
     revert C

A---B---C---D
      D reverses C
```

The original commit `C` remains in history.

### Useful variations

```bash
git revert --no-edit <commit>
git revert --edit <commit>
git revert --no-commit <commit>
```

`--no-commit` applies the inverse changes to the index/working tree without immediately creating the revert commit. This can be useful when combining multiple reversions into one commit.

### Revert a range

```bash
git revert <oldest>..<newest>
```

Understand the range carefully before using it because revision-range syntax describes a set of commits rather than simply "these two commits".

### Revert a merge commit

A merge commit has multiple parents. Git needs to know which parent represents the mainline:

```bash
git revert -m 1 <merge-commit>
```

`-m` selects the mainline parent. This is an important advanced case.

### Abort / continue

```bash
git revert --continue
git revert --abort
```

### Reset vs revert

```text
reset → move branch/history pointer
revert → create a new commit that reverses an earlier commit
```

For already-published/shared history, revert is generally the safer conceptual tool because it does not rewrite the existing branch history.

---

## 4.22 `git stash`

`git stash` temporarily stores local modifications so the working tree can be made clean without committing unfinished work.

### Basic

```bash
git stash
git stash push
git stash push -m "WIP login form"
```

### Include untracked files

```bash
git stash -u
git stash push --include-untracked
```

### Include ignored files too

```bash
git stash -a
git stash push --all
```

Use this carefully because ignored/generated files can be large.

### Stash selected paths

```bash
git stash push -- app.py styles.css
```

### Keep staged changes staged

```bash
git stash push --keep-index
```

### Include only staged changes

```bash
git stash push --staged
```

### Interactive stash

```bash
git stash push -p
```

Select individual hunks to stash.

### Stash message

```bash
git stash push -m "WIP payment validation"
```

### Important mental model

A stash is not simply "magic temporary RAM". Git records stash state using Git objects/references so the work can be restored later.

### Important edge case

By default, untracked files are not included. Use `-u` when they must be preserved.

---

## 4.23 `git stash list`

Lists saved stashes.

```bash
git stash list
git stash list --date=local
git stash list --stat
```

Typical output:

```text
stash@{0}: On feature-login: WIP login form
stash@{1}: On main: temporary debugging
```

The newest stash is normally `stash@{0}`.

---

## 4.24 `git stash apply`

Applies a stash without deleting the stash entry.

```bash
git stash apply
git stash apply stash@{0}
```

You can then inspect the result and keep the stash as a backup until you know the restoration succeeded.

If conflicts occur, resolve them like other merge-style conflicts.

---

## 4.25 `git stash pop`

Applies a stash and removes the stash entry if the operation succeeds.

```bash
git stash pop
git stash pop stash@{0}
```

Use `apply` when you want to keep the stash around as a safety copy; use `pop` when you want the normal restore-and-remove workflow.

Other useful operations:

```bash
git stash drop stash@{0}
git stash clear
```

`git stash clear` removes all stash entries. Treat it as destructive.

---

## 4.26 `git reflog`

The reflog records local movements of references such as `HEAD` and branch tips. It is one of Git's most important recovery mechanisms.

```bash
git reflog
git reflog show
git reflog show main
```

Example:

```text
HEAD@{0} → current position
HEAD@{1} → previous position
HEAD@{2} → position before that
```

### Recovery example

Suppose you accidentally run:

```bash
git reset --hard HEAD~3
```

and realize that the old commits are needed.

First inspect:

```bash
git reflog
```

Find the previous commit, then recover with a branch or reset:

```bash
git branch recovery <old-commit>
```

or, if you deliberately want to move the current branch back:

```bash
git reset --hard <old-commit>
```

### Important limitation

Reflog is primarily a **local repository recovery mechanism**. It is not a shared remote history log.

The practical recovery principle is:

```text
Accidental local history movement
    ↓
   reflog
    ↓
find previous reference position
    ↓
create recovery branch / reset / inspect
```

---

## 4.27 `git cherry-pick`

`git cherry-pick` applies the changes introduced by selected commits to the current branch and normally creates new commits.

```bash
git cherry-pick <commit>
```

Example:

```bash
git switch release-branch
git cherry-pick a1b2c3d
```

### Multiple commits

```bash
git cherry-pick <commit1> <commit2>
```

### Commit range

```bash
git cherry-pick <oldest>^..<newest>
```

Understand the range before executing it.

### Apply without committing

```bash
git cherry-pick --no-commit <commit>
```

This applies the changes without automatically creating the commit, allowing you to modify or combine the result.

### Continue / abort / quit

```bash
git cherry-pick --continue
git cherry-pick --abort
git cherry-pick --quit
```

### Main use case

A bug fix exists on another branch, but merging that entire branch is undesirable:

```text
feature branch
   ↓
 specific fix commit
   ↓ cherry-pick
release branch
```

Cherry-picking creates a new commit identity on the destination branch.

---

## 4.28 `.gitignore`

`.gitignore` contains patterns for files that Git should normally leave untracked.

Example:

```gitignore
node_modules/
.env
dist/
*.log
__pycache__/
.vscode/
```

### Pattern forms

```gitignore
*.log
build/
/temp.txt
!important.log
**/cache/
```

Useful concepts:

- `*` matches within path components in normal glob-style patterns.
- `/` at the beginning anchors a pattern relative to the `.gitignore` location.
- A trailing `/` indicates a directory pattern.
- `!` can negate an ignore rule in applicable situations.

### Important limitation

`.gitignore` does not untrack a file that Git is already tracking.

For example, if `.env` was already committed:

```bash
git rm --cached .env
git commit -m "Stop tracking environment file"
```

The file remains locally but is removed from the repository index.

### Check why a file is ignored

```bash
git check-ignore -v path/to/file
```

This is useful when a file is unexpectedly ignored.

### Global ignore file

You can configure patterns that apply to repositories for your user account:

```bash
git config --global core.excludesFile ~/.gitignore_global
```

Use repository `.gitignore` for project rules that should be shared with collaborators.

---

## 4.29 `git tag`

A tag is a named reference to a Git object, commonly used to mark releases.

### Lightweight tag

```bash
git tag v1.0.0
```

This is essentially a simple named reference.

### Annotated tag

```bash
git tag -a v1.0.0 -m "Release 1.0.0"
```

Annotated tags contain tag metadata and are commonly preferred for formal releases.

### Tag a specific commit

```bash
git tag -a v1.0.0 <commit> -m "Release 1.0.0"
```

### List tags

```bash
git tag
git tag -l
git tag -l "v1.*"
```

### Inspect a tag

```bash
git show v1.0.0
```

### Delete local tag

```bash
git tag -d v1.0.0
```

### Delete remote tag

```bash
git push origin --delete v1.0.0
```

### Push tags

```bash
git push origin v1.0.0
git push origin --tags
```

### Important distinction

```text
branch → normally moves as new commits are created
tag  → normally stays fixed
```

---

## 4.30 `git worktree`

A worktree lets one repository have multiple working directories checked out at the same time.

This can avoid repeatedly stashing and switching branches.

### List worktrees

```bash
git worktree list
```

### Add a worktree for an existing branch

```bash
git worktree add ../hotfix hotfix-production
```

### Create a new branch and worktree

```bash
git worktree add -b hotfix-production ../hotfix main
```

### Remove a worktree

```bash
git worktree remove ../hotfix
```

### Clean stale administrative information

```bash
git worktree prune
```

### Important limitation

The same branch generally cannot be checked out simultaneously in multiple worktrees because both working trees would attempt to move the same branch reference independently.

---

## 4.31 `git submodule`

A submodule lets one Git repository reference another Git repository at a specific commit.

It is useful when a project intentionally depends on another independently versioned repository.

### Add

```bash
git submodule add <url> libs/library
```

This records submodule metadata and a specific referenced commit in the parent repository.

### Initialize existing submodules

```bash
git submodule init
```

### Update

```bash
git submodule update
```

### Initialize and update together

```bash
git submodule update --init
```

Recursively:

```bash
git submodule update --init --recursive
```

### Clone with submodules

```bash
git clone --recurse-submodules <url>
```

### Update submodules from their configured remote branches

```bash
git submodule update --remote
```

### Inspect

```bash
git submodule status
git submodule foreach 'git status'
```

### Important mental model

The parent repository does not simply copy the entire child repository into its own history. It records a reference to a particular submodule commit.

Submodules add workflow complexity, so they should be used deliberately.

---

## 4.32 `git bisect`

`git bisect` performs a binary search through commit history to identify the commit that introduced a regression.

### Start

```bash
git bisect start
```

Mark the current version as bad:

```bash
git bisect bad
```

Mark a known-good commit:

```bash
git bisect good <commit>
```

Git checks out a commit approximately halfway between the known good and bad states.

You test it and mark it:

```bash
git bisect good
git bisect bad
```

Repeat until Git identifies the first bad commit.

### Finish

```bash
git bisect reset
```

### Automated bisect

If you have a reliable test command:

```bash
git bisect run <test-command>
```

For example:

```bash
git bisect run ./run-tests.sh
```

The test command should return an exit status that clearly distinguishes good from bad.

### Why it works

If there are 1,000 candidate commits, testing every commit may require up to roughly 1,000 tests. Binary search reduces the number of checks dramatically, approximately `log2(n)` when the process is clean and the predicate is reliable.

---

## 4.33 `git clean`

`git clean` removes untracked files from the working tree. Unlike `git restore`, it is primarily about files Git is **not tracking**.

### Always preview first

```bash
git clean -n
git clean --dry-run
```

### Remove untracked files

```bash
git clean -f
```

### Remove untracked directories too

```bash
git clean -fd
```

### Include ignored files

```bash
git clean -fdx
```

This is substantially more destructive because ignored files are included.

### Interactive mode

```bash
git clean -i
```

### Important distinction

```text
git restore → tracked file content
git clean  → untracked files/directories
```

Never use `git clean -fdx` casually. It can delete build output, local configuration, downloaded files, and other ignored data.

---

## 4.34 `git config`

`git config` reads and writes Git configuration.

### Configuration scopes

```bash
git config --system
git config --global
git config --local
```

Typical precedence is:

```text
system
 ↓ overridden by
user/global
 ↓ overridden by
repository/local
```

### Identity

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### Default branch

```bash
git config --global init.defaultBranch main
```

### List configuration

```bash
git config --list
git config --global --list
git config --local --list
```

Useful diagnostic form:

```bash
git config --show-origin --list
```

This helps identify which configuration file supplied a value.

### Read one value

```bash
git config --get user.name
git config --get user.email
```

### Set aliases

```bash
git config --global alias.st status
git config --global alias.lg "log --oneline --graph --decorate --all"
```

### Remove a setting

```bash
git config --global --unset user.name
```

Be careful with configuration changes when troubleshooting because a repository-local value can override a global value.

---

## 4.35 `git rm`

`git rm` removes tracked files from both the working tree and index by default.

```bash
git rm app.py
git rm -r old-folder/
```

### Stop tracking but keep the file locally

```bash
git rm --cached .env
```

This is especially useful after adding a file to `.gitignore`.

### Force removal

```bash
git rm -f file.txt
```

Use when local modifications would otherwise prevent removal.

### Important distinction

Deleting a file manually and then committing the deletion works, but `git rm` performs the working-tree removal and index update together.

---

## 4.36 `git mv`

`git mv` moves or renames a tracked file while updating the index.

```bash
git mv old-name.txt new-name.txt
git mv src/old.py src/new.py
```

Git does not store a rename as a magical immutable "rename object". Rename detection is generally inferred from similarities between file states.

Therefore, this is also valid:

```bash
mv old.py new.py
git add -A
```

Git can detect the rename when examining history/diffs, depending on similarity thresholds.

---

## 4.37 `git blame`

`git blame` shows which commit and author last changed each line of a file.

```bash
git blame app.py
git blame -L 20,40 app.py
git blame -L 20,+10 app.py
```

Useful for understanding the history behind a particular line, but do not interpret blame output as automatically assigning responsibility for a bug. It identifies the commit associated with the line's current content.

Ignore selected revisions when necessary:

```bash
git blame --ignore-rev <commit> app.py
```

---

## 4.38 `git grep`

`git grep` searches tracked content using Git's repository-aware search facilities.

```bash
git grep "TODO"
git grep "login" -- '*.py'
```

Search a specific revision:

```bash
git grep "login" <commit>
```

This can be useful when searching historical repository content without manually checking out every version.

---

## 4.39 `git ls-files`

`git ls-files` lists files known to the Git index.

```bash
git ls-files
git ls-files --cached
git ls-files --others
git ls-files --ignored --exclude-standard
```

Useful for understanding the difference between tracked/indexed files and untracked/ignored files.

For example:

```bash
git ls-files --others --exclude-standard
```

lists untracked files that are not ignored.

---

## 4.40 `git rev-parse`

`git rev-parse` is a powerful plumbing/inspection command for resolving Git revisions and repository paths.

Common practical forms:

```bash
git rev-parse HEAD
git rev-parse --abbrev-ref HEAD
git rev-parse --show-toplevel
git rev-parse --git-dir
```

Examples:

```bash
git rev-parse --abbrev-ref HEAD
```

returns the current branch name when `HEAD` is attached to a branch.

```bash
git rev-parse --show-toplevel
```

returns the repository's working-tree root.

This command is especially useful in scripts and for understanding Git's revision syntax.

---

## 4.41 `git describe`

`git describe` produces a human-readable name for a commit based on reachable tags.

```bash
git describe
git describe --tags
git describe --always
```

It is useful in build/version scripts where a tag plus distance from that tag can identify a version more meaningfully than a raw hash.

---

## 4.42 `git archive`

`git archive` creates an archive of a tree, often for distributing a source snapshot without the `.git` directory.

```bash
git archive HEAD --format=zip --output=source.zip
git archive HEAD --format=tar.gz --output=source.tar.gz
```

A repository archive is different from cloning because the archive does not contain the Git repository's history.

---

## 4.43 `git maintenance`

Modern Git provides maintenance commands for repository housekeeping.

Useful forms include:

```bash
git maintenance start
git maintenance stop
git maintenance run
```

The exact tasks depend on Git's maintenance configuration. This is more relevant to larger repositories and long-lived development environments than to basic daily Git usage.

---

## 4.44 Git aliases

Aliases create shortcuts for frequently used commands.

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.sw switch
git config --global alias.lg "log --oneline --graph --decorate --all"
```

Then:

```bash
git st
git sw main
git lg
```

Do not rely on personal aliases in team documentation because another developer may not have them configured.

---

## 4.45 Command families — how to choose the right command

### I changed a tracked file and want to discard the edit

```bash
git restore file
```

### I staged a file accidentally

```bash
git restore --staged file
```

### I want to remove recent local commits but keep the changes

```bash
git reset --soft HEAD~N
```

or, if you want the changes unstaged:

```bash
git reset HEAD~N
```

### I want to undo a published commit

```bash
git revert <commit>
```

### I need to temporarily put unfinished work aside

```bash
git stash push -m "WIP"
```

### I accidentally moved the branch backward

```bash
git reflog
```

Find the previous position, then recover deliberately.

### I need one specific commit on another branch

```bash
git cherry-pick <commit>
```

### I need to see what the remote changed without changing my branch

```bash
git fetch origin
git log main..origin/main --oneline
git diff main..origin/main
```

### I need to update my feature branch with `main`

Merge approach:

```bash
git switch feature-login
git merge main
```

Rebase approach:

```bash
git switch feature-login
git rebase main
```

The correct choice depends on the team's history policy and whether the commits are already shared.

---

## 4.46 High-risk commands — stop and inspect first

The following commands can rewrite history or delete work:

```bash
git reset --hard
git push --force
git push --force-with-lease
git clean -f
git clean -fd
git clean -fdx
git branch -D
git stash clear
git rebase
```

Before using one, ask:

```text
Is the work committed?
Is the branch shared?
Can I recover it with reflog?
Am I deleting tracked or untracked files?
Do I have another copy?
```

A useful safety sequence is:

```bash
git status
git log --oneline --decorate --graph --all
git diff
git diff --staged
```

Then perform the operation.

---

# 4.47 Core command comparison matrix

| Command | Primary purpose | Changes working tree? | Changes index? | Moves branch/reference? | Creates commit? |
|---|---|---:|---:|---:|---:|
| `git add` | Build next snapshot | No | Yes | No | No |
| `git commit` | Record staged snapshot | Usually no | No | Yes | Yes |
| `git restore` | Restore file/index state | Sometimes | Sometimes | No | No |
| `git reset` | Move branch + optionally reset index/worktree | Depending on mode | Depending on mode | Yes | No |
| `git revert` | Inverse an earlier commit | Yes, as needed | Yes, as needed | Advances branch | Yes |
| `git stash` | Temporarily save local work | Yes | Yes | No normal branch movement | Creates stash objects, not normal history commit |
| `git merge` | Integrate histories | Yes | Yes | Yes | Sometimes |
| `git rebase` | Replay commits on new base | Yes | Yes | Yes | Creates rewritten commits |
| `git cherry-pick` | Apply selected commit changes | Yes | Yes | Advances branch | Yes |
| `git fetch` | Download remote changes | No normal working-tree change | No normal index change | Updates remote-tracking refs | No |
| `git pull` | Fetch + integrate | Often | Often | Usually | Sometimes |
| `git push` | Publish local refs | No | No | Remote refs move | No new local commit |

---

# 4.48 The most important command distinctions

```text
add vs commit
→ add prepares the next commit; commit records it.

fetch vs pull
→ fetch downloads; pull downloads + integrates.

merge vs rebase
→ merge preserves existing history; rebase rewrites/replays commits.

reset vs revert
→ reset moves history/state; revert creates an inverse commit.

restore vs reset
→ restore focuses on file/index content; reset can move the branch pointer.

checkout vs switch/restore
→ checkout is overloaded; switch handles branches, restore handles files.

branch vs checkout/switch
→ branch creates/manages references; switch/checkout changes what is checked out.

origin/main vs main
→ origin/main is a remote-tracking reference; main is a local branch.

stash apply vs stash pop
→ apply keeps the stash; pop applies and removes it on success.

cherry-pick vs merge
→ cherry-pick selects specific commits; merge integrates branch histories.
```


# 5. Visual Walkthroughs — Recreate the Source material's Diagrams
