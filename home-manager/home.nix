# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./apps/git.nix
    ./apps/alacritty.nix
    ./apps/zsh.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "alessandro";
    homeDirectory = "/home/alessandro";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
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

    wezterm
  ];

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

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
