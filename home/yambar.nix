{ config, ... }:

let
  inherit (config.home) homeDirectory;

  discharging = [
    {
      ramp = {
        tag = "capacity";
        items = [
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
          {
            string = {
              text = "";
            };
          }
        ];
      };
    }

    {
      string = {
        text = "{capacity}% {estimate}";
        left-margin = margin;
      };
    }
  ];

  margin = 10;
in
{
  programs.yambar = {
    enable = true;
    settings = {

      bar = {
        height = 30;
        location = "top";
        background = "282a36e6";
        foreground = "ffffffbb";
        font = "Noto Sans CJK JP:Bold:size=13,Font Awesome 6 Free:style=solid:size=13";
        right-margin = margin;
        layer = "bottom";
        left = [
          {
            script = {
              path = "${homeDirectory}/.config/yambar/hyprland.sh";
              args = [ ];
              content = {
                string = {
                  on-click = {
                    left = "sh -c 'hyprctl dispatch workspace e+1'";
                    right = "sh -c 'hyprctl dispatch workspace e-1'";
                    middle = "sh -c 'hyprctl dispatch workspace empty'";
                  };

                  text = "{hypr_ws}";
                  left-margin = margin;
                };
              };
            };
          }
        ];

        center = [
          {
            script = {
              path = "${homeDirectory}/.config/yambar/title.sh";
              args = [ ];
              content = {
                string = {
                  on-click = {
                    left = "sh -c '~/.config/hypr/swapmaster.sh'";
                    right = "sh -c 'hyprctl dispatch movetoworkspace special'";
                    middle = "sh -c 'hyprctl dispatch killactive'";
                  };

                  text = "{title}";
                  max = 90;
                };
              };
            };
          }
        ];

        right = [
          {
            battery = {
              name = "BAT0";

              content = {
                map = {
                  conditions = {
                    "state == unknown" = discharging;
                    "state == discharging" = discharging;

                    "state == charging" = [
                      {
                        string = {
                          text = "";
                        };
                      }

                      {
                        string = {
                          text = "{capacity}% {estimate}";
                        };
                      }

                    ];
                    "state == full" = [
                      {
                        string = {
                          text = "";
                        };
                      }

                      {
                        string = {
                          text = " {capacity}%";
                        };
                      }
                    ];
                    "state == \"not charging\"" = [
                      {
                        ramp = {
                          tag = "capacity";
                          items = [
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                            {
                              string = {
                                text = "";
                              };
                            }
                          ];
                        };
                      }

                      {
                        string = {
                          text = "{capacity}%";
                        };
                      }
                    ];
                  };
                };
              };
            };
          }

          {
            backlight = {
              name = "amdgpu_bl0";
              content = {
                string = {
                  text = "  {brightness}/255";
                  left-margin = margin;
                };
              };
            };
          }

          {
            script = {
              path = "${homeDirectory}/.config/yambar/pipewire.sh";
              args = [ ];
              content = {
                string = {
                  text = "{pipewire}";
                  left-margin = margin;
                };
              };
            };
          }

          {
            clock = {
              time-format = "%H:%M %Z";
              content = [
                {
                  string = {
                    text = "";
                    right-margin = 5;
                    left-margin = margin;
                  };
                }
                {
                  string = {
                    text = "{date}";
                    on-click = "yad --calendar --title '今日は何の日'";
                  };
                }
                {
                  string = {
                    text = "";
                    right-margin = 5;
                    left-margin = margin;
                  };
                }
                {
                  string = {
                    text = "{time}";
                  };
                }
              ];
            };
          }

          {
            label = {
              content = {
                string = {
                  on-click = "sh -c 'rofi -show'";
                  text = "";
                  left-margin = margin;
                };
              };
            };
          }
        ];
      };
    };
  };
}
