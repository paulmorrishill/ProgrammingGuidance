# What is Git

Git records the history of your project. Each time you save a checkpoint, Git stores
the state of every tracked file. You can return to any checkpoint later.

## The problem

Without Git you meet these four failures:

- You copy the folder to `project-final`, then `project-final-2`, then `project-final-REAL`.
- You delete code that worked and cannot recover it.
- Two people edit one file and one edit overwrites the other.
- The app breaks and you cannot tell which change broke it.

Git solves all four.

## Git is not GitHub

Git is a program on your computer. It works with no internet connection.

GitHub is a website that stores copies of Git repositories. GitLab, Bitbucket and
Codeberg do the same job.

You can use Git without GitHub. You cannot use GitHub without Git.

## Mental model

A repository is your project folder plus a hidden `.git` folder inside it.

`.git` holds every checkpoint you ever made. Delete `.git` and you delete the
history. Your current files stay. Everything before now disappears.

A commit is one checkpoint. It stores four things:

- A snapshot of every tracked file
- The message you wrote
- The author and the time
- A link to the commit before it

Those links form a chain from the first commit to the newest. The chain is the history.

## The three places a change lives

Git adds a step between editing and committing. New users find this step confusing.
Its purpose is to let you choose what goes into the next commit.

1. **Working directory** — the files you edit.
2. **Staging area** — the changes you marked for the next commit. Use `git add`.
3. **Repository** — the committed history. Use `git commit`.

Example: you edited 5 files, but only 2 belong to the bug fix. Stage those 2 and
commit them. The other 3 wait for a separate commit.

## Branch

A branch is a label that points at one commit. That is the whole idea.

`main` is the default branch name. Create a branch to try a change without touching
`main`. Merge the branch when the change works. Delete the branch when it does not.
A branch costs almost nothing.

## Remote

A remote is a copy of the repository on another machine, usually GitHub. The default
remote name is `origin`.

| Command | What it does |
|---|---|
| `git clone` | Copies a remote repository to your machine, one time |
| `git push` | Sends your commits to the remote |
| `git fetch` | Downloads remote commits, changes no files |
| `git pull` | Downloads remote commits and merges them into your branch |

Your copy and the remote can differ. Git never syncs on its own. You run the command.

## Merge conflicts

Two commits change the same lines. Git cannot choose between them, so it writes both
versions into the file:

```text
<<<<<<< HEAD
your version of the line
=======
their version of the line
>>>>>>> feature-branch
```

To resolve it:

1. Open the file.
2. Keep the correct code and delete the rest.
3. Delete the three marker lines.
4. Run `git add <file>`, then `git commit`.

Nothing is lost and nothing is broken. Git is asking you a question.

## .gitignore

`.gitignore` lists the paths Git must not track. Every project needs one.

Never commit:

- `node_modules/` — large, and you can reinstall it
- `.env` — secrets
- `dist/` or `build/` — generated output
- `.DS_Store` — operating system junk

A secret committed once stays in the history forever. A later commit that deletes the
file does not remove it from the history. You must rotate the key.

## Do this

```bash
git status            # what changed, and what is staged
git add .             # stage every change
git commit -m "Fix login redirect on expired session"
git log --oneline     # list commits, newest first
git diff              # show unstaged changes
git push              # send commits to the remote
git pull              # bring remote commits into your branch
```

## Undo

| Situation | Command | Note |
|---|---|---|
| Discard an edit to a file | `git restore file.txt` | Destroys uncommitted work |
| Unstage a file | `git restore --staged file.txt` | Safe |
| Reverse a pushed commit | `git revert <hash>` | Safe, creates a new commit |
| Move the branch back, keep files | `git reset --soft <hash>` | Rewrites history |
| Find a commit you lost | `git reflog` | Safe, shows commits `git log` hides |

`git reflog` recovers most lost commits for about 90 days. Commit often and you lose
almost nothing.

## Common mistakes

- **Messages like "update", "fix", "asdf".** In six months they tell you nothing.
- **One commit per day.** You cannot reverse one part of a large commit.
- **Committing `.env`.** The key is now public. Rotate it.
- **`git push --force` on a shared branch.** It deletes commits other people pushed.
- **Waiting until the work is finished.** Commit each working state as you reach it.

## Next

- What is a pull request
- Branching for one person and for a team
- Reading `git log` and `git diff`
