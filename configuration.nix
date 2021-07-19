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
      grub = {
        configurationLimit = 10;
        useOSProber = true;
      };
      timeout = 1800;
    };
  };

  virtualisation = {
    libvirtd.enable = true;
  };

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
    users = {
      caleb = {
        isNormalUser = true;
        home = "/home/caleb";
        description = "Caleb Baker";
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" ];
        initialPassword = "";
      };
      sky = {
        isNormalUser = true;
        home = "/home/sky";
        description = "Sky";
        extraGroups = [ "wheel" "networkmanager" ];
        initialPassword = "";
      };
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

  services = {
    httpd = {
      adminAddr = "calebbaker774@gmail.com";
      enable = true;
      extraConfig = "AddType application/wasm .wasm";
      virtualHosts.localhost.documentRoot = "/home/caleb/local/srv";
    };
    xserver = {
      enable = true;
      desktopManager.cinnamon.enable = true;
      windowManager.i3.enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+i3";
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
  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
  };

  # List packages installed in system profile. To search, run:
  environment = {
    systemPackages = with pkgs; [

      # Mandatory packages for basic computer maintenance
      brightnessctl
      git
      home-manager
      python3
      neovim

      # I know what these are
      vivaldi
      gdb
      google-chrome
      rust-analyzer
      steam
      texlive.combined.scheme-full
      vscode
      teams

      # Needed for building rust programs
      clang
      rustup

      # Used for getting summary information about files
      file

      # Used for optimizing web assembly
      # binaryen

      # Needed for building micros
      # gnumake
      # grub2
      # nasm
      # qemu_kvm
      # xorriso

      # Trying to be able to compile against openssl
      openssl.dev
      pkgconfig

      # Some rust crates assume this is installed
      binutils
      
      # Used for installing firebase
      nodejs

    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  nix = {
    autoOptimiseStore = true;
    extraOptions = ''
        min-free = ${toString (100 * 1024 * 1024 * 1024)}
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

