{ config, lib, pkgs, ... }: 

{

  home.packages = (with pkgs; [
   #bottles
    lutris
    gamemode
    wineWowPackages.staging
    winetricks
  ]);

}
