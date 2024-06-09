{ config, pkgs, libs, ... }:

{

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [libva vaapiVdpau libvdpau-va-gl];
      extraPackages32 = with pkgs.pkgsi686Linux; [vaapiVdpau libvdpau-va-gl];
    };

    nvidia = {
      modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = true;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;
    # Use the NVidia open source kernel module
      open = false;
      nvidiaSettings = true;
     #package = config.boot.kernelPackages.nvidiaPackages.beta;
      };
    };
    # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = ["nvidia"];

    # Fixing suspend/wakeup issues
      boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

    # Special config to load the latest (535 or 550) driver for the support of the 4070 SUPER
     hardware.nvidia.package = let 
       rcu_patch = pkgs.fetchpatch {
       url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
       hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
     };
    in config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "535.154.05";
      sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
      sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
      openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
      settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
      persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

      patches = [ rcu_patch ];
   };
}
