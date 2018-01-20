alias i="pacman --noconfirm -S"

i elixir        # Install elixir, our functional language of choice
i ruby          # Install ruby, another programming language of choice
i go            # Install go, another dependency to build other packages
i php           # Install php, used when we need to test php stuff
i php-cgi       # Install php-cgi, used to make php work with local servers
i lua           # Install lua, in case we ever want to use it
i jdk-9-openjdk # Install java, if for some reason we need to use it
i nodejs        # Install node.js, used as a javascript runtime environment

i pygmentize    # Install pygmentize, used as a variant of cat with syntax highlighting
i ctags         # Install ctags, used with vim to create tags for formal languages
i shards        # Install shards, a package manager for crystal
i npm           # Install npm, a package manager for node.js

i ispell        # Install ispell, used to spell check files

i alsa-utils    # Install alsa-utils, required to make the sound system work

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
