[Vim is a language](https://github.com/mhinz/vim-galore). Use it often enough and you'll be [fluent](https://medium.com/@mkozlows/why-atom-cant-replace-vim-433852f4b4d1) in no time.

Note that the commands I mention in this file are the ones I use the most often and are by no means exhaustive.

For some vim commands, I use a `<leader>` keybinding as an alternative since I find it faster. Some of those commands may not be mentioned here. Please see `.vimrc` for more details.

## Starting vim

- Open a file at a specific line number: `vim +<number> <file>`
- Open multiple files in separate tabs: `vim -p <files>`
- Open all files that contain the function / variable / string `str` in the current directory: `vim -p "grep -l <str> [files]"`
    - Note that `[files]` is optional, allowing you to only search for e.g. `*.js` files
    - Also note that you should use "\`" instead of quotation marks
- Compare two files side by side for differences between the two: `vim -d <file1> <file2>`

## Working with Tab Characters

- Convert tabs to spaces: `:retab`
- Reindent the entire file: `gg=G`
    - `gg` to go to the top of the file
    - `=G` to reindent until the bottom of the file

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
- Go to the previous paragraph: `{`
- Go to the next sentence: `)`
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

- Go to the next instance of `<KEY>` on the current line: `f + <KEY>`
- Go to the previous instance of `<KEY>` on the current line: `F + <KEY>`
- Go until just before the next instance of `<KEY>` on the current line: `t + <KEY>`
- Go until just before the previous instance of `<KEY>` on the current line: `T + <KEY>`

You can easily move through instances like so:

- Go to the next instance when using `f` or `t`: `;`
- Go to the previous instance when using `f` or `t`: `,`

Note that these keys get rarely used (if ever). TODO: Consider aliasing them to something else instead.

### Searching for Things

Note that the search commands are also considered movement keys. You can chain them with the operator commands like everything else.

- Search for the next instance of a string: `/string`
- Search for the previous instance of a string: `?string`
- Search for the next occurrence of the word under the cursor: `*`
- Search for the previous occurrence of the word under the cursor: `#`

TODO: It may be easier to make an alias for `*` and `#`

Once you are back in normal mode, you can navigate through search results like so:

- Go to the next search result: `n`
- Go to the previous search result: `N`

## Mapping Things

Note that the commands below assume that you're writing them in a `.vimrc`. If you want to add new mappings directly in vim, remember to execute the commands in command mode with `:`.

- Map in normal, visual, and operator-pending mode: `map`
- Map in normal mode only: `nmap`
- Map in visual mode only: `xmap`
- Map in command mode only: `cmap`
- Map in operator-pending mode only: `omap`
- Map in insert mode only: `imap`

Note that you should be using `noremap` instead of `map` most (if not all) of the time. This prevents mappings from using mappings made by other commands.

## Chained (Operator) Commands

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

Note that text deleted is also copied into vim's hidden buffer. There is no need for a "cut" command since copying things is handled automatically by vim.

Repeat the last operation with `.`. This is really powerful when you want to perform the same action multiple times.

If you want to repeat the last operation on multiple lines, simply press `<C-v>` to enter visual block mode, select the lines you want to operate on, then execute `.` on them.

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

An example of combining the insert keys with movement keys is `ea`. This combination of keys allows you to append text to the end of a word, since `e` goes to the end of the word and `a` enters insert mode after the cursor.

Note that you can use `<C-o>` at any time while in insert mode to execute a single normal mode command. This is useful if, for example, you want to navigate to the end of the line after making changes to another part of it.

## Working with Files

Note that there are a lot of buffer commands, however, I only document the ones I actively use here.

- Switch to the next window: `<C-w>w`
- Switch to a specific window: `<C-w><h/j/k/l>`
- Move a window up *or* to the left: `<C-w>R`
- Move a window down *or* to the right: `<C-w>r`
- Move the current window to a specific side: `<C-w><H/J/K/L>`

Also note that vim tabs is a thing, although you really shouldn't be using them.

- List all the buffers: `:ls`
- Search all your buffers for one with a specific pattern in its name and go to it: `:b pattern`
- Go to the next buffer: `:bn`
- Go to the previous buffer: `:bp`
- Delete the current buffer: `:bd`
- Open the previously viewed buffer: `:b#`
- Open a new buffer with a given file: `:e <filename>`
- Open the file under the cursor: `gf`

TODO: Replace these commands with the ones from your plugins

- Open a horizontal split: `:sp [filename]`
- Open a vertical split: `:vs [filename]`
- Open a new tab: `:tabnew [filename]`
- Switch to the next tab: `gt`
- Switch to the previous tab: `gT`
- Close all windows except the current one: `:only`
- Close all tabs except the current one: `:tabonly`

## Search and Replace

- Replace foo with bar everywhere: `:%s/foo/bar/g`
- Replace foo with bar on the current line only: `:s/foo/bar/g`
- Replace foo with bar everywhere, but ask for confirmation on each change: `:%s/foo/bar/gc`
    - Change the current item and move on to the next one: `y`
    - Do not change the current item and move on to the next one: `n`
    - Change all the results: `a`
    - Quit making changes: `q`

By default searches are assumed to be case insensitive if the entire string is lowercase. Note that if case matters and the entire search string is lowercase, you should chain `I` to the command to make it case sensitive.

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
- Jump between the opening and closing parentheses, brackets, curly braces, and tags: `%`
- Delete the character under the cursor and enter insert mode: `s`
    - Note that this is an alias of `xi`
- Clear the current line and enter insert mode: `S`
    - Note that this is an alias of `cc`
- Join the current line with the next one: `J`
- Prepend or append the same text to multiple lines: `<C-v><MOTION>I` **OR** `<C-v><MOTION>A`

## Macros

Macros are used for complex commands that can't be repeated with `.`. They help reduce repetition and repeat exactly what you did when you create them.

- Start recording a macro: `q + <SYMBOL>`
    - To end the macro, press `q` again.
    - If you want to end the macro in insert mode, press `<C-o>` then `q`.
- Play back a previously recorded macro: `@ + <SYMBOL>`
    - To repeat the last macro played, simply use `@@`.
- Repeat a macro on all lines: `:%norm! @<SYMBOL>`
    - To repeat a macro on only a specific set of lines, use: `:<from>,<to>norm! @<SYMBOL>`
    - From line 5 to the end of the file: `:5,$norm! @<SYMBOL>`
    - Repeat a macro on all lines matching a pattern: `:g/pattern/norm! @<SYMBOOL>`

## Marking Things

- Mark the current line: `m + <SYMBOL>`
- Go to a previously marked line: `' + <SYMBOL>'`
- Go to a previously marked line, exactly where you were before: ``` + <SYMBOL>``
- Jump to the previous cursor position: `''`
- Jump to the previous cursor position, exactly where you were before: `` ` `` + `` ` ``
- Jump to the previous edit location: `g;`
- Jump to the next edit location: `g,`

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
    - Chain `!` to force write the current buffer
- Quit the current buffer without trying to save: `:q`
    - Chain `!` to force close the current buffer without saving it
- Insert the contents of a file into the current buffer: `:r <filename>`
- Insert the results of a shell command into the current buffer: `:r! <command>`
- Save the current buffer as a new file: `:saveas <filename>`
- Create a new file and open it in a new buffer (not saved until you save it): `:new <filename>`
- Reload the current file: `:e`

### Syntax Highlighting

- Change the syntax highlighting of the current file: `:set syntax=<syntax>`
- Get the syntax of the current file: `:set syntax?`
    - Note that to get the value of any variable, just add `?` to it.
- It is possible to manually change the syntax of a file, although you shouldn't do this since plugins and other features you may have will not be loaded.

### Spell Check

- Toggle spell check: `:set spell!`
- Jump to the next occurrence of a misspelled word: `]s`
- Jump to the previous occurrence of a misspelled word: `[s`
- Choose the first suggestion for the word under the cursor: `1z=`
- Add the word under the cursor to your personal dictionary: `zg`
- Remove the word under the cursor from your personal dictionary: `zug`
- Mark the word under the cursor as misspelled: `zw`

Note that there are more spell check commands out there, although you really shouldn't need them.

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

## Other Commands

These commands may get used from time to time, but aren't used enough to warrant keybindings.

- Switch between soft and hard tabs: `:set expandtab!`
    - Note that you should never have to use this since the repository should have an `.editorconfig`
- Toggle wrap: `:set wrap!`
    - Most of the time you don't want to hide text in a text editor, especially vim
- Resize windows placed on top of each other (as opposed to side by side): `:<N>winc <+/-/=>`
    - `N` is the number of units to increment / decrement the window size by.
    - Do not use `N` when using `=`.
    - Most of the time you shouldn't have to deal with these kinds of window sizes. Instead, prefer vertical splits and `<C-w> + >` / `<C-w> + <` / `<C-w> + =`

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
- Registers keep track of all the things that vim has copied, although I haven't found myself using it often enough to document it here.
- The leader key (space) is used for commands not specific to any file type.
- The local leader (backslash) is used for commands that only affect a certain file type.
- Note that vim has folding capabilities as well although I personally haven't made much use of them.

## Miscellaneous

- If for some reason you need to edit files that have line feeds in them, you can use `:%s/^M/\r/g` to remove the line feeds. At this point, you should easily be able to tell what this command does and reproduce it if necessary.
