{ config, pkgs, ... }:

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
    settings = {
      env = [
        "AQ_NO_MODIFIERS,1"
        "WLR_NO_HARDWARE_CURSORS=1"
        "WLR_RENDERER_ALLOW_SOFTWARE=1"
      ];
    };
  };
}
