{ config, lib, inputs, pkgs, vars, ... }:

{
  services = {
    displayManager.defaultSession = "plasma";
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --asterisks --time --time-format '%I:%M %p | %a • %h | %F' --cmd startplasma-wayland";
          user = "greeter";
        };
      };
    };

  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  environment.systemPackages = with pkgs; [
    kde-rounded-corners
  ];

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

# home-manager.users.${vars.user} = {
#   imports = [
#     inputs.plasma-manager.homeManagerModules.plasma-manager
#   ];
# };
}
