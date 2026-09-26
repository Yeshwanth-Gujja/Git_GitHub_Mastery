# 3. Setup & First-Time Config

This section covers first-time Git installation, configuration, authentication, and the setup checklist.

## 3.1 Installing Git

- Git must be installed before using Git from the terminal.
- Install the Git version appropriate for your operating system from the official Git distribution.
- On Windows, Git for Windows provides Git Bash and command-line Git.
- On macOS, Git can be installed through Xcode Command Line Tools or package managers.
- On Linux, Git is normally available through the distribution package manager.

## 3.2 Verify installation — `git --version` 

> What it does: Displays the installed Git version.

**Usage:**

```bash
git --version

```

**Example:**

```bash
git --version

```

**When to use:**

- Use immediately after installing Git.
- Use when troubleshooting which Git installation your shell is using.

**Common options / notes:**

- `-version` is the standard global version flag.

**Gotcha:**

- If the command is not found, Git is either not installed or not available on the system `PATH`.

> ❓ If a copied command appears as `git D- version` or another malformed variant, the correct command is `git --version`.

## 3.3 Configure user name — `git config --global user.name` 

> What it does: Configures the name Git records in commits.

**Usage:**

```bash
git config --global user.name "Your Name"

```

**Example:**

```bash
git config --global user.name "Yeshwanth"

```

**When to use:**

- During initial Git setup.

**Common options:**

- `-global` applies the setting to the current user's Git configuration.
- Without `-global`, the configuration applies only to the current repository.

**Gotcha:**

- This identity is commit metadata; it is not itself an authentication credential for GitHub.

## 3.4 Configure email — `git config --global user.email` 

> What it does: Configures the email Git records in commits.

**Usage:**

```bash
git config --global user.email "you@example.com"

```

**Example:**

```bash
git config --global user.email "you@example.com"

```

**When to use:**

- During initial Git setup.

**Common options:**

- `-global` applies the setting for your user account.
- Repository-specific configuration can omit `-global`.

**Gotcha:**

- GitHub may associate commits with your GitHub account based on email matching and repository/account configuration.

## 3.5 Configure default branch — `git config --global init.defaultBranch` 

> What it does: Sets the default branch name used for newly initialized repositories.

**Usage:**

```bash
git config --global init.defaultBranch main

```

**Example:**

```bash
git config --global init.defaultBranch main

```

**When to use:**

- Configure `main` as the initial branch name.
- Set this once so future `git init` repositories consistently start on `main`.

**Gotcha:**

- This affects newly initialized repositories; it does not rename an existing branch.

## 3.6 Inspect configuration — `git config --list` 

> What it does: Displays Git configuration settings.

**Usage:**

```bash
git config --list

```

**Example:**

```bash
git config --global --list

```

**When to use:**

- Use when debugging Git identity, aliases, credential helpers, default branch settings, or other configuration.

**Common options:**

```bash
git config --global --list
git config --local --list
git config --system --list

```

**Gotcha:**

- More specific configuration levels override broader ones.

## 3.7 Configuration levels

| Level Scope |                |
| ------------ | ----------------------------- |
| `--system`  | Whole machine         |
| `--global`  | Current operating-system user |
| `--local`  | Current repository      |

## 3.8 SSH authentication 

> What it does: Lets Git authenticate to supported remotes using an SSH key pair rather than repeatedly supplying HTTPS credentials.

**Typical flow:**

```bash
ssh-keygen -t ed25519 -C "you@example.com"
ssh-add ~/.ssh/id_ed25519

```

**Example remote:**

```bash
git@github.com:username/repository.git

```

**When to use:**

- Recommended when you frequently interact with GitHub over SSH.

**Gotchas:**

- Never publish the private key.
- The public key is safe to add to Git hosting.
- SSH setup differs slightly by operating system and shell.

## 3.9 HTTPS + PAT authentication 

- GitHub no longer uses an account password as the normal HTTPS Git authentication mechanism.
- A **Personal Access Token (PAT)** can be used where password-style authentication is requested by a credential flow.
- Git credential managers can securely cache authentication.

> Never commit access tokens, API keys, SSH private keys, or other credentials into a repository.

## 3.10 Setup checklist

- [ ] Install Git.
- [ ] Verify with `git --version`.
- [ ] Configure `user.name`.
- [ ] Configure `user.email`.
- Configure `main` as the default branch.
- Configure authentication with SSH or HTTPS credentials.
- Verify configuration.
- Verify GitHub access with a test repository.

> Additional context: SSH, HTTPS/PAT authentication, configuration inspection, and configuration-scope precedence are included to make first-time Git setup complete.

---

# 4. Command Playbook — Detailed Reference
