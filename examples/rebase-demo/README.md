# Rebase Demo

This example provides a tiny `app.js` file that can be edited across branches to demonstrate replaying commits onto a new base.

## Reproduce

Initialize and create the first commit:

```bash
git init
git add .
git commit -m "Add initial app"

git switch -c feature
```

Make a small feature change in `app.js` and commit it:

```bash
git add app.js
git commit -m "Update feature"
```

Switch back to the main line and make another commit:

```bash
git switch -c main
```

Change `app.js` and commit:

```bash
git add app.js
git commit -m "Update main"
```

Now replay the feature work on top of the updated main line:

```bash
git switch feature
git rebase main
```

Inspect the result:

```bash
git log --graph --oneline --decorate --all
```

If a conflict occurs, resolve the file, stage it, and continue with:

```bash
git add app.js
git rebase --continue
```

To abandon the rebase:

```bash
git rebase --abort
```
