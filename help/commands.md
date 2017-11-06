## Common Commands

- Move files: `mv <source> <dest>`
- Move directories: `mv -r <source> <dest>`
- Copy files: `cp <source> <dest>`
- Copy directories: `cp -r <source> <dest>`
- Copy all files from one directory to an existing directory (includes dotfiles and subdirectories): `cp -R dir_1/. dir_2/`

Note that "renaming" files is the same as moving them from one location to another. For example, if you want to rename a file `oldfile` to `newfile`, then you would type `mv oldfile newfile`.

- Print the contents of a file: `cat <filename>`
- Batch rename multiple files: `rename -v <find_this_string> <replace_with_this_string> <in_these_files>`
- Remove (delete) files: `rm <filename>`
- Remove (delete) a directory: `rm -r <dirname>`
- Make a new file: `touch <filename>`
- Make a new directory: `mkdir <dirname>`
- List all the files in a directory: `ls`
- List all the directories in a directory: `ls -d */`
- List all the files in a directory, including dotfiles: `ls -A`
- List all the files in dirname: `ls <dirname>`
- Only list png and jpg files: `ls *.{png,jpg}`

## Switching Directories

- Go up one directory: `..`
- Go up two directories: `...`
- Go to the home directory: `~` OR simply `cd` with no parameters
- Go to dirname: `dirname`

Note that for all of the above, `cd` is not required.

### Other Commands

- Print the working directory: `pwd`
- Make a script executable: `chmod +x <file>`
- Termite the processes with a specific word in it: `killall -q <word>`

### System Commands

- Logout of the current user session: `logout`
- Restart the system: `reboot`
- Turn off the computer: `poweroff`

## Installed Commands

These programs are installed on top of the base system.

- List the entire contents of a directory: `tree`
- List all the directories in a directory, up to 2 levels deep: `tree -d -L 2`
- Beautify any JSON output: `<json_output> | jq '.'`

### Inox

- Open a webpage in a borderless window: `inox --app=<url>`
- Open a webpage in the regular browser window: `inox <url>`

### Dealing with Archives

- Zip all files in a directotry: `zip -r <zip_name> <directory>`
- Extract any type of archiving algorithm: `extract <filename>`

