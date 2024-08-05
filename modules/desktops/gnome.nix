{ config, lib, inputs, pkgs, vars, ... }:

{
  services = {
 #  displayManager.defaultSession = "gnome";
    xserver.enable = true;
    xserver.desktopManager.gnome.enable = true;
    xserver.displayManager.gdm.enable = true;
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

# Dynamic triple buffering
 #nixpkgs.config.allowAliases = false; #Causes issues for me
  nixpkgs.overlays = [
    # GNOME 46: triple-buffering-v4-46
    (final: prev: {
      gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs (old: {
          src = pkgs.fetchFromGitLab  {
            domain = "gitlab.gnome.org";
            owner = "vanvugt";
            repo = "mutter";
            rev = "triple-buffering-v4-46";
            hash = "sha256-nz1Enw1NjxLEF3JUG0qknJgf4328W/VvdMjJmoOEMYs=";
          };
        });
      });
    })
  ];


  home-manager.users.${vars.user} = {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
      # enabled-extensions = with pkgs.gnomeExtensions; [
      #   pop-shell.extensionUuid
      #   appindicator.extensionUuid
      # ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.forge
  ];
}
