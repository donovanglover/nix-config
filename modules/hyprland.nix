{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  i18n.inputMethod = {
    enabled = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [ fcitx5-mozc ];
      waylandFrontend = true;
    };
  };

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
  ];

  services.greetd = {
    enable = true;
    restart = false;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };

      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "user";
      };
    };
  };

  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      maple-mono
      font-awesome
      nerdfonts
      kanji-stroke-order-font
      liberation_ttf
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
        monospace = [ "Noto Sans Mono CJK JP" "Noto Sans Mono" ];
      };

      allowBitmaps = false;
    };
  };
}
