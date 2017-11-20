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
- List all the files in a directory: `ls` **OR** `find`
- List all the directories in a directory: `ls -d */`
- List all the files in a directory, including dotfiles: `ls -A`
- List all the files in dirname: `ls <dirname>`
- Only list png and jpg files: `ls *.{png,jpg}`
- Print the file type based on header information: `file <filename>`
- Show all running processes as a tree: `pstree`
- Print the number of new lines: `wc -l <file>`
- Print the maximum line length: `wc -L <file>`
- Print the word count: `wc -w <file>`
- Show the size of the current directory, including subdirectories: `du -h`
- Show the size of the current directory and its files: `du -ha`
- Get more information about any command: `man <command>`

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
- Get the current time and settings: `timedatectl`
- Show what gets executed when you run a command: `which <command>`
- Create a symbolic (soft) link between two files: `ln -s <source> <dest>`
    - When a program references `dest`, it will link to and give `source`.
    - In comparison, a hard link is when you make a copy of the file
- Change the permissions of a directory to all users: `chmod -R a+rwX dir/`
- Give permissions to the user `hello` and the group `world`: `chown -R hello:world dir/`
- Given text input, return only unique lines (aka no duplicates): `cat <input_file> | uniq`
- Search all files in a directory (and all subdirectories) for a given string: `grep -inr <search_term>` **OR** `g <search_term>`

### System Commands

- Logout of the current user session: `logout`
- Restart the system: `reboot`
- Turn off the computer: `poweroff`

## Installed Commands

These programs are installed on top of the base system.

- List the entire contents of a directory: `tree`
- List all the directories in a directory, up to 2 levels deep: `tree -d -L 2`
- Beautify any JSON output: `<json_output> | jq '.'`
- Easily search for a file in a directory and its subdirectories: `fzf`

### Inox

- Open a webpage in a borderless window: `inox --app=<url>`
- Open a webpage in the regular browser window: `inox <url>`

### Waterfox

- Open a webpage in a new window: `waterfox --new-window <url>`
- Open a webpage in a new tab: `waterfox --new-tab <url>`
- Search for a specific term: `waterfox --search <term>`

### Dealing with Archives

- Zip all files in a directotry: `zip -r <zip_name> <directory>`
- View the contents of rar files: `unrar lb <files>`
- Extract the contents of rar files: `unrar x <files>`
- Extract the contents of zip files: `unzip <files>`
- Extract any type of archiving algorithm: `extract <filename>`

**Note**: When using `unrar` or `unzip` to extract multiple files (with wildcards), you must first escape the `*` to `\*`.

### Opening Things

Note that the preferred way to open things is with the `open` function; however, sometimes it is necessary to use these commands if, for example, you're loading an entire directory.

- Open a video or multiple videos in a playlist: `mpv <files/dir>`

### Firejail

Use `firejail` to sandbox a program or other piece of software. This ensures that the program does not have access to your entire file system since it runs in a restricted environment.

- Run a program in firejail with its default profile (if it exists): `firejail <program>`
- Use firejail by default for all programs that have profiles: `firecfg`
    - List all the programs that use firejail by default: `firecfg --list`
    - Remove all symbolic links to firejail: `firecfg --clean`
- Verify that firejail is being used for a particular program: `firejail --list`

### Pacaur

- Install packages: `pacaur -S <packages>`
- Remove packages (including dependencies no longer needed): `pacaur -Rs <packages>`
- Update all packages: `pacaur -Syu`
- Search for a specific package: `pacaur -Ss <package>`

Note that if you ever get 404s with `pacman` or `pacaur`, you need to update your local database to the new download locations with `-Syu` first.

### Other Pacman Variants

- View the dependencies of a package in tree format: `pactree -c <package>`
    - Add `-d 1` to limit the depth of the tree to one level deep
- List all the packages that depend on a certain package: `pactree -rc <package>`
- Remove all cached versions of packages except the most recent one: `paccache -rk1`
- Remove all cached versions of uninstalled packages: `paccache -ruk0`

### Working with Online Resources

- Download anything online: `wget <url>`
- View the response header and contents of any webpage: `http <url>`

## Custom Commands

- Easily switch to a 4k resolution with DPI scaling: `4k`
- Easily switch to a 1080p resolution (with 96 DPI): `1080p`
- Run a command as root: `pls <command>`
- Run the previous command as root: `pls !!`

