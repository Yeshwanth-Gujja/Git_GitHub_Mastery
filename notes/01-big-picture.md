# 1. Big Picture — Why Git & GitHub Exist

This section establishes the problem Git solves, the distinction between Git and GitHub, and the core mental model behind version control.

## 1.1 The problem Git solves

- Imagine developing inside one folder such as `my project`.
- Without Git, you may create manual versions such as `my project V1`, `V2`, `V3`, and so on.
- When another developer makes changes, you may exchange ZIP files such as `my project V3 John changes.zip`.
- You then manually compare versions and create another combined version.
- If you later discover that a feature disappeared in an older version, you have to search through old folders to determine what changed.
- With many developers, this workflow becomes chaotic, slow, and error-prone.
- Git automates change tracking, preserves history, supports parallel work, and lets you navigate through previous project states.
- A useful mental model is: **Git replaces chaotic folders such as "final", "final really final", "V3", and ZIP-file exchange with structured version history.**
- Git is an industry-standard developer skill.

## 1.2 Git vs GitHub

| / Concept Meaning Main purpose |                           |                     |
| ------------------------------- | --------------------------------------------------- | ---------------------------------------- |
| Git               | Distributed Version Control System         | Track and manage project history     |
| GitHub             | Cloud platform built around Git repositories    | Host repositories and collaborate online |
| Local repository        | Git repository on your machine           | Local development and history      |
| Remote repository        | Repository hosted on a server            | Sharing and synchronization       |
| `origin`            | Conventional remote name              | Short alias for a remote URL       |
| Upstream branch         | Remote branch tracked by a local branch       | Simplifies future push/pull operations  |
| Git object database       | Internal storage of commits, trees, blobs, and tags | Stores Git's actual history       |
| GitHub PR            | A collaboration/review mechanism          | Review and merge proposed changes    |

- Git itself does not require GitHub.
- A local Git repository can exist entirely offline.
- GitHub is one possible remote host.
- Other remote hosts include GitLab, Bitbucket, self-hosted Git servers, and cloud DevOps platforms.

## 1.3 Centralized vs distributed version control

| Model Architecture Example Main characteristic |                     |   |                       |
| ----------------------------------------------- | --------------------------------------- | --- | ------------------------------------------- |
| Centralized VCS                 | One authoritative central repository  | SVN | Developers depend heavily on central server |
| Distributed VCS                 | Every clone contains repository history | Git | Developers have a complete local repository |

- In a distributed system, many Git operations work without network access.
- `git log`, `git diff`, branching, commits, and many recovery operations can work locally.
- Network access is primarily required when synchronizing with a remote or interacting with remote services.

## 1.4 Mental Model

- Think of committing as taking a **snapshot/checkpoint** of a project.
- Commits act as points in history to which you can effectively "time travel".
- Branches can be understood as parallel lines of development for the project.
- A stash temporarily puts unfinished work aside so you can handle something urgent.
- Git provides a traceable history that helps determine what changed when work is lost or broken.
- Git becomes especially valuable when production breaks because history makes investigation and recovery possible.

## 1.5 Visual model

- Recreate the basic local Git diagram as three boxes:

```
Working Directory
    |
   git add
    v
Staging Area / Index
    |
  git commit
    v
Local Repository

```

- Remote collaboration adds another repository:

```
Working Directory
    |
  git add
    v
Staging Area
    |
 git commit
    v
Local Repository
    |
 git push / fetch
    v
Remote Repository
    ^
    |
 git pull

```

## 1.6 Why history matters

- Regular commits make progress easier to track.
- Previous versions can be inspected when something breaks.
- Bad changes can be reverted or reset depending on the situation.
- Git history is also valuable for code review, auditing, debugging, release management, and identifying regressions.

> **Do not treat Git as merely a way to upload code. It is the version-control system underneath your entire development workflow.**

> Additional context: Centralized-vs-distributed architecture and a more precise repository model clarify what makes Git a distributed version-control system.

---
