# Git & GitHub Master Notes

> A complete, practical Git & GitHub reference with commands, workflows, diagrams, and real-world scenarios.

[![License](https://img.shields.io/github/license/yourprofile/git-github-master-notes)](LICENSE)
[![Last Commit](https://img.shields.io/github/last-commit/yourprofile/git-github-master-notes)](https://github.com/yourprofile/git-github-master-notes/commits/main)
[![Stars](https://img.shields.io/github/stars/yourprofile/git-github-master-notes?style=flat)](https://github.com/yourprofile/git-github-master-notes/stargazers)

## Start Here

For a first pass, use this path:

1. [01 — Big Picture](notes/01-big-picture.md) to understand why Git exists and how Git differs from GitHub.
2. [02 — Core Concepts](notes/02-core-concepts.md) to learn the working tree, index, repository, commits, branches, `HEAD`, remotes, merges, rebases, pull requests, conflicts, and diffs.
3. [03 — Setup](notes/03-setup.md) to install Git, configure identity, choose the default branch, and set up authentication.
4. [04 — Command Playbook](notes/04-command-playbook.md) to work through the commands by purpose and Git state.
5. [06 — Workflows](notes/06-workflows.md) and [07 — Practical Scenarios](notes/07-practical-scenarios.md) to connect the commands to real development work.
6. [09 — Cheat Sheet](notes/09-cheat-sheet.md) when you need a compact command reference.

The [examples](examples/) directory contains small, reproducible demonstrations for conflicts, rebase, stash, and bisect.

## Who This Is For

- Beginners who want a practical path from first-time Git setup to everyday GitHub collaboration.
- Developers who want a command-focused reference for branching, history, undoing changes, remote synchronization, debugging, and recovery.
- Developers preparing for interviews and professional Git workflows.

## What You'll Learn

- The core local Git model is **Working Directory → Staging Area/Index → Repository**.
- A **commit** is a permanent historical record of a project state; a **branch** is a movable reference to commits.
- Branches let multiple developers work independently without immediately changing `main`.
- Pull requests provide a review-and-merge workflow on GitHub.
- Merge conflicts happen when Git cannot automatically reconcile competing changes.
- `git reset`, `git revert`, `git restore`, `git checkout`, and `git stash` solve different kinds of "I need to undo or temporarily move changes" problems.
- `git rebase`, `git reflog`, `git fetch`, `git cherry-pick`, tags, `.gitignore`, worktrees, submodules, and bisect fill important gaps for professional Git usage.
- A GUI such as WebStorm can perform Git operations visually, but understanding the underlying Git model remains essential.

---

## Repository Map

| Area | Purpose |
|---|---|
| `notes/` | Full master notes, divided into the requested sections |
| `examples/` | Minimal hands-on demonstrations |
| `cheatsheets/` | One-page quick reference and PDF generation script |
| `scripts/` | Repository bootstrap script |

## Table of Contents

- [01 — Big Picture](notes/01-big-picture.md)
- [02 — Core Concepts](notes/02-core-concepts.md)
- [03 — Setup & First-Time Config](notes/03-setup.md)
- [04 — Command Playbook](notes/04-command-playbook.md)
- [05 — Visual Walkthroughs](notes/05-visual-walkthroughs.md)
- [06 — Workflows](notes/06-workflows.md)
- [07 — Practical Scenarios](notes/07-practical-scenarios.md)
- [08 — Common Mistakes](notes/08-common-mistakes.md)
- [09 — Cheat Sheet](notes/09-cheat-sheet.md)
- [10 — Glossary](notes/10-glossary.md)
- [11 — Action Items](notes/11-action-items.md)
- [12 — Open Questions](notes/12-open-questions.md)
- [13 — Gaps Filled & Final Mental Model](notes/13-gaps-filled.md)

## How to Use This Repository

### Read online

Start with the numbered notes in order. GitHub renders Markdown directly, so the repository can be used as a reference without cloning it.

### Clone locally

```bash
git clone https://github.com/yourprofile/git-github-master-notes.git
cd git-github-master-notes
```

### Practice locally

The examples are intentionally small. Each example has its own README with the commands and sequence needed to reproduce the workflow.

### Use the cheat sheet

Read [cheatsheets/git-cheatsheet.md](cheatsheets/git-cheatsheet.md) for a compact command reference. To generate a PDF locally:

```bash
bash cheatsheets/generate-pdf.sh
```

## GitHub Pages

You can publish a repository site directly from GitHub:

1. Open **Settings → Pages**.
2. Under **Build and deployment**, choose **Deploy from a branch**.
3. Select the `main` branch and either `/ (root)` or a configured `/docs` directory.
4. Save the configuration and use the generated Pages URL.

For a richer documentation site, the same notes can be presented through a documentation generator such as MkDocs. The repository currently keeps the notes in `notes/`, so a future Pages build can map that content into a dedicated site structure without changing the source notes.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## Code of Conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## License

This repository is released under the [MIT License](LICENSE).

## Suggested GitHub Topics

`git` · `github` · `version-control` · `learning-notes` · `developer-tools` · `cheatsheet`

## Suggested Repository Description

> A complete, practical Git & GitHub reference with commands, workflows, diagrams, and real-world scenarios. Perfect for beginners and professionals.

## Connect

- LinkedIn: https://linkedin.com/in/yourprofile
- Instagram: https://instagram.com/yourprofile
