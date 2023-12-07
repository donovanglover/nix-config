{ pkgs, ... }:

{
  home.packages = with pkgs; [ eww-wayland ];

  xdg.configFile."eww/eww.yuck".text = /* yuck */ ''
    (defwidget icons []
      (box :orientation "h" :spacing 32
        (icon :img "user-desktop" :exec "/home/user")
        (icon :img "folder-download" :exec "/home/user/ダウンロード")
        (icon :img "folder-documents" :exec "/home/user/ドキュメント")
        (icon :img "folder-music" :exec "/home/user/音楽")
        (icon :img "folder-pictures" :exec "/home/user/画像")
        (icon :img "folder-videos" :exec "/home/user/ビデオ")))

    (defwidget icon [img exec]
      (eventbox :cursor "pointer" :onclick "lnch thunar ''${exec}" :tooltip "''${exec}"
        (image :path "/run/current-system/sw/share/eww/Candy-Icons/''${img}.png" :image-width 128)))

    (defwindow desktop-icons
      :monitor 0
      :geometry (geometry :x "32px" :anchor "bottom center"
                          :y "8px")
      :stacking "bg"
      (icons))

    (defpoll time :interval "1s"
      "date '+%H:%M'")

    (defwindow overlay
      :monitor 0
      :geometry (geometry :y "4px" :x "8px" :anchor "bottom right")
      :stacking "fg"
      time)
  '';

  xdg.configFile."eww/eww.scss".text = /* scss */ ''
    img {
      all: unset;
    }

    .desktop-icons {
      all: unset;
    }

    .overlay {
      background: transparent;
      color: #f8f8f2;
      font-weight: bold;
      text-shadow: 0 0 0.075em #272822;
      font-size: 32px;
      opacity: 0.1;
    }
  '';
}
