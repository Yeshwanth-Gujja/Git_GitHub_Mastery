# Bisect Demo

This example is designed for `git bisect run`. The test script is the only moving part: a good commit has it return `0`, and a bad commit has it return `1`.

## Reproduce

Initialize and commit the good state:

```bash
git init
chmod +x test.sh
git add test.sh
git commit -m "Add passing test"
```

Create a few normal commits between the good state and the regression. For example, edit the file or add comments and commit each change.

Then introduce the regression by changing the last line of `test.sh` from:

```bash
exit 0
```

to:

```bash
exit 1
```

Commit that bad state:

```bash
git add test.sh
git commit -m "Introduce regression"
```

Start bisect:

```bash
git bisect start
git bisect bad
git bisect good <good-commit>
```

Run the automated test:

```bash
git bisect run ./test.sh
```

Git checks candidate commits and identifies the first bad commit.

Finish the bisect session:

```bash
git bisect reset
```
