{
  description = "I hate flakes...";


  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    niqspkgs = {
      url = "github:diniamo/niqspkgs";
    };

  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, plasma-manager, ... }:
    let
      vars = {
        user = "sero";
        terminal = "foot";
        editor = "nvim";
        location = "~/nixos";
      };

      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        ${vars.user} = lib.nixosSystem { 
            inherit system;
        specialArgs = { inherit inputs vars; };
        modules = [

          ./configuration.nix

            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs hyprland vars; };
                users.${vars.user} =  import ./home-manager/home.nix ;
              };  
            }
          ];
        };
      };
    };
}
