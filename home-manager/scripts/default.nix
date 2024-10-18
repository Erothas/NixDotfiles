 { config, lib, pkgs, ... }:

let
    scripts = "~/nixos/home/scripts";

    my_bemenu = pkgs.writeShellScriptBin "my_bemenu" ''
    ${scripts}/my_bemenu
  '';

    scripts-launcher = pkgs.writeShellScriptBin "scripts-launcher" ''
    ${scripts}/scripts-launcher
  '';

    play-youtube = pkgs.writeShellScriptBin "play-youtube" ''
    ${scripts}/play-youtube
  '';

    bm-kill = pkgs.writeShellScriptBin "bm-kill" ''
    ${scripts}/bemenu-scripts/bm-kill
  '';

    bm-mullvad-excluded = pkgs.writeShellScriptBin "bm-mullvad-excluded" ''
    ${scripts}/bemenu-scripts/bm-mullvad-excluded
  '';

    bm-youtube-player = pkgs.writeShellScriptBin "bm-youtube-player" ''
    ${scripts}/bemenu-scripts/bm-youtube-player
  '';
 in

{
  environment.systemPackages = with pkgs; [
    my_bemenu
    scripts-launcher
    play-youtube
    bm-kill
    bm-mullvad-excluded
    bm-youtube-player
  ];
}
