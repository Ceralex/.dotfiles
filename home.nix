{
  config,
  pkgs,
  lib,
  ...
}: {
  # Import application configurations
  imports = [
    ./apps/git.nix
    ./apps/alacritty.nix
    ./apps/zsh.nix
  ];

  # User and directory configurations
  home.username = "alessandro";
  home.homeDirectory = "/home/alessandro";
  home.stateVersion = "24.05"; # Do not change this value without checking Home Manager release notes

  # Install Nix packages
  home.packages = with pkgs; [
    alacritty
    alejandra
    brave
    discord
    fastfetch
    git
    gnome-extension-manager
    gnome.gnome-tweaks
    spotify
    vlc
    vscode
    (nerdfonts.override {fonts = ["JetBrainsMono"];}) # Install JetBrainsMono from Nerd Fonts
  ];

  # Manage dotfiles
  home.file = {
    # Example of how to manage dotfiles
    # ".screenrc".source = dotfiles/screenrc;

    # Example of setting file content immediately
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Fix for https://github.com/NixOS/nixpkgs/issues/12757
  home.activation.copyDesktopFiles = lib.hm.dag.entryAfter ["installPackages"] ''
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
      if [ -d "${config.home.homeDirectory}/.nix-profile/share/applications" ]; then
        rm -rf ${config.home.homeDirectory}/.local/share/applications
        mkdir -p ${config.home.homeDirectory}/.local/share/applications
        for file in ${config.home.homeDirectory}/.nix-profile/share/applications/*; do
          ln -sf "$file" ${config.home.homeDirectory}/.local/share/applications/
        done
      fi
    fi
  '';
  # Enable Home Manager
  programs.home-manager.enable = true;
}
