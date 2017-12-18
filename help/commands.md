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
- Print the number of lines in a file: `wc -l <file>`
- Print the length of the longest line in a file: `wc -L <file>`
- Print the number of words in a file: `wc -w <file>`
- Print the number of lines in all markdown files in a given directory, including subdirectories: `find . -name "*.md" | xargs wc -l`
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
- Termite the processes with a specific word in it: `killall -q <word>`
- Get the current time and settings: `timedatectl`
- Show what gets executed when you run a command: `which <command>`
- Create a symbolic (soft) link between two files: `ln -s <source> <dest>`
    - When a program references `dest`, it will link to and give `source`.
    - In comparison, a hard link is when you make a copy of the file
- Give permissions to the user `hello` and the group `world`: `chown -R hello:world dir/`
- Given text input, return only unique lines (aka no duplicates): `cat <input_file> | uniq`
- Search for a particular font on the system: `fc-list | grep -i <font>`
- Search for all files of a specific extension in a given directory: `find . -name "*.ext" -type f`
    - Chain `-delete` to the end of the find command in order to delete the results
    - This is useful if, for example, you want to delete all files with the extension `ext` in all directories and subdirectories

### Changing File Permissions

- Make a script executable: `chmod +x <file>`
- Change the permissions of a directory to all users: `chmod -R a+rwX dir/`
- Give anyone and everyone access to a directory: `chmod -R 777 dir/`
    - Useful for deleting files that the current user can't delete

Note that you should *never* give a file or directory more permissions than needed. `a+rwX` and `777` should only be used in extreme situations where you have to change permissions before using a file. You should change the permissions back or delete the file when you're done.

### Searching Through Files

- Search all files in a directory (and all subdirectories) for a given string: `grep -inr <search_term>` **OR** `g <search_term>`
- Search all files in a directory (including subdirectories) for a given string and ignore dotfiles: `ag <search_term>`

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
- Show duplicate files in a given directory, with the ability to remove them as well: `fdupes <dir>`
    - Add `-r` to go through subdirectories
    - Add `-n` to exclude empty files
    - Add `-f` to omit the first file in each set of matches
    - Add `-1` to list each set of matches on a single line
    - Add `-S` to show the size of each duplicate file
    - Add `-d` to delete duplicates during execution
    - Add `-A` to ignore hidden files

### Inox

- Open a webpage in a borderless window: `inox --app=<url>`
- Open a webpage in the regular browser window: `inox <url>`

### Waterfox

- Open a webpage in a new window: `waterfox --new-window <url>`
- Open a webpage in a new tab: `waterfox --new-tab <url>`
- Search for a specific term: `waterfox --search <term>`

### Jekyll

- Start a server and monitor it for changes (useful for development): `jekyll serve`
- Start a server and detach it from the current shell: `jekyll serve --detach`
- Terminate a jekyll server that was detached from the shell: `kill -9 <pid>`
- Terminate all jekyll servers: `pkill -f jekyll`

Note that you can run multiple servers on different ports through Jekyll and other software.

### Crystal

- Build and run the program directly: `crystal <file>`
- Compile the program to binary: `crystal build <file>`
    - Add `--progress` or `-p` to show build progress
    - Add `--release` when you're building the release version (takes longer)
    - Add `--no-debug` to increase the build speed (useful for dev builds)
    - Add `-o` to specify the location of the output file

### LaTeX

- Make a pdf of your document: `pdflatex <file>`
    - Add `-output-directory <dir>` to specify the location for build files (`.aux`, `.pdf`, `.log`, etc.)
        - The directory `<dir>` must exist before you can write to it
    - Note that all `pdflatex` options must come before specifying `<file>`

### Xclip

**Using the X clipboard**

- Copy the result of any command to the X clipboard: `command | xclip`
    - This is particularly useful for commands like `fzf`, where you want to search for a specific file then do something with it
- Paste the results from the X clipboard: `xclip -o`

**Using the global clipboard**

- Copy a file to the global clipboard: `xclip -sel clip < filename.txt` **OR** `cat filename.txt | xclip -sel clip`
    - Note that `-sel` is shorthand for `-selection` and that `clip` is shorthand for `clipboard`
- Copy the result of any command to the global clipboard: `command | xclip -sel clip`
- Paste the results from the global clipboard: `xclip -o -sel clip`

### Secure Shell

- Make a new 4096-bit RSA key: `ssh-keygen -t rsa -b 4096 [-C <comment>]`
    - Note that `id_rsa` is your private key and `id_rsa.pub` is your public key
- Add your new key to SSH: `ssh-add ~/.ssh/id_rssa`
- Copy your public key: `xclip -sel clip < ~/.ssh/id_rsa.pub`
- Add a location to your known hosts: `ssh -T <location>`
    - For example, if you wanted to use SSH with GitHub, you would add the location `git@gitlab.com`
- Start the SSH agent: `eval "$(ssh-agent -s)"`

Note that a git repository must be cloned with SSH if you want to use SSH with it.

### Dealing with Archives

- Zip all files in a directotry: `zip -r <zip_name> <directory>`
- View the contents of rar files: `unrar lb <files>`
- Extract the contents of rar files: `unrar x <files>`
- Extract the contents of zip files: `unzip <files>`
- Extract the contents of a tgz file: `tar -xvzf file.tgz`
- Extract any type of archiving algorithm: `extract <filename>`

**Note**: When using `unrar` or `unzip` to extract multiple files (with wildcards), you must first escape the `*` to `\*`.

### Opening Things

Note that the preferred way to open things is with the `open` function; however, sometimes it is necessary to use these commands if, for example, you're loading an entire directory.

- Open a video or multiple videos in a playlist: `mpv <files/dir>`
- Open an image or multiple images: `feh <files/dir>`
    - Add `-r` to recursively iterate through all subdirectories
    - Add `-z` to randomize the order of the images
    - Use `-l` to enable list mode, an easy way to see various details about images
    - Use `-t` to enable thumbnail mode, a quick and easy way to see all the images in a directory
        - Add `-E <pixels>` to set the thumbnail height
        - Add `-y <pixels>` to set the thumbnail width
        - Note that generating thumbnails takes time (i.e. don't use with large file sizes)

### Firejail

Use `firejail` to sandbox a program or other piece of software. This ensures that the program does not have access to your entire file system since it runs in a restricted environment.

- Run a program in firejail with its default profile (if it exists): `firejail <program>`
- Use firejail by default for all programs that have profiles: `firecfg`
    - List all the programs that use firejail by default: `firecfg --list`
    - Remove all symbolic links to firejail: `firecfg --clean`
- Verify that firejail is being used for a particular program: `firejail --list`

### Pacman

Although the examples below use `pacman`, they apply for `yay` as well.

- Install packages: `pacman -S <packages>`
- Remove packages (including dependencies no longer needed): `pacman -Rs <packages>`
- Update all packages: `pacman -Syu`
- Search for a specific package: `pacman -Ss <package>`
- List all installed packages: `pacman -Q`
    - List all the packages installed as dependencies: `pacman -Qd`
    - List all self-installed packages (i.e. from the AUR): `pacman -Qm`
- Display information about a specific package: `pacman -Qi <package>`
- List all the files owned by a specific package: `pacman -Ql <package>`
- Install a package from a local file: `pacman -U /path/to/pkg.ar.gz`

Note that if you ever get 404s with `pacman` or `yay`, you need to update your local database to the new download locations with `-Syu` first.

#### Yay-specific Commands

- Remove unneeded dependencies: `yay -Cd`
- Show statistics about installed packages: `yay -Qstats`

#### Other Pacman Variants

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

