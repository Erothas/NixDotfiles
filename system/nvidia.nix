{ config, pkgs, libs, ... }:

{

  hardware = {
    graphics = {
      enable = true;
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
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
    # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = ["nvidia"];

    # Fixing suspend/wakeup issues
      boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" "nvidia_drm.fbdev=1" ];

}
