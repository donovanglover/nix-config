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

