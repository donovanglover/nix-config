# Contributing

If you want to help me improve my dotfiles, you're free to do so. Below documents the process of how you can contribute to this repository.

## Making issues

If the change you propose is drastic or otherwise non-trivial, you should create an issue for it first. In particular, if it takes more than 5 minutes to do, it should probably be an issue.

If you are reporting a problem, make sure that the problem you're facing is not the result of user error. If it is user error, it may help to explain what caused the problem and how the documentation can be improved to compensate.

## Getting your changes merged into master

Make sure that the change you make is non-controversial. Aim to make changes that benefit everyone using this repository. If you have a very specific use case, it may be better to maintain that in your own repo instead.

### Step 1. Create a new feature branch

If you want to add a new feature, use the following format:

```sh
git checkout -b add/what-you-want-to-add
```

If you want to fix an existing feature, use the following format:

```sh
git checkout -b fix/what-you-want-to-fix
```

### Step 2. Commit your changes

If you are adding a new feature, use `dir:` for which directory it affects, followed by your commit message.

```sh
git commit -m "fish: Add abbreviation for git log"
```

Do the same for fixing existing features.

```sh
git commit -m "kitty: Fix border width for inner windows"
```

If you are only modifying documentation, use `docs:`. For substantial changes that affect the system as a whole, use `meta:`.

### Step 3. Submit the patch

Create a pull request with a short description of what you changed. I will review your pull request and merge it if I agree with the changes.
