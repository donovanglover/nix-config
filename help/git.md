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
    - Show the changes that you added but haven't committed yet: `git diff --staged` **OR** `gd --staged` **OR** `gds`
- Show a log of all the commits: `git log` (full log) **OR** `git lg` (commits only, easier to read)
- Edit the last commit message: `git commit --amend`
- Commit a file one part at a time: `git add --patch <file_name>` **OR** `ga --patch <file_name>` **OR** `gap <file_name>`
    - Useful when you made a lot of changes to a file and need to commit it
    - Enables you to commit certain parts of a file and not the entire thing
    - Note that if the file is not in the repository yet, you should do `git add -N <file_name>` or `ga -N <file_name>`
    - Go to the next section: `j`
    - Go to the previous section: `k`
    - Stage this section for the next commit: `y`
    - Do not stage this section for the next commit: `n`
    - Quit and do not stage this section or any of the remaining sections: `q`
    - Split the current section into smaller sections: `s`
    - Manually edit the current section: `e`

Note that the `-u` flag means `set-(u)pstream-to`. It records the location so you don't have to set which remote to push or pull from every time.

Also note that `git clone` makes a remote name of `origin` by default. This is why `git push -u origin master` is usually used.

### Working with Branches

- Show all the branches: `git branch -a`
- Checkout a different branch: `git checkout <branch>`
    - Useful for 1) checking out the master or development branch, 2) checking out an upstream branch, and 3) checking out a feature branch
- Create a new branch: `git checkout -b <branch>`
    - Use `<group>/<description>` to describe your branches
    - For example, a fix for a compiler issue should have a branch name of `fix/description-of-compiler-issue`
    - Note that the branch should be descriptive but not too long (i.e. don't make it longer than above, since the example above is pretty long already)
    - Always create a new branch when submitting pull requests. This allows you to create multiple pull requests for different issues, prevent conflicts between your master branch and upstream, as well as some other things.
- Delete a branch when you're done with it: `git branch -d <branch>`
- Push your changes to a different branch (i.e. your new branch): `git push origin <branch>` **OR** `gp origin <branch>`

## Less common commands

- Removes files to commit: `git rm <files>`
- Delete all local changes in the repository: `git clean -f`
- Show all the diffs and changes from the last N commits: `git log -p -<N>`
- Show the differences between your repository and a remote one: `git log -p master..<REMOTE>/master`
- View all remotes for the current repository: `git remote -v` (e.g. GitHub mirror, friend's fork, upstream, etc.)
- Show the entire contents of a commit, including diffs: `git show <commit>`
- Search for a string in the files of a git repository: `git grep <pattern>` **OR** `gg <pattern>`
    - Search for any tab characters in a repository: `git grep $'\t'` **OR** `ggt`
    - Search for any carriage returns in a repository: `git grep $'\r'` **OR** `ggr`
- Merge all unpushed commits into a single commit: `git rebase -i origin/master`
    - Note that you are not done after this. You must also change `pick` to `squash` (or `s`) for all of the commits you want to merge. This is usually everything except your most recent commit.
    - Another window will open to let you combine all the commit messages into one big commit message

### Working with Tags

- Show all the tags in a repository: `git tag`
- Create a new tag: `git tag -a <tag_name> -m <description>`
    - If `-m` is not given, git will open your editor to allow you to type a more detailed message
    - The tag name is usually a version number such as `v2.4.3`
- View the saved data of a tag: `git show <tag_name>`
- Tag a specific commit instead of the current state in the repository: `git tag -a <tag_name> <commit>`
- Push a tag to the remote repository: `git push origin <tagname>`
    - Note that sharing a tag is the same as sharing remote branches
- Push all tags to upstream: `git push --tags`
- Easily change between versions of a repository (through tags): `git checkout <tag_name>`
- Update a previous version with new changes: `git checkout -b <branch_name> <tag_name>`
    - Note that you should make a new tag for the updated commit since `<tag_name>` already refers to a commit and is not changed
    - For example, if you checkout tag `2.0` then the new tag can be, for example, `2.0.1` or `2.0a`
