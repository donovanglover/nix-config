# vim / neovim

Note that the commands I mention in this file are the ones I use the most often and are by no means exhaustive.

For some vim commands, I use a `<leader>` keybinding as an alternative since I find it faster. Some of those commands may not be mentioned in this helpfile. Please see `.vimrc` for more details.

## Starting vim

- Open a file at a particular line number: `vim +<number> <file>`

## Movement Keys

### Inserting Things

- Insert before the cursor:             `i`
- Insert at the beginning of the line:  `I`
- Insert after the cursor:              `a`
- Insert at the end of the line:        `A`

## Indenting Things

- Indent the current line: `>>`
    - Indent the next 10 lines: `10>>`
- Unindent the current line: `<<`
    - Unindent the next 10 lines: `10<<`

Note that all other vim movements work while indenting things as well.

## Commands

### Syntax Highlighting

- Change the syntax highlighting of the current file: `:set syntax=<syntax>`
- Get the syntax of the current file: `:set syntax?`
    - Note that to get the value of any variable, just add `?` to it.
- It is possible to manually change the syntax of a file, although you shouldn't do this since plugins and other features you may have will not be loaded.

## Common operations

### Commenting lines

- Comment the current line:
    - Simply press `I` to enter insert mode at the beginning of the line. From there you can do whatever you want, including inserting a comment.
    - If you want to repeat the process for multiple lines, you can go to the line you want to change and press `.` to execute the last set of key combinations.
- Comment multiple lines at the same time:
    - Use `<C-v>` to enter visual block mode
    - Select the lines you want to comment out with `j/k`
    - Press `I` to go to the beginning of the line
    - Type whatever you want to put at the beginning of all the lines here, including comments
    - When you're done, exit the mode as usual

### Uncommenting lines

- Uncomment the current line:
    - Simply press `0` to go to the beginning of the line (if needed)
    - Then, press `x` to delete the character under the cursor
- Uncomment multiple lines at the same time:
    - Use `<C-v>` to enter visual block mode
    - Select the lines you want to comment out with `j/k`
    - Press `x` to delete the first character, repeatedly if necessary
    - Exit the mode as usual

## Plugin Specific

### fzf.vim

- Open the result in a new tab: `<C-t>`
- Open the result in a new horizontal split: `<C-x>`
- Open the result in a new vertical split: `<C-v>`
- Use a command in fullscreen: `:Command!`
