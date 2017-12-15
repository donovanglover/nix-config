##################################################################################
#
#    New Start: A modern Arch workflow built with an emphasis on functionality.
#    Copyright (C) 2017 Donovan Glover
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
##################################################################################

alias i="pacman --noconfirm -S"

i zsh                       # Install zsh, our shell of choice
i grml-zsh-config           # Install grml, sane defaults to make zsh more functional
i zsh-syntax-highlighting   # Install syntax highlighting for colorful shell commands

i vim           # Install vim, our text editor of choice
i git           # Install git, our version control system of choice
i tree          # Install tree, used to show the contents of entire directories
i wget          # Install wget, used for downloading files from websites
i httpie        # Install httpie, used to manipulate HTTP requests
i diff-so-fancy # Install diff-so-fancy, a nicer git diff
i ntp           # Install ntp, used to sync the system time with one on the internet

i zip           # Install zip, used to zip files
i unzip         # Install unzip, used to unzip files
i p7zip         # Install p7zip, used to extract 7z files
i unrar         # Install unrar, used to extract rar files

i openvpn       # Install openvpn, used to connect to VPNs
i openssh       # Install openssh, used to connect via SSH

i elixir        # Install elixir, our functional language of choice
i ruby          # Install ruby, another programming language of choice
i rust          # Install rust, a dependency to build other packages
i go            # Install go, another dependency to build other packages
i php           # Install php, used when we need to test php stuff
i php-cgi       # Install php-cgi, used to make php work with local servers
i lua           # Install lua, in case we ever want to use it
i jdk-9-openjdk # Install java, if for some reason we need to use it
i crystal       # Install crystal, a ruby-like language with a binary compiler
i nodejs        # Install node.js, used as a javascript runtime environment

i jq            # Install jq, used to manipulate JSON in the terminal
i tmux          # Install tmux, used to run terminal programs in the background
i fzf           # Install fzf, used to easily search for things in vim
i pygmentize    # Install pygmentize, used as a variant of cat with syntax highlighting
i firejail      # Install firejail, a simple and straightforward way to sandbox programs
i ctags         # Install ctags, used with vim to create tags for formal languages
i shards        # Install shards, a package manager for crystal
i npm           # Install npm, a package manager for node.js

i the_silver_searcher           # Install ag, used to easily search through files
i fdupes                        # Install fdupes, used to quickly find duplicate files

i tig           # Install tig, used to browse git commits
i ncdu          # Install ncdu, used to easily see disk usage
i w3m           # Install w3m, our text-based web browser of choice
i irssi         # Install irssi, our IRC client of choice
i profanity     # Install profanity, our XMPP client of choice
i ispell        # Install ispell, used to spell check files

i virtualbox-guest-modules-arch # Install Arch-specific VirtualBox modules
i virtualbox-guest-utils        # Install the core VirtualBox functionality

i xorg-server   # Install xorg-server, used to manage graphical elements on the display
i xorg-xinit    # Install xorg-xinit, allowing us to start the X server with .xinitrc
i xclip         # Install xclip, our clipboard manager of choice
i xdo           # Install xdo, used to show and hide windows such as polybar
i xdotool       # Install xdotool, used to make forward search work with zathura and vimtex
i xorg-xprop    # Install xorg-xprop, used to determine whether or not a window is visible

i libmad        # Install libmad, needed so that we can recognize and process mp3 files
i alsa-utils    # Install alsa-utils, required to make the sound system work

i termite       # Install termite, our terminal of choice (with true color support)
i compton       # Install compton, our compositor of choice

i ranger        # Install ranger, our file explorer of choice
i feh           # Install feh, a quick and simple way to view images
i cmus          # Install cmus, our music player of choice
i mpv           # Install mpv, a no-bloat content-first video player

i mps-youtube   # Install mps-youtube, allowing us to use youtube straight from the terminal
i youtube-dl    # Install youtube-dl, a straightforward way to download youtube videos

i zathura           # Install zathura, our document viewer of choice
i zathura-djvu      # Install zathura-djvu, enabling djvu support for zathura
i zathura-pdf-mupdf # Install zathura-pdf-mupdf, enabling pdf support for zathura

i texlive-core          # Install texlive-core, the basic functionality required for TeX and LaTeX
i texlive-science       # Install texlive-science, allowing us to easily use mathematics with TeX
i texlive-pictures      # Install texlive-pictures, used to make graphics with TeX
i texlive-publishers    # Install texlive-publishers, a collection of publisher formats
i texlive-latexextra    # Install texlive-latexextra, giving us more LaTeX support
i texlive-humanities    # Install texliive-humanities, an easier way to write text
i texlive-fontsextra    # Install texlive-fontsextra, used for font variety
i texlive-formatsextra  # Install texlive-formatsextra, additional support for TeX formats
i texlive-bibtexextra   # Install texlive-bibtexextra, more features for BibTeX

i minted            # Install minted, used for syntax highlighting in LaTeX

i ttf-hack          # Install Hack, our primary terminal font of choice
i ttf-fira-mono     # Install Fira Mono, our secondary terminal font of choice
i noto-fonts        # Install the Noto fonts, used for everything else
