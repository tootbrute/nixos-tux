{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "elias";
  home.homeDirectory = "/home/elias";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
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
        lines = 50;
        columns = 250;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  #GNOME desktop settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
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
