{ pkgs, ... }: 


{

  programs = {
    gamemode.enable = true;
#   steam = {
#     enable = true;
#     gamescopeSession.enable = true;
#   };
  };

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    lutris
    wineWowPackages.staging
    winetricks
    umu-launcher
  ];

}
