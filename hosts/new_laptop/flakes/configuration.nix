# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy::w
  # port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    firewall.enable = true;
    #wireless.iwd.enable = true;

       networkmanager = {
         enable = true; 
         dns = "default";
         wifi = {
           powersave = false;
           backend = "iwd";
         };
       };

    hostName = "laptop";
    #useDHCP = false;
    #interfaces.wlp195s0 = {
    #  useDHCP = true;
#      ipv4.addresses = [ {
#        address = "192.168.1.69";
#        prefixLength = 24;
     # } ];
    #    };
    nameservers = ["1.1.1.1" "1.0.0.1"];
#    dhcpcd.extraConfig = "nohook resolv.conf";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu" "nvidia"];
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
  };

  # Configure keymap in X11
   services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tesla = {
    isNormalUser = true;
    description = "Areg Zaratsyan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "tesla" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    pciutils
    home-manager
    kitty
    git
    rofi-wayland
    swww
    waybar
    hyprlock
    brightnessctl
    pamixer
    hypridle
    pavucontrol
    bluez
    zed-editor
    nextcloud-client
    snakemake
    tree
    logseq
    firefox
    hyprshot
    vlc
    tlp
    deluge
    brave
    acpid
    wl-clipboard
    xournalpp
    wireguard-tools
    love
    zip
    unzip
    p7zip
    obsidian
    nwg-displays
    blueman
  ];

  systemd.targets.multi-user.wants = ["warp-svc.service"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #  #testing asusctl
  #  services = {
  #    asusd = {
  #      enable = true;
  #      enableUserService = true;
  #    };
  #  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # services = {
  #   asusd.enable = lib.mkDefault true;
  #   udev.extraHwdb = ''
  #     evdev:name:*:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
  #      KEYBOARD_KEY_ff31007c=f20    # fixes mic mute button
  #   '';
  # };

  # Enable nvf
  # programs.nvf = {
  #   enable = true;
  # };

  # Enable hyprland
  programs.steam.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
