{ config, lib, inputs, pkgs, vars, ... }:

{
  services = {
    xserver = {
      enable = true;
      displayManager.defaultSession = "plasma";
    };
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


}
