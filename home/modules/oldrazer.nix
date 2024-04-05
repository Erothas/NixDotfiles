{ pkgs, vars, ... }:

{

  hardware.openrazer = {
      enable = true;
      users = ["${vars.user}"];
  };

  environment.systemPackages = with pkgs; [
      openrazer-daemon
      polychromatic
    ];
  users.users.${vars.user}.extraGroups = [ "plugdev" ];

}
