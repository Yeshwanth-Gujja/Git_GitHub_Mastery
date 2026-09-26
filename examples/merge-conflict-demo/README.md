# Merge Conflict Demo

This example is intentionally tiny. The goal is to reproduce a basic merge conflict by changing the same line in `file1.txt` on two branches.

## Reproduce the conflict

```bash
git init
git add .
git commit -m "Add conflict demo"

git switch -c feature-a
```

Edit `file1.txt` on `feature-a` so the original line becomes something like:

```text
Feature A version
```

Then commit:

```bash
git add file1.txt
git commit -m "Change file1 on feature-a"
```

Return to the main branch:

```bash
git switch -c feature-b main
```

Edit the same line in `file1.txt` to a different value:

```text
Feature B version
```

Commit it:

```bash
git add file1.txt
git commit -m "Change file1 on feature-b"
```

Now merge the other branch:

```bash
git merge feature-a
```

Git should report a conflict because both branches changed the same line.

Check the state:

```bash
git status
```

Open `file1.txt`, resolve the conflict, remove the conflict markers, and keep the final content you want. Then:

```bash
git add file1.txt
git commit
```

`file2.txt` is included as a second file so you can repeat the same exercise with another path.
