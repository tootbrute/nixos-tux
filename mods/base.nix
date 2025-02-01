# base.nix
# configuration for all my computers

{ pkgs, config, ... }:

{
  imports =
    [ 
      ./gnome.nix
      ./systemd.nix
      ./fonts.nix
      ./intel-gpu.nix
    ];

  # Legacy boot - MOVE H
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.luks.devices.root = {
    device = "/dev/disk/by-uuid/4b2c5310-0dc4-4586-86b8-a6b9eba5b01a";
    preLVM = true;
  };
  boot.loader.grub.configurationLimit = 10; 

  # Clear /tmp during boot - MOVE H
  boot.tmp.cleanOnBoot = true;

  # Housekeeping: Garbage collection
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

  # Increase buffer size for NixOS-Rebuild
  nix.settings.download-buffer-size = "2G";

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Disable sudo password for the wheel group
  security.sudo.wheelNeedsPassword = false;

  # Set your time zone.
  time.timeZone = "Asia/Taipei";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "en_CA.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" "zh_TW.UTF-8/UTF-8" ];

  i18n.extraLocaleSettings = {
    # added LANG, LC_ALL, LC_CTYPE, LC_COLLATE, and LC_MESSAGES
    # to get rid of perl locale error
    LANGUAGE = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_COLLATE = "en_US.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chewing
      fcitx5-chinese-addons
      fcitx5-table-extra
    ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # remove xterm
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false; 

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable touchpad support (enabled default in most desktop>
  services.libinput.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "elias";

  # PROGRAMS
  # ================
  # Install Firefox.
  programs.firefox.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
  
  # MOVE MOST TO HOME.NIX
    # terminal apps
    wget
    curl
    fastfetch
    gnome-tweaks
    btop
    htop
    tree
    restic # backup program
    lm_sensors
    hddtemp
    f3

    # terminal editors
    neovim
    ptyxis

    # nix helper apps
    nh
  ];

  # Services
  # =========================

  # Enable OpenSSH
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };


  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Enable Docker
  #virtualisation.docker.enable = true;

  # Enable Firmware Updater
  services.fwupd.enable = true;
  # fwupdmgr refresh
  # fwupdmgr get-updates


}
