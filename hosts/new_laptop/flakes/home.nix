{ config, pkgs,  ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.dunst}/bin/dunst &
  '';
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tesla";
  home.homeDirectory = "/home/tesla";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

    #imports = [
    #  ./modules/hyprland.nix {inherit inputs;}
    #];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tesla/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zed-editor = {
        enable = true;
        extensions = ["nix" "toml" "elixir" "make"];

        ## everything inside of these brackets are Zed options.
        userSettings = {

            assistant = {
                enabled = true;
                version = "2";
                default_open_ai_model = null;
                ### PROVIDER OPTIONS
                ### zed.dev models { claude-3-5-sonnet-latest# } requires github connected
                ### anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
                ### copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
                default_model = {
                    provider = "copilot_chat";
                    model = "gpt-4o";
                };

                inline_alternatives = [{
                    provider = "copilot_chat";
                    model = "gpt-4o";
                }];
            };

         #   node = {
         #       path = lib.getExe pkgs.nodejs;
         #       npm_path = lib.getExe' pkgs.nodejs "npm";
         #   };

            hour_format = "hour24";
            auto_update = false;
           # terminal = {
           #     alternate_scroll = "off";
           #     blinking = "off";
           #     copy_on_select = false;
           #     dock = "bottom";
           #     detect_venv = {
           #         on = {
           #             directories = [".env" "env" ".venv" "venv"];
           #             activate_script = "default";
           #         };
           #     };
           #     env = {
           #         TERM = "alacritty";
           #     };
           #     font_family = "FiraCode Nerd Font";
           #     font_features = null;
           #     font_size = null;
           #     line_height = "comfortable";
           #     option_as_meta = false;
           #     button = false;
           #     shell = "system";
           #     #{
           #     #                    program = "zsh";
           #     #};
           #     toolbar = {
           #         title = true;
           #     };
           #     working_directory = "current_project_directory";
           # };



          #  lsp = {
          #      rust-analyzer = {

          #          binary = {
          #              #                        path = lib.getExe pkgs.rust-analyzer;
          #              path_lookup = true;
          #          };
          #      };
          #      nix = {
          #          binary = {
          #              path_lookup = true;
          #          };
          #      };

          #      elixir-ls = {
          #          binary = {
          #              path_lookup = true;
          #          };
          #          settings = {
          #              dialyzerEnabled = true;
          #          };
          #      };
          #  };


          #  languages = {
          #      "Elixir" = {
          #          language_servers = ["!lexical" "elixir-ls" "!next-ls"];
          #          format_on_save = {
          #              external = {
          #                  command = "mix";
          #                  arguments = ["format" "--stdin-filename" "{buffer_path}" "-"];
          #              };
          #          };
          #      };
          #      "HEEX" = {
          #          language_servers = ["!lexical" "elixir-ls" "!next-ls"];
          #          format_on_save = {
          #              external = {
          #                  command = "mix";
          #                  arguments = ["format" "--stdin-filename" "{buffer_path}" "-"];
          #              };
          #          };
          #      };
          #  };

            vim_mode = true;
            ## tell zed to use direnv and direnv can use a flake.nix enviroment.
            load_direnv = "shell_hook";
            base_keymap = "VSCode";
            theme = {
                mode = "system";
                light = "One Light";
                dark = "One Dark";
            };
            show_whitespaces = "all" ;
            ui_font_size = 16;
            buffer_font_size = 16;

        };

    };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    #package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    settings = {
      "$terminal" = "kitty";
      "$mod" = "SUPER";
      "$menu" = "rofi -show drun";

      monitor = [
        "eDP-1,preferred,auto,1.5"
        ",preferred,auto,1"
      ];

      general = {
        gaps_in = 3.25;
        gaps_out = 7.5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      input = {
        kb_layout = "us";
        follow_mouse = true;
        touchpad = {
          natural_scroll = true;
        };
        accel_profile = "flat";
        sensitivity = 0;
      };

      decoration = {
        rounding = 7;
        active_opacity = 0.9;
        inactive_opacity = 0.8;
        fullscreen_opacity = 0.9;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 14;
          passes = 4;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
          ignore_opacity = false;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      cursor = {
        enable_hyprcursor = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      bind = [
        #basic binds
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, S, exec, $menu"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, X, exec, hyprlock"

        #focus changes
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        "$mod ALT, left, resizeactive, 10 0"
        "$mod ALT, right, resizeactive, -10 0"
        "$mod ALT, up, resizeactive, 0 -10"
        "$mod ALT, down, resizeactive, 0 10"

        # Switch workspaces with mainMod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, F, togglespecialworkspace, magic"
        "$mod SHIFT, F, movetoworkspace, special:magic"

        #special workspace stuff
        ",XF86AudioMute, exec,  pamixer --sink 0 -t"
        ",XF86KbdLightOnOff, exec, brightnessctl -d asus::kbd_backlight set 0"

        #screenshots
        ",PRINT, exec, hyprshot -m window"
        "$mod, PRINT, exec, hyprshot -m output"
        "$shiftMod, PRINT, exec, hyprshot -m region"
      ];

      bindl = [
        ", switch:Lid Switch, exec, systemctl suspend "
        "$mod CTRL, up, exec, hyprctl --batch 'keyword monitor eDP-1,preferred,0x0,1.5,transform,0 ; keyword device[elan9008:00-04f3:4359]:transform 0 ; keyword input:tablet:transform 0'"
        "$mod CTRL, left, exec, hyprctl --batch 'keyword monitor eDP-1,preferred,0x0,1.5,transform,1 ; keyword device[elan9008:00-04f3:4359]:transform 1 ; keyword input:tablet:transform 1'"
        "$mod CTRL, down, exec, hyprctl --batch 'keyword monitor eDP-1,preferred,0x0,1.5,transform,2 ; keyword device[elan9008:00-04f3:4359]:transform 2 ; keyword input:tablet:transform 2'"
        "$mod CTRL, right, exec, hyprctl --batch 'keyword monitor eDP-1,preferred,0x0,1.5,transform,3 ; keyword device[elan9008:00-04f3:4359]:transform 3 ; keyword input:tablet:transform 3'"
      ];

      binde = [
        ",XF86AudioLowerVolume, exec, pamixer -d 10"
        ",XF86AudioRaiseVolume, exec, pamixer -i 10"
        ",XF86MonBrightnessDown, exec, brightnessctl s 1%-"
        ",XF86MonBrightnessUp, exec, brightnessctl s +1%"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      env = [
        "NIXOS_OZONE_WL_1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORM,wayland"
        "SDL_VIDEODRIVER,wayland"
        "GDK_BACKEND,wayland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "AQ_DRM_DEVICES,/dev/dri/card1"
        "AQ_NO_HARDWARE_CURSORS,1"
      ];

      exec-once = [
        "swww img ~/Pictures/wp.jpg"
        "iio-hyprland --monitor=eDP-1"
        "waybar"
        "hypridle"
      ];
    };

    systemd = {
      enable = true;
    };
  };
}
