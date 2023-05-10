# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2022 Donovan Glover

set -U fish_greeting ""

export VISUAL="nvim"
export EDITOR="nvim"
export PATH="$HOME/.deno/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.go/bin:$PATH"
export NODE_OPTIONS="--max_old_space_size=16384"
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export GOPATH="$HOME/.go"
export TERMCMD="kitty --single-instance"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Use rg instead of ag / ack / grep for fzf (much faster)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --color=16'

# Required to make gpg-agent work in cases like git commit
export GPG_TTY=(tty)

# Add color to man pages
set -x -U LESS_TERMCAP_md (printf "\e[01;31m")
set -x -U LESS_TERMCAP_me (printf "\e[0m")
set -x -U LESS_TERMCAP_se (printf "\e[0m")
set -x -U LESS_TERMCAP_so (printf "\e[01;44;30m")
set -x -U LESS_TERMCAP_ue (printf "\e[0m")
set -x -U LESS_TERMCAP_us (printf "\e[01;32m")

# Always use the default keybindings in fish
fish_default_key_bindings

# Convert unnecessarily large wav files to flac
function wav2flac
    set ORIGINAL_SIZE (du -hs | cut -f1)

    fd -e wav -x ffmpeg -i "{}" -loglevel quiet -stats "{.}.flac"
    fd -e wav -X trash

    set NEW_SIZE (du -hs | cut -f1)

    echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
end

# Convert wav/flac to opus
function opus
    set ORIGINAL_SIZE (du -hs | cut -f1)

    fd -e wav -e flac -x ffmpeg -i "{}" -c:a libopus -b:a 128K -loglevel quiet -stats "{.}.opus"
    fd -e wav -e flac -X rm -I

    set NEW_SIZE (du -hs | cut -f1)

    echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
end

# Don't show ripgrep results for very long lines (e.g. minified files)
alias rg="rg --max-columns=2000"

# Use exa as a drop-in replacement for ls and tree (faster, more colors, etc.)
alias ls="exa --group-directories-first -I 'lost+found'"
alias tree="exa --group-directories-first --long --tree -I 'node_modules|.git|public|lost+found'"

# Prevent accidents
alias mv="mv -i"

# Always use kitty ssh since it's our default terminal
if string match -qe -- "/dev/pts/" (tty)
    alias ssh="kitty +kitten ssh"
end

# Source wal colors as needed
if status is-interactive; and test "$TERM" = "xterm-256color"
    cat ~/.cache/wal/sequences
end

if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec Hyprland
    end
end
