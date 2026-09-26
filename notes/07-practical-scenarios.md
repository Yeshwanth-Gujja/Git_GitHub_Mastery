# 7. Practical Scenarios

This section applies the commands to concrete repository tasks and common day-to-day situations.

## 7.1 Initial repository setup

- Create a project directory.
- Initializes Git.
- Creates `hello.js` and `readme.md`.
- Runs `git status`.
- Stages `readme.md`.
- Commits it.
- Creates `test.js`.
- Uses `git add .`.
- Creates a second commit.
- Checks history with `git log`.

## 7.2 Inspecting an old commit

- Copy the first commit hash.
- Exits `git log` with `q`.
- Runs:

```bash
git checkout <commit-hash>

```

- The repository enters detached HEAD.
- The older file state becomes visible.
- No commit history is deleted.
- Returning to the branch:

```bash
git checkout main

```

## 7.3 Linking local repository to GitHub

- Create an empty repository on GitHub.
- When the local repository already contains history, leave the GitHub repository's README initialization checkbox off to avoid creating unrelated initial history.
- Add remote:

```bash
git remote add origin <github-url>

```

- Push:

```bash
git push -u origin main

```

## 7.4 Feature branch + pull request

- Create:

```bash
git checkout -b feature-branch

```

- Modify `readme.md`.
- Stage:

```bash
git add .

```

- Commit with an imperative message:

```bash
git commit -m "Modify README"

```

- Publish:

```bash
git push -u origin feature-branch

```

- Open a pull request.
- Review it.
- Merge it into `main`.
- Return locally and:

```bash
git checkout main
git pull

```

## 7.5 Merge conflict scenario

- Two development branches are created.
- One branch modifies the same line in `readme.md`.
- Another branch modifies that same line differently.
- One PR is merged first.
- The second PR now reports a conflict.
- The developer updates local `main`.
- Switches to the feature branch.
- Runs:

```bash
git merge main

```

- The conflict editor shows the conflicting sections.
- The developer combines desired portions.
- Stages and commits the resolution.
- Pushes it back to the PR.
- GitHub now detects the resolved state.

## 7.6 Reset scenario

- Create multiple commits involving `hello.js`.
- One later commit intentionally contains "bad code".
- `git log` is used to find the earlier good commit.
- Run a mixed reset to that earlier commit.
- The commits disappear from the current branch history.
- Their file changes remain in the working tree.
- Remove the unwanted changes manually.

## 7.7 Revert scenario

- A commit adds another console log.
- The goal is to undo the effect without erasing the commit from history.
- `git revert <commit>` creates a new reverse commit.
- After conflict handling and `git revert --continue`, the history visibly contains both the original commit and the later revert.

## 7.8 Stash scenario

- Work is partially complete.
- An urgent bug needs attention.
- `git stash` removes the unfinished changes from the working tree.
- The urgent task is committed and pushed.
- `git stash list` identifies the stash.
- `git stash apply stash@{0}` restores the feature work.
- A conflict occurs because the urgent fix touches similar code.

## 7.9 WebStorm GUI workflow

- Create a repository from the IDE.
- Commit through the GUI.
- Create a branch.
- Switch branches.
- Push to GitHub.
- Add commits.
- Commit and push in one action.
- Update/pull changes.
- View Git history.
- Inspect diffs.
- Merge branches.
- Open pull requests.
- Review pull requests.
- Add comments.
- Merge pull requests.
- Fetch.
- Delete branches.
- Compare branches.
- Cherry-pick.
- Revert commits.
- Resolve conflicts.
- View the underlying Git commands in the console.

> **Using a GUI is not "cheating" as long as you understand what the tool is doing underneath.**

> Additional context: Production-oriented scenarios include accidental resets, public history, fork workflows, rebase, reflog recovery, tags, and automated regression investigation.

---

# 8. Common Mistakes & How to Avoid Them
