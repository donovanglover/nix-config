# vim / neovim

Note that the commands I mention in this file are the ones I use the most often and are by no means exhaustive.

For some vim commands, I use a `<leader>` keybinding as an alternative since I find it faster. Some of those commands may not be mentioned in this helpfile. Please see `.vimrc` for more details.

## Starting vim

- Open a file at a particular line number: `vim +<number> <file>`
- Open multiple files in separate tabs: `vim -p <files>`
- Open all files that contain the function / variable / string `str` in the current directory: `vim -p "grep -l <str> [files]"`
    - Note that `[files]` is optional, allowing you to only search for e.g. `*.js` files
    - Also note that you should use "\`" instead of quotation marks
- Compare two files side by side for differences between the two: `vim -d <file1> <file2>`

## Movement Keys

- Go to the beginning of the file: `gg`
- Go to the end of the file: `G`
- Go to the beginning of the line: `0`
- Go to the first non-whitespace character: `^`
- Go to the end of the line: `$`
- Go to the next word: `w`
- Go to the next big word: `W`
- Go to the previous word: `b`
- Go to the previous big word: `B`
- Go to the next end of a word: `e`
- Go to the next end of a big word: `E`
- Go to the previous sentence: `(`
- Go to the next sentence: `)`
- Go to the previous paragraph: `{`
- Go to the next paragraph: `}`

Note that `0` is sometimes called the **hard beginning of line** and `^` is sometimes called the **soft beginning of line**.

Note that you can also go to a specific line number with `5gg` or `5G`, but you should really be using other keys like `/` instead.

- Go to the previous line: `k`
- Go to the next line: `j`
- Go to the previous letter: `h`
- Go to the next letter: `l`

Note that a letter in vim refers to the characters in the file.

These keys may also be used similar to movement keys, although you should really be using the other keys instead.

Note that you can chain numbers with the movement keys, such as `5j` to move down 5 lines, although you should really be using the other keys instead.

Note that you should avoid mapping `j` to `gj` (same for `k` to `gk`). It encourages bad practice and defeats the purpose of using vim.

## Chained Commands

- Copying things: `y + <MOTION>`
    - Copy the current line: `yy`
    - Copy the next 5 lines: `y5y`
    - Copy the current word: `yw`
    - Copy to the end of the line: `y$`
    - Copy inside of the tag: `yit`
    - Copy all of the tag: `yat`
- Deleting things: `d + <MOTION>`
    - Delete the current line: `dd`
    - Delete the current word: `dw`
    - Delete the next 5 words: `d5w`
    - Delete up to the period: `dt.`
    - Delete up to and including the period: `df.`
    - Delete inside of the square brackets: `di[`
    - Delete all of the curly braces: `da{`
- Changing things: `c + <MOTION>`
    - Change the current line: `cc`
    - Change the current word: `cw`
    - Change the next 5 words: `c5w`
    - Change the next 5 letters: `c5l`
    - Change inside the quotation marks: `ci"`
    - Change all of the parentheses: `ca(`
    - Change up until the question mark: `ct?`
    - Change up to and including the question mark: `cf?`

`c` is functionally similar to `d`, but also leaves you in insert mode to change things.

Note that `ci<block>` and `ca<block>` work for pretty much anything, including `{`, `[`, and `t` (for `<tags>`).

## Basic Commands

- Undo the last action: `u`
- Redo the last action: `<C-r>`
- Paste below the current line: `p`
- Paste above the current line: `P`
- Delete the current character: `x`
- Backspace from the cursor position: `X`

Note: If you only copied part of a line, then `p` and `P` will paste after and before the cursor respectfully.

Note that if you want to paste from the system clipboard (i.e. not vim), then you must use `<C-S-v>` in insert mode.

## Inserting Things

- Insert before the cursor:                 `i`
- Insert at the beginning of the line:      `I`
- Insert after the cursor:                  `a`
- Insert at the end of the line:            `A`
- Insert below the current line:            `o`
- Insert above the current line:            `O`
- Replace the character under the cursor:   `r`
- Enter replace mode, replacing the characters you type over: `R`

To help remembering `a`, just know that it *appends* things (after the cursor and at the end of the line)

## Working with Files

Note that there are a lot of buffer commands, however, I only document the ones I actively use here.

There are also a lot of window commands; however, I don't need to use most of them.

Also note that vim tabs is a thing, although you really shouldn't be using them.

- List all the buffers: `:ls`
- Go to the next buffer: `:bn`
- Go to the previous buffer: `:bp`
- Delete the current buffer: `:bd`
- Open a new buffer with file F: `:e <F>`

TODO: Replace these commands with the ones from your plugins

- Open a horizontal split: `:sp [F]`
- Open a vertical split: `:vs [F]`
- Open a new tab: `:tabnew [F]`
- Switch to the next tab: `gt`
- Switch to the previous tab: `gT`
- Close all windows except the current one: `:only`

## Visual Mode

Note that you will never need to use visual mode 99.9% of the time. Use the other keys instead.

- Enter visual mode: `v`
- Enter linewise visual mode: `V`
- Switch sides (in order to mark in the other direction): `o`

Visual mode can be combined with commands such as `y`, `>`, and `d` (non-exaustive).

## Other Stuff

Note that commands I do not find useful are not mentioned here. Consult the help files if you really want to know all the commands in vim.

- Move the current line to the middle of the screen: `zz`
- Move the current line to the top of the screen: `zt`
- Move the screen down half a page: `<C-d>`
- Move the screen up half a page: `<C-u>`
- Convert to lowercase: `gu + <MOTION>`
- Convert to uppercase: `gU + <MOTION>`

## Indenting Things

- Indent: `> + <MOTION>`
- Outdent: `< + <MOTION>`

- Indent the current line: `>>`
    - Indent the next 10 lines: `10>>`
- Outdent the current line: `<<`
    - Outdent the next 10 lines: `10<<`
- Re-indent the entire file: `gg=G`
    - `gg`: Go to the top of the file
    - `=`: Start indenting
    - `G`: Until the end of the file

Note that all other vim movements work while indenting things as well.

## Commands

### Manipulating Files

- Save the current buffer: `:w`
    - Chain `q` to save the current buffer then quit it
    - Chain `!` to force write the currenet buffer
- Quit the current buffer without trying to save: `:q`
    - Chain `!` to force close the current buffer without saving it

### Syntax Highlighting

- Change the syntax highlighting of the current file: `:set syntax=<syntax>`
- Get the syntax of the current file: `:set syntax?`
    - Note that to get the value of any variable, just add `?` to it.
- It is possible to manually change the syntax of a file, although you shouldn't do this since plugins and other features you may have will not be loaded.

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

### vimtex

- Change inside the command: `cic`
- Change inside the environment: `cie`
- Change inside the math block: `ci$`
- Change inside the section: `ciP`
- Go to the matching pair: `%`
- Go to the next section: `]]`
- Go to the previous section: `[[`

## Important Things to Note

- You should only be in insert mode when you are inserting text. If you are not inserting text, then you should not be in insert mode.
- To cancel most things and switch back to normal (keybindings) mode, simply press `esc`.
- Line numbers should NOT be important in your daily workflow and should be disabled most of the time. This lets you focus on what you need to look at: the program itself and nothing more.
