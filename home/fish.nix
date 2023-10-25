{ pkgs, ... }:

{
  xdg.configFile."fish/config.fish".text = /* fish */ ''
    set -U fish_greeting ""

    export PATH="$HOME/.deno/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.go/bin:$PATH"
    export GOPATH="$HOME/.go"
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    export TERMCMD="kitty --single-instance"
    export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS"
    export DIRENV_LOG_FORMAT=""

    # Required to make gpg-agent work in cases like git commit
    export GPG_TTY=(tty)

    # Add color to man pages
    set -x -U LESS_TERMCAP_md (printf "\e[01;31m")
    set -x -U LESS_TERMCAP_me (printf "\e[0m")
    set -x -U LESS_TERMCAP_se (printf "\e[0m")
    set -x -U LESS_TERMCAP_so (printf "\e[01;44;30m")
    set -x -U LESS_TERMCAP_ue (printf "\e[0m")
    set -x -U LESS_TERMCAP_us (printf "\e[01;32m")
    set -x -U MANROFFOPT "-c"

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

    # Always use kitty ssh since it's our default terminal
    if string match -qe -- "/dev/pts/" (tty)
        alias ssh="kitty +kitten ssh"
    end
  '';
}
