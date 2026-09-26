# 13. Complete List of Gaps I Filled

This section records the additional Git coverage incorporated into the master notes and closes with the final mental model.

- **Centralized vs distributed VCS** — explains what makes Git architecturally different from older centralized approaches.
- **Precise index/staging-area model** — clarifies what `git add` actually does internally.
- **Commit object model** — explains why a commit is more precise than simply "a folder copy".
- **Branch as a reference/pointer** — corrects the simplified "branch = copy" mental model.
- **Remote-tracking branches** — clarifies how `origin/main` differs from local `main`.
- **`git clone`** — essential for starting work from existing repositories.
- **`git diff`** — essential for reviewing staged/unstaged changes.
- **`git show`** — essential for inspecting individual commits.
- **`git switch`** — modern branch-switching alternative.
- **`git restore`** — modern file restoration and unstaging command.
- **`git fetch`** — essential for understanding remote synchronization separately from pull.
- **`git rebase`** — requested missing standard command and important professional workflow.
- **`.gitignore`** — essential for preventing secrets/build output/dependencies from being tracked.
- **SSH authentication** — common professional GitHub authentication method.
- **PAT/HTTPS authentication** — explains modern HTTPS credentials.
- **`git reflog`** — critical recovery mechanism after accidental history changes.
- **Tags** — important for releases and versioning.
- **Worktrees** — useful for parallel branch work without repeated switching/stashing.
- **Submodules** — important special case for repositories containing other Git repositories.
- **Bisect** — important debugging technique for regression hunting.
- **Clean** — useful for safely removing untracked build artifacts.
- **Aliases** — useful quality-of-life customization.
- **Fork workflow** — common open-source contribution model.
- **Trunk-based development** — modern alternative to branch-heavy workflows.
- **Git Flow** — common historical branching strategy worth recognizing.
- **Reset vs revert vs restore vs checkout vs stash table** — reduces confusion between overlapping commands.
- **Merge vs rebase table** — clarifies the trade-offs.
- **Fetch vs pull table** — clarifies download vs integration.
- **Force-push and `-force-with-lease`** — important safeguard for rewritten history.
- **`git clean` safety** — prevents accidental deletion of untracked files.
- **Untracked-file behavior of stash** — clarifies how untracked files differ from tracked changes when using stash.
- **Rebase conflict continuation/abort** — completes the practical rebase workflow.
- **Recovery-oriented workflow** — makes Git useful not only for normal development but also for recovering from mistakes.

---

## Final Mental Model

- Git is the version-control engine.
- GitHub is a remote hosting and collaboration platform.
- Your normal local workflow is:

```
EDIT
 ↓
WORKING TREE
 ↓ git add
STAGING / INDEX
 ↓ git commit
LOCAL HISTORY
 ↓ git push
REMOTE

```

- When collaborating:

```
main
 ↑
PR ← feature branch
 ↑
developer

```

- When a conflict happens:

```
update main
  ↓
switch feature
  ↓
merge main INTO feature
  ↓
resolve
  ↓
add
  ↓
commit
  ↓
push
  ↓
PR continues

```

- When you make a mistake:

```
Need to inspect old state
    → checkout / switch --detach

Need to rewrite local history
    → reset

Need to undo shared history safely
    → revert

Need to discard working-tree edits
    → restore

Need to pause unfinished work
    → stash

Need to recover from an accidental reset
    → reflog

Need one specific commit elsewhere
    → cherry-pick

```

- Git becomes most valuable when something goes wrong: broken code, unwanted changes, merge conflicts, bad commits, unfinished work, or problematic production changes.
- The professional goal is not memorizing hundreds of commands. It is understanding **what state your repository is in, what state you want, and which command moves you safely from one state to the other**.
