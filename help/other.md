This file holds other GNU/Linux information that aren't (?) detailed enough to be their own file.

## Ranger

### Movement Keys

- Scroll down: `j`
- Scroll up: `k`
- Go back one directory: `h`
- Go forward one directory *or* open the selected file: `l`
- Move to the top of the file list: `gg`
- Move to the bottom of the file list: `G`
- Go to the Nth file: `<N>gg`
- Go to the home directory: `gh`
- Go to the root directory: `gr`
- Quit ranger: `q`

### Useful Things

- Search for files in the current directory: `/`
- Quickly find and automatically open files that match the pattern: `f`
- Manually choose software to open the selected file with: `r`
- Edit the selected file in your editor of choice: `E`
- Switch back to the terminal and cd to the current directory: `S`
- Toggle hidden files: `zh`

### Other Commands

- Enter command mode: `:`
- Change how files are sorted: `o`
    - Sort by size: `s`
    - Sort by file type: `t`
    - Sort by last modified: `m`
    - Sort by date created: `c`
    - Sort by time accessed: `a`
    - Sort alphabetically (default): `b`
    - Reverse the results: `r`
    - Randomize the results: `z`
- Rename the selected file: `:r <newname>`
- Edit an existing filename: `A`

### Other notes

- You should never use ranger to manipulate files. Ranger does one thing and does it well: explore files.
- You should not use tabs in ranger. What you would do with tabs can be accomplished easier with the terminal.
- Although bookmarks are a feature in ranger, your file management should be simple enough that bookmarks aren't required.

## GNU/Linux Root File Structure

```
/               # Root directory
/bin            # Binaries for global commands (ls, cat, etc.)
/boot           # Boot loader files (grub, the linux kernel, etc.)
/dev            # "Device files" (/dev/null, /dev/random, etc.)
/etc            # System-wide configuration files
/home           # Saved files and personal settings of each user
/lib            # Libraries used by the binaries in /bin
/lib64          # 64-bit libraries
/mnt            # Temporarily mounted filesystems reside here
/opt            # Applications that don't rely on other dependencies
/proc           # Provides process and kernel information as files
/root           # Home directory for the root user
/run            # Information about the running system since last boot
/sbin           # System binaries (fsck, init, route, etc.)
/srv            # Site-specific data served by the system
/sys            # Contains information about the system
/tmp            # Temporary files used for processes
/usr            # Applications that rely on other dependencies
/var            # Variable files that are supposed to change over time
```

## Waterfox

### Command Mode

- Take a screenshot of the entire page          `screenshot --fullpage`
- Take a screenshot of the visible window only  `screenshot`
- Restart the browser                           `restart`

### Preferences

Waterfox has 2 preference files: `prefs.js` and `user.js`.

`prefs.js` are the settings defined by the browser and `user.js` is an optional file that you can create. `user.js` takes precedence over `prefs.js` and will replace the settings in `prefs.js` when Waterfox is started.

### Theme

Waterfox allows you to customize the appearance of the browser by creating your own `userChrome.css`. It is located inside of the `chrome` folder, which needs to be created by the user.

## tty

### Moving Around

- Move to the previous terminal:    `Alt+Left`
- Move to the next terminal:        `Alt+Right`
- Switch to the Nth terminal:       `Ctrl+Alt+F<N>`
- Scroll up:                        `Shift+PgUp`
- Scroll down:                      `Shift+PgDn`

### Manipulating Text

- Copy text:                            `Ctrl+Shift+C`
- Paste text:                           `Ctrl+Shift+V`
- Go to the beginning of the line:      `Ctrl+A`
- Go to the end of the line:            `Ctrl+E`
- Remove everything after the cursor:   `Ctrl+K`
- Clear the terminal:                   `Ctrl+L`

### Piping

- Take the output from `a` and use it as the input for `b`: `a | b`
- Take the output from `a` and write it to the file `b`:    `a > b`
- Take the output from `a` and append it to the file `b`:   `a >> b`

### Wildcard

