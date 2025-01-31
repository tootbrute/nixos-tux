{ config, pkgs, lib, ... }:

{
  # Auto unlock gnome keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Remove default packages from GNOME
  environment.gnome.excludePackages = with  pkgs; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    #gedit      # text editor
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    file-roller # archive manager
    geary       # email client
    seahorse    # password manager
    gnome-contacts
    gnome-weather
    gnome-maps
    gnome-music
    gnome-software
    gnome-extension-manager
    gnome-shell-extensions
    gnome-photos
    gnome-connections
    snapshot
    gnome-logs
    gnome-system-monitor
    gnome-calculator
    gnome-tour
  ];

  # Logout and login again after rebuilding to see changes in GNOME
  environment.gnome.packages = with pkgs.gnomeExtensions; [
    appindicator
    dask-to-dock	
    caffeine
    gsconnect
    hot-edge
    alphabetical-app-grid
    kimpanel
    tailscale-status
  ];

}
