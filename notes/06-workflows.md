# 6. Workflows

This section turns the concepts and commands into practical solo, feature-branch, fork-and-PR, trunk-based, Git Flow, integration, undo, conflict-resolution, and rebase workflows.

## 6.1 Solo workflow

- Start with a local repository.
- Make changes.
- Check status.
- Stage.
- Commit.
- Push when remote synchronization is needed.

```bash
git status
git add .
git commit -m "Implement feature"
git push

```

## 6.2 Feature-branch workflow

- A common team workflow is approximately:

```
clone repository
   |
   v
create feature branch
   |
   v
make changes
   |
   v
commit
   |
   v
push feature branch
   |
   v
open Pull Request
   |
   v
review
   |
   v
merge into main
   |
   v
pull updated main locally
   |
   v
repeat

```

- This is a recurring feature-branch workflow.

### Typical commands

```bash
git clone <url>
git switch -c feature-login
git add .
git commit -m "Add login validation"
git push -u origin feature-login

```

- Open PR.
- Get reviewed.
- Merge.
- Update local `main`.

```bash
git switch main
git pull

```

## 6.3 Fork + PR workflow 

- Common open-source contribution model:

```
Original repository
    |
   fork
    v
Your GitHub repository
    |
   clone
    v
Your local repository
    |
 create branch
    v
push branch
    |
    v
PR to original repository

```

- A fork is a server-side copy under your account/organization.
- The contributor usually has: 
 - `origin` → personal fork.
 - `upstream` → original repository.

```bash
git remote add upstream <https://github.com/original/project.git>

```

## 6.4 Trunk-based development 

- Developers integrate small, frequent changes into a shared main/trunk branch.
- Feature flags can keep incomplete features disabled in production.
- The goal is short-lived branches and frequent integration.

## 6.5 Git Flow 

- A more branch-heavy strategy may use concepts such as: 
 - `main`
 - `develop`
 - feature branches
 - release branches
 - hotfix branches
- The appropriate branching strategy depends on project constraints; Git itself does not mandate Git Flow.

## 6.6 Merge vs rebase

| Aspect Merge Rebase |                            |                        |
| -------------------- | ----------------------------------------------------- | ---------------------------------------------- |
| History       | Preserves branch topology               | Creates a more linear history         |
| New commits     | May create merge commit                | Replays commits and creates new IDs      |
| Shared history    | Safe                         | Can be dangerous when rewriting shared commits |
| Conflict handling  | During merge                     | During rebase                 |
| Typical purpose   | Integrate branches without rewriting existing history | Update a branch onto a new base        |
| Main risk      | Extra historical complexity              | History rewrite                |

## 6.7 Fetch vs pull

| Aspect `git fetch` `git pull` |                     |                  |
| ------------------------------ | ---------------------------------------- | --------------------------------- |
| Downloads remote changes    | Yes                   | Yes                |
| Integrates into current branch | No                    | Yes                |
| Safer for inspection      | Yes                   | Less explicit           |
| Typical use          | Review remote updates before integrating | Fetch + integrate in one workflow |

## 6.8 Reset vs revert

| Aspect `git reset` `git revert`      |               |               |
| ------------------------------------------ | --------------------------- | --------------------------- |
| Main idea                 | Move branch/history pointer | Create a new inverse commit |
| Original commits remain on current branch? | Not after reset target   | Yes             |
| Shared branch friendly           | Usually no         | Usually yes         |
| Working-tree behavior           | Depends on mode       | Applies inverse change   |
| Typical purpose              | Rewrite local history    | Public/shared rollback   |

## 6.9 Checkout vs switch vs restore

| Command Main purpose    |                  |
| --------------------------- | ---------------------------------- |
| `git checkout branch`    | Historical branch switching    |
| `git checkout commit`    | Detached HEAD inspection      |
| `git switch branch`     | Modern branch switching      |
| `git switch -c branch`   | Modern branch creation + switching |
| `git restore file`     | Restore file content        |
| `git restore --staged file` | Unstage file            |

## 6.10 Undoing things decision table

| Situation Recommended tool         |                              |
| ------------------------------------------- | --------------------------------------------------------- |
| Unstage a file               | `git restore --staged file`                |
| Discard local file edits          | `git restore file`                    |
| Inspect old commit             | `git checkout <commit>` or `git switch --detach <commit>` |
| Rewrite local commit history        | `git reset`                        |
| Undo shared commit while preserving history | `git revert`                       |
| Temporarily set changes aside        | `git stash`                        |
| Recover after accidental history movement  | `git reflog`                       |
| Apply one commit to another branch     | `git cherry-pick`                     |

## 6.11 Conflict-resolution workflow

- Step 1:

```bash
git checkout main

```

- Step 2:

```bash
git pull

```

- Step 3:

```bash
git checkout <your-feature-branch>

```

- Step 4:

```bash
git merge main

```

- Step 5: Resolve conflicts manually in the editor.
- Step 6:

```bash
git add .

```

- Step 7:

```bash
git commit -m "Resolve merge conflicts"

```

- Step 8:

```bash
git push

```

- Step 9: Return to the PR and request another review.

> The critical mental model: **you are bringing the latest target branch into your branch so that the conflict is resolved before your branch is merged back into the target branch.**

## 6.12 Rebase workflow 

```bash
git switch main
git pull
git switch feature-login
git rebase main

```

- Resolve conflicts if necessary.
- Continue:

```bash
git add .
git rebase --continue

```

- Push rewritten history appropriately:

```bash
git push --force-with-lease

```

> ⚠️ Force-pushing rebased history should only be done when the branch policy allows it.

---

# 7. Practical Scenarios
