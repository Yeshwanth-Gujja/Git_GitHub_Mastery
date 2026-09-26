# 8. Common Mistakes & How to Avoid Them

This section collects the mistakes identified in the notes and the corresponding ways to avoid them.

| Mistake Why it happens Fix           |                        |                                |
| ---------------------------------------------- | --------------------------------------------- | -------------------------------------------------------------- |
| `git add .` stages unintended files      | Developers stage before checking       | Run `git status` and `git diff --staged`            |
| Poor commit messages              | Treating commits as diary entries       | Use imperative, specific messages               |
| Forgetting to push a feature branch      | Assuming commit = GitHub update        | Push with `git push -u origin branch`             |
| Assuming local main updates after remote merge | Remote and local repositories are separate  | Run `git pull`                         |
| Confusing merge direction           | Forgetting merge operates into current branch | Check `git status` and current branch             |
| Working directly on `main`           | No branch discipline             | Create feature branches                    |
| Checking out a commit and panicking      | Detached HEAD looks unfamiliar        | Understand detached HEAD and return to a branch        |
| Using reset on shared history         | Reset feels like an easy undo         | Prefer `git revert` for shared branches            |
| Using `git reset --hard` carelessly      | Misunderstanding destructive behavior     | Confirm target and backup important work            |
| Stashing and forgetting the stash       | Temporary work disappears from immediate view | Use `git stash list`                      |
| Assuming stash contains untracked files    | `git stash` defaults do not include them   | Use `git stash -u` when needed                 |
| Force-pushing shared history          | Rebase/reset changed commit IDs        | Use `--force-with-lease` and coordinate            |
| Forgetting `.gitignore`            | Generated/secrets files appear in status   | Add `.gitignore` before the first commit            |
| Committing secrets               | Developers assume private repo means safe   | Never commit credentials; rotate exposed secrets        |
| Working with stale `main`           | Feature branch was created from old history  | Update before merging                     |
| Merging without reviewing           | Integration happens blindly          | Inspect diff and tests before merge              |
| Deleting unmerged branch with `-D`       | Branch cleanup done too aggressively     | Confirm branch is no longer needed               |
| Using `git clean -fd` without preview     | Untracked files are easy to overlook     | Always run `git clean -n` first                |
| Rebasing shared branches            | History is rewritten             | Rebase private/unshared work unless team policy says otherwise |
| Treating `origin` as the only remote      | New users think it is special         | Remember it is just a name                   |

---

# 9. Cheat Sheet — One-Page Quick Reference
