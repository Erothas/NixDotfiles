{ pkgs, vars, ... }:

let
  openrazer_overlay = self: super: {
    openrazer = super.openrazer.overrideAttrs (old: {
      version = "git";
      src = super.fetchFromGitHub {
        owner = "openrazer";
        repo = "openrazer";
        rev = "479a8f330bf126abee6c54ca9ccfd3af7f4e2ed3";  # replace with the hash of the latest commit
        sha256 = "1xbhxvb03lpky7wjl2xd0hvkhnskkagy5bxg3lpvx52y1rwibvm6";  # replace with the relevant hash
      };
    });
  };

  polychromatic_overlay = self: super: {
    polychromatic = super.polychromatic.overrideAttrs (old: {
      version = "git";
      src = super.fetchFromGitHub {
        owner = "polychromatic";
        repo = "polychromatic";
        rev = "2ee53dc567698608394f26f62ecf49229515e8f6";  # replace with the hash of the latest commit
        sha256 = "1h296x0qbq4vmmbfv8rldfl3wk902cwad9hpypk1s4crj1bgk4bi";  # replace with the relevant hash
      };
    });
  };
in
{
  nixpkgs.overlays = [ openrazer_overlay polychromatic_overlay ];
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [ openrazer-daemon polychromatic ];
  users.users.${vars.user}.extraGroups = [ "plugdev" ];
}

