# Stash Demo

This example shows how `git stash` can temporarily move unfinished local work aside.

## Reproduce

Initialize the example:

```bash
git init
git add .
git commit -m "Add stash demo"
```

Edit `work.txt` without committing it:

```text
WORK IN PROGRESS
```

Check the working tree:

```bash
git status
```

Stash the unfinished work:

```bash
git stash push -m "WIP stash demo"
```

Confirm the working tree is clean:

```bash
git status
```

List stashes:

```bash
git stash list
```

Restore the work while keeping the stash entry:

```bash
git stash apply
```

Or restore and remove the stash entry on success:

```bash
git stash pop
```

To include untracked files in a stash, use `git stash -u`.
