{ config, pkgs, inputs, vars, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/desktops/hypr.nix
     #./modules/desktops/gnome.nix
      ./modules/nvidia.nix
      ./modules/shell/zsh.nix
     #./modules/vm.nix
      ./modules/gaming.nix
      ./home/scripts
    ];

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
      };  
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;    
    kernelModules = ["tcp_bbr"];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.core.wmem_max" = 1073741824;
      "net.core.rmem_max" = 1073741824;
      "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
      "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
    };
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    wireguard.enable = true;
   # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
      };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  # Configure console keymap
  console = {
    keyMap = "dvorak";
    packages = [pkgs.terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
  };  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.user} = {
    isNormalUser = true;
    description = "Sero";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [];
  };

  # nixpkgs config
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-22.3.27"
      ];
  };

  # Setting up environment variables & installing system wide packages
  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
      BROWSER = "librewolf";
      VIDEO = "mpv";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c"; #bat pager fix
      NIXOS_OZONE_WL = "1"; #hint electron apps to use wayland
      FZF_DEFAULT_OPTS = "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :500 {}'";
      GTK_USE_PORTAL = "1";
     };
    systemPackages = with pkgs; [
      appimage-run
      bat
      btop
      cachix
      curl
      #czkawka
      duf
      eza
      fd
      ffmpegthumbnailer
      git
      killall
      libnotify
      qt6.qtwayland
      libsForQt5.qt5.qtwayland
      libsForQt5.ffmpegthumbs
      libsForQt5.kdegraphics-thumbnailers
      libsForQt5.kimageformats
      libsForQt5.kio-extras
      libsForQt5.polkit-kde-agent
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libqalculate
      pavucontrol
      qt6Packages.qt6ct
      qt6Packages.qtstyleplugin-kvantum
      tealdeer
      unrar
      unzip
      wget2
      zip
      zsh-powerlevel10k
    ];
  };

  # Security toggles
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Set fonts
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      ubuntu_font_family
      font-awesome
      noto-fonts
    ];
     fontconfig = {
       enable = true;
#      defaultFonts = {
#      serif = ["Times, Noto Serif"];
#      sansSerif = ["Helvetica Neue LT Std, Helvetica, Noto Sans"];
#      monospace = ["Courier Prime, Courier, Noto Sans Mono"];
#    };
    };
   };

  # flatpak icon/cursor fix
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = with pkgs; [
        #libsForQt5.breeze-qt5  # for plasma
      ];
      pathsToLink = [ "/share/icons" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };


# nixpkgs.overlays = [
#   (self: super: { mullvad-vpn = mull23.mullvad-vpn; })
# ];

  # List services that you want to enable:
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    udisks2.enable = true;
    flatpak.enable = true;
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    resolved.enable = true;
    tailscale.enable = true; #fix for mullvad vpn
    blueman.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };


  # Enables flakes & garbage collector
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2w";  
    };
    settings = {
      auto-optimise-store = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05";

}
