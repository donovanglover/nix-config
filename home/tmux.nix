{
  programs.tmux = {
    enable = true;
    mouse = true;

    keyMode = "vi";

    extraConfig = # fish
      ''
        set -sg escape-time 0

        set -g renumber-windows on
        set -g status-right ""
        set -g status-left ""
        set -g status-justify centre
        set -g status-bg black
        set -g status-fg white
        set -g default-terminal "tmux-256color"
      '';
  };
}
