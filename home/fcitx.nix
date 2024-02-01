{ config, ... }:

{
  xdg.dataFile = {
    "fcitx5/themes/base16/theme.conf".text = with config.lib.stylix.colors; /* ini */ ''
      [Metadata]
      Name=base16
      Version=0.1
      ScaleWithDPI=True

      [InputPanel]
      Font=Noto Sans CJK JP 16
      NormalColor=#${base05}
      HighlightCandidateColor=#${base05}
      HighlightColor=#${base05}
      HighlightBackgroundColor=#${base01}
      Spacing=6

      [InputPanel/TextMargin]
      Left=5
      Right=5
      Top=5
      Bottom=5

      [InputPanel/ContentMargin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [InputPanel/Background/Margin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [InputPanel/Background]
      Color=#${base01}

      [InputPanel/Highlight]
      Color=#${base02}

      [InputPanel/Highlight/Margin]
      Left=5
      Right=7
      Top=5
      Bottom=5

      [Menu]
      NormalColor=#${base01}

      [Menu/Background]
      Color=#${base01}

      [Menu/Highlight]
      Color=#${base02}

      [Menu/Separator]
      Color=#${base02}

      [Menu/Background/Margin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [Menu/ContentMargin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [Menu/Highlight/Margin]
      Left=5
      Right=5
      Top=5
      Bottom=5

      [Menu/TextMargin]
      Left=5
      Right=5
      Top=5
      Bottom=5
    '';
  };

  xdg.configFile = {
    "mozc/ibus_config.textproto" = {
      force = true;
      text = /* config */ ''
        engines {
          name : "mozc-jp"
          longname : "Mozc"
          layout : "default"
          layout_variant : ""
          layout_option : ""
          rank : 80
        }
        active_on_launch: True
      '';
    };

    "fcitx5/config" = {
      force = true;
      text = /* ini */ ''
        [Hotkey]
        # Enumerate when press trigger key repeatedly
        EnumerateWithTriggerKeys=True
        # Temporally switch between first and current Input Method
        AltTriggerKeys=
        # Enumerate Input Method Forward
        EnumerateForwardKeys=
        # Enumerate Input Method Backward
        EnumerateBackwardKeys=
        # Skip first input method while enumerating
        EnumerateSkipFirst=False
        # Enumerate Input Method Group Forward
        EnumerateGroupForwardKeys=
        # Enumerate Input Method Group Backward
        EnumerateGroupBackwardKeys=
        # Activate Input Method
        ActivateKeys=
        # Deactivate Input Method
        DeactivateKeys=

        [Hotkey/TriggerKeys]
        0=Super+space

        [Hotkey/PrevPage]
        0=Up

        [Hotkey/NextPage]
        0=Down

        [Hotkey/PrevCandidate]
        0=Shift+Tab

        [Hotkey/NextCandidate]
        0=Tab

        [Hotkey/TogglePreedit]
        0=Control+Alt+P

        [Behavior]
        # Active By Default
        ActiveByDefault=False
        # Share Input State
        ShareInputState=No
        # Show preedit in application
        PreeditEnabledByDefault=True
        # Show Input Method Information when switch input method
        ShowInputMethodInformation=True
        # Show Input Method Information when changing focus
        showInputMethodInformationWhenFocusIn=False
        # Show compact input method information
        CompactInputMethodInformation=True
        # Show first input method information
        ShowFirstInputMethodInformation=True
        # Default page size
        DefaultPageSize=5
        # Override Xkb Option
        OverrideXkbOption=False
        # Custom Xkb Option
        CustomXkbOption=
        # Force Enabled Addons
        EnabledAddons=
        # Force Disabled Addons
        DisabledAddons=
        # Preload input method to be used by default
        PreloadInputMethod=True
      '';
    };

    "fcitx5/profile" = {
      force = true;
      text = /* ini */ ''
        [Groups/0]
        # Group Name
        Name="Group 1"
        # Layout
        Default Layout=us
        # Default Input Method
        DefaultIM=mozc

        [Groups/0/Items/0]
        # Name
        Name=keyboard-us
        # Layout
        Layout=

        [Groups/0/Items/1]
        # Name
        Name=mozc
        # Layout
        Layout=

        [GroupOrder]
        0="Group 1"
      '';
    };

    "fcitx5/conf/classicui.conf" = with config.lib.stylix.colors; {
      force = true;
      text = /* ini */ ''
        # Vertical Candidate List
        Vertical Candidate List=False
        # Use Per Screen DPI
        PerScreenDPI=True
        # Use mouse wheel to go to prev or next page
        WheelForPaging=True
        # Font
        Font="Noto Sans CJK JP 16"
        # Menu Font
        MenuFont="Noto Sans CJK JP 16"
        # Tray Font
        TrayFont="Noto Sans CJK JP Medium 16"
        # Tray Label Outline Color
        TrayOutlineColor=#${base02}
        # Tray Label Text Color
        TrayTextColor=#${base05}
        # Prefer Text Icon
        PreferTextIcon=False
        # Show Layout Name In Icon
        ShowLayoutNameInIcon=True
        # Use input method language to display text
        UseInputMethodLangaugeToDisplayText=True
        # Theme
        Theme=base16
      '';
    };

    "fcitx5/conf/clipboard.conf" = {
      force = true;
      text = /* ini */ ''
        # Trigger Key
        TriggerKey=
        # Paste Primary
        PastePrimaryKey=
        # Number of entries
        Number of entries=5
      '';
    };

    "fcitx5/conf/mozc.conf" = {
      force = true;
      text = /* ini */ ''
        # Initial Mode
        InitialMode=Hiragana
        # Vertical candidate list
        Vertical=True
        # Expand Usage (Requires vertical candidate list)
        ExpandMode="On Focus"
        # Fix embedded preedit cursor at the beginning of the preedit
        PreeditCursorPositionAtBeginning=False
        # Hotkey to expand usage
        ExpandKey=Control+Alt+H
      '';
    };

    "fcitx5/conf/notifications.conf" = {
      force = true;
      text = "HiddenNotifications=";
    };

    "fcitx5/conf/unicode.conf" = {
      force = true;
      text = "TriggerKey=";
    };
  };
}
