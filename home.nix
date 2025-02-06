{ config, pkgs, ... }:

let
  # For GNOME Wallpaper
  WALLPAPER_IMAGE = ./files/wallpaper.png;
#  WALLPAPER_IMAGE = pkgs.fetchurl {
#    url = "file:///home/elias/nixos-config/files/wallpaper.png";
#    url = "https://github.com/tootbrute/nixos-tux/blob/47a5272ccb29fec1ef028c2b5d6a3c76f3b004cf/files/wallpaper.png";
    # replace this with the SHA256 hash of the image file

in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "elias";
  home.homeDirectory = "/home/elias";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # core apps
    nextcloud-client
    keepassxc
    iotas
    obsidian

  ];

  # Environment
  home.sessionVariables = {
    EDITOR = "nano";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  # Basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Tootbrute";
    userEmail = "tootbrute@tutamail.com";
    extraConfig = {
    init.defaultBranch = "main";
    };
  };

  # Starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";

    font = {
      normal = {
	family = "JetBrains Mono Nerd Font";
	style = "Regular";
      };
      bold = {
	family = "JetBrains Mono Nerd Font";
	style = "Bold";
      };
      italic = {
	family = "JetBrains Mono Nerd Font";
	style = "Italic";
      };
  };

      font = {
        size = 14;
      };

      window.dimensions = {
        lines = 100;
        columns = 230;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # GNOME desktop settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  # Wallpaper originally from https://github.com/NixOS/nixos-artwork/
  "org/gnome/desktop/background" = {
        "picture-uri" = "file://${WALLPAPER_IMAGE}";
    };
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
  };

  programs.firefox.enable = true;
  # can find more options later
  # https://home-manager-options.extranix.com/?query=programs.firefox&release=release-24.05

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
