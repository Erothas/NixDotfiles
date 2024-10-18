{ config, pkgs, ... }:

let
  mullvad-vpn = self: super: {
    mullvad-vpn = super.mullvad-vpn.overrideAttrs (old: {
      version = "git";
      src = super.fetchFromGitHub {
        owner = "mullvad";
        repo = "mullvadvpn-app";
        rev = "c2f7f75dee35c050540b90c6ebc9084969b1a93b";
        sha256 = "LDthdD0AlEWUdO0zY5guxyQFkVxjGpTfGNKaSCc7C7g=";
      };
    });
  };

in
{
  nixpkgs.overlays = [ mullvad-vpn ];
 #environment.systemPackages = with pkgs; [ mullvad-vpn ];
  services.mullvad-vpn.enable = true;

}

