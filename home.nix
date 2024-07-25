{
  config,
  pkgs,
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

  # Enable Home Manager
  programs.home-manager.enable = true;
}
