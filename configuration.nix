# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelModules = [ "kvm-intel" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.useOSProber = true;
    };
  };

  virtualisation.libvirtd.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = "deep-thought";
    useDHCP = false;
    interfaces.wlp59s0.useDHCP = true;
    networkmanager.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users.caleb = {
      isNormalUser = true;
      home = "/home/caleb";
      description = "Caleb Baker";
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" ];
      initialPassword = "password";
    };
  };

  system.autoUpgrade.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs = {
    nm-applet.enable = true;
    zsh  = {
      enable = true;
      enableCompletion = true;
    };
  };

  # Enable the GNOME 3 Desktop Environment.
  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+i3";
        autoLogin = {
          enable = true;
          user = "caleb";
        };
      };
      videoDrivers = [ "modesetting" "nvidida" ];
      useGlamor = true;
      libinput.enable = true;
      layout = "us";
    };
    printing.enable = true;
  };
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # List packages installed in system profile. To search, run:
  environment = {
    systemPackages = with pkgs; [
      brightnessctl
      firefox
      git
      home-manager
      neovim

      # Needed for building micros
      clang
      gnumake
      grub2
      nasm
      qemu_kvm
      rustup
      xorriso
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

