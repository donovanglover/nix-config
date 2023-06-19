{
  xdg.configFile."hyprland-autoname-workspaces/config.toml".text = /* toml */ ''
    version = "1.1.0"

    [class]
    kitty = "端\n末"
    thunar = "フ\nァ\nイ\nル"
    librewolf = "ウ\nェ\nブ"
    "VirtualBox Machine" = "ブ\nイ\nエ\nム"
    "VirtualBox Manager" = "仮\n想\n機\n械"
    anki = "暗\n記"
    Logseq = "知\n識\n管\n理"
    mullvadbrowser = "秘\n密"
    "Signal Beta" = "メ\nッ\nセ\nー\nジ"
    srb2 = "ソ\nニ\nッ\nク"
    DEFAULT = "〜"

    [title_in_class."(kitty)"]
    "(?i)nvim" = "ヴ\nィ\nム"
    "(?i)ncmpcpp" = "音\n楽"

    [workspaces_name]
    1 = "一"
    2 = "二"
    3 = "三"
    4 = "四"
    5 = "五"
    6 = "六"
    7 = "七"
    8 = "八"
    9 = "九"
    10 = "十"

    [exclude]
    "(?i)fcitx" = ".*"

    [format]
    dedup = false
    dedup_inactive_fullscreen = false
    delim = "<span size='4pt'>\n</span>"

    workspace = "<span size='0.001pt'>{id}</span>{name}{delim}{clients}"
    workspace_empty = "<span size='0.001pt'>{id}</span>{name}"

    client = "{delim}<span color='#a59f85' font-weight='300'>{icon}</span>"

    client_active = "<span font-weight='700'>{icon}</span>"
    client_fullscreen = "{delim}<span color='#fd971f'>{icon}</span>"
  '';
}
