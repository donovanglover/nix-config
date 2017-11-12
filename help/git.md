# Git

## Common commands

- Start a new git repository: `git init` **OR** `gi`
- Add files to commit: `git add <files>` **OR** `ga <files>`
- Commit those files to the repository: `git commit -m <message>` **OR** `gc <message>`
- Undo the last commit: `gr`
- Undo the last commit and delete changes: `grr`
- Update your local repository with a remote repository: `git pull -u <remote> <branch>`
    - The most common use is `git pull -u origin master`, although this also works for upstream remotes
- Show the status of the local repository: `git status` **OR** `gs` **OR** `git s`
- Push changes from your local repository to a remote repository: `git push <remote> <branch>` **OR** `git push` **OR** `gp`
    - The most common use is `git push origin master`, which is usually the default for `git push`
- Show the difference between the staging area and the working tree: `git diff` **OR** `gd`
- Show a log of all the commits: `git log` (full log) **OR** `git lg` (commits only, easier to read)
- Edit the last commit message: `git commit --amend`

Note that the `-u` flag means `set-(u)pstream-to`. It records the location so you don't have to set which remote to push or pull from every time.

Also note that `git clone` makes a remote name of `origin` by default. This is why `git push -u origin master` is usually used.

### Working with Branches

- Show all the branches: `git branch -a`
- Checkout a different branch: `git checkout <branch>`
    - Useful for 1) checking out the master or development branch, 2) checking out an upstream branch, and 3) checking out a feature branch
- Create a new branch: `git checkout -b <branch>`
- Delete a branch when you're done with it: `git branch -d <branch>`

## Less common commands

- Removes files to commit: `git rm <files>`
- Delete all local changes in the repository: `git clean -f`
- Show all the diffs and changes from the last N commits: `git log -p -<N>`
- Show the differences between your repository and a remote one: `git log -p master..<REMOTE>/master`
- View all remotes for the current repository: `git remote -v` (e.g. GitHub mirror, friend's fork, upstream, etc.)
- Show the entire contents of a commit, including diffs: `git show <commit>`
- Search for a string in the files of a git repository: `git grep <pattern>`

