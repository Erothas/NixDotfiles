{ config, ... }:

{
  imports = [ 
    ./foot.nix
    ./nvim
    ./librewolf.nix
    ./gaming.nix
    ./helix.nix
    ./kitty.nix
    ./waybar.nix
    ./mako.nix
    ./swaylock.nix
    ./xdg.nix
  ]; 
}
