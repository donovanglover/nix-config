{ pkgs, ... }:

{
  home.packages = with pkgs; [ cmus ];

  xdg.configFile."cmus/rc".text = /* cmusrc */ ''
    colorscheme stylix
  '';

  xdg.configFile."cmus/stylix.theme".text = /* cmusrc */ ''
    set color_win_fg=default
    set color_win_bg=default
    set color_statusline_fg=2
    set color_statusline_bg=default
    set color_titleline_fg=2
    set color_titleline_bg=default
    set color_win_title_fg=2
    set color_win_title_bg=default
    set color_win_title_attr=bold
    set color_cmdline_bg=default
    set color_cmdline_fg=default
    set color_error=1
    set color_info=6
    set color_separator=16
    set color_win_cur=13
    set color_win_cur_sel_bg=default
    set color_win_cur_sel_fg=3
    set color_win_cur_sel_attr=underline
    set color_win_inactive_cur_sel_bg=default
    set color_win_inactive_cur_sel_fg=13
    set color_win_sel_bg=default
    set color_win_sel_fg=3
    set color_win_sel_attr=underline
    set color_win_inactive_sel_bg=default
    set color_win_inactive_sel_fg=1
    set color_win_dir=default
  '';
}

