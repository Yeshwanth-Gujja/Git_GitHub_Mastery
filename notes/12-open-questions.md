# 12. Open Questions / Things to Revisit

This section records points to verify or revisit as Git knowledge becomes more advanced.

- ❓ Some copied command forms may be unclear or malformed; verify Git command syntax when the displayed form does not make sense.
- ❓ The exact command described for renaming `master` to `main` is transcribed as something resembling `git branch -dm main`; standard practice is generally `git branch -M main` or `git branch -m main`, depending on context.
- ❓ Creating a branch from another branch can be expressed in two distinct forms: `git branch <new> <source>` creates the branch without switching, while `git switch -c <new> <source>` creates it and switches to it.
- Revisit Git's object model if you need to understand commits, trees, blobs, and references internally.
- Revisit interactive rebase for commit cleanup.
- Revisit reflog recovery after accidental resets.
- Revisit Git hooks and automation for production repositories.
- Revisit signed commits/tags if working on security-sensitive or compliance-heavy projects.
- Revisit Git LFS when repositories contain large binary assets.
- Revisit protected branches and required status checks when collaborating through GitHub.

---

# 13. Complete List of Gaps I Filled