- Use `*` anywhere as a wildcard to find all matches
- Use `**` to wildcard subdirectories (e.g. `~/.config/**/*.cr`)

### Control Keys

- Cancel the running command:                       `Ctrl+C`
- Suspend the current process (resume with `fg`):   `Ctrl+Z`

## fish - the friendly interactive shell

### Passing things around

- Read input from a file: `command < file.txt`
- Write output to a file: `command > file.txt`
- Append output to a file: `command >> file.txt`
- Write an error to a file: `command ^ file.txt`
- Append an error to a file: `command ^^ file.txt`

### Misc.

- Pipe the output of a program into another one: `git status | lolcat`
- Learn more about a program: `man fish` **OR** `fish -h`
- Match any single character except `/` (includes an empty string): `?`
- Create a new variable: `set my_var "some_string"`
    - By convention, exported variables are in `$UPPERCASE` and unexported variables are in `$lowercase`
- Create a new exported variable: `set -x MY_VAR "some_string"`
- Unset a variable: `set -e my_var`

### Jobs

- Start a background job: `ncmpcpp &`
- Bring a background job to the foreground: `fg`
- Move the current program to the background: `<C-z>`

Note that your fish config file is located at: `~/.config/fish/config.fish`

### Functions

```fish
function func
    # Do something
end
```

Note that you should put your functions in `~/.config/fish/functions/function_name.fish`.

### Aliases

```fish
function ls
    command exa $argv
end
```

```fish
alias ls="exa"
```

### Autosuggestions

- Complete autosuggestions with the right arrow **OR** `<C-f>`.
- Complete only the next word with alt right **OR** `<A-f>`.

- `-c` + The program you want to autocomplete for
- `-s` + A shorthand parameter (e.g. `-s o` for `-o`)
- `-l` + A longhand parameter (e.g. `-l output` for `--output`)
- `-a` + Parameter arguments (e.g. `-a "true false"` if an `--option` can take both `true` and `false` as values)

See complete --help for more options. Examples in `/usr/share/fish/completions`.

You can make completions in the terminal, a configuration file, anywhere!

### Tab Completions

Use tab for tab completion (as obvious as this may seem, it's really useful!)

Any completions you make should be in `~/.config/fish/completions/program_name.fish`

### Command substitution

- Pass the results of one command as the argument of another command: `echo (ls -al)`

### Expansions

- Brace expansion: `echo file.{png,jpg}`, `mv *.{cr,rs} src/`
- Variable expansion:
    - `echo $var # => echo 1 2 3`
    - `echo "$var" # => echo "1 2 3"`
    - `set a 1; set b a; echo $$b # => 5`
- Index range expansion: `echo (seq 10)[1..5] # => echo 1 2 3 4 5`
- Reverse output: `echo (seq 10)[-1..1]`
- Home directory expansion: `~`
- Process expansion: `%self`

Note that in fish, variables start at 1, similar to lua et al.

```fish
set my_arr "a" "b" "c"
```

- `$argv` is the array of arguments given to the shell or function

You can change the colors fish uses with `$fish_color_*` and `$fish_pager_color_*`

To work with multiple lines in fish, either use `Enter` with a block statement (`if`, `for`, `begin`, etc.), use `<A-CR>`, or add `\` to the end of your lines.

- Only run with a login shell: `status --is-login`
- Only run with an interactive shell: `status --is-interactive`
- Get the status of the last executed command (success, failure, etc.): `echo $status`

- Use multiple commands on the same line `;`
- And operator: `; and`
- Or operator: `; or`

### Conditionals

```fish
if condition
    # Do something
else
    # Do something else
end
```

### Switch

```fish
switch(name)
case Sally
    # Do something
case John
    # Do something else
case '*'
    # Catch-all
end
```

List all the functions available to fish: `functions`

### Loops

```fish
while true
    # Do something
end
```

```fish
for file in *.txt
    # Do something with all .txt files
end
```

```fish
for i in (seq 5)
    # Do something 5 times
end
```

Set colors in fish:

```fish
set_color purple
echo "some text"
set_color normal
echo "more text"
```
