# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop-ale"; # Define your hostname.
  networking.networkmanager.enable = true; # Enable networking.

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # X11 configuration.
  services.xserver = {
    enable = true;
    xkb.layout = "it";
    excludePackages = [
      pkgs.xterm
    ];
  };

  # Enable GNOME desktop environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Console keymap.
  console.keyMap = "it2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with Pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # Define a user account.
  users.users.alessandro = {
    isNormalUser = true;
    description = "Alessandro";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # System packages
    # vim
  ];

  # Enable OpenGL.
  hardware.opengl.enable = true;

  # Load Nvidia driver for Xorg and Wayland.
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.gnome.excludePackages = with pkgs;
    [
      gnome-tour
    ]
    ++ (with pkgs.gnome; [
      gnome-music
      epiphany # web browser
      geary # email reader
      simple-scan # document scanner

      # gnome-terminal
      # evince # document viewer
      # gnome-characters
      # totem # video player
    ]);

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Stateful data version.
  system.stateVersion = "24.05"; # Did you read the comment?
}
