 { config, lib, pkgs, ... }:

  let
  buuf-nestort = pkgs.stdenvNoCC.mkDerivation {
    pname = "buuf-nestort";
    version = "unstable-2023-11-05";

    src = pkgs.fetchurl {
      url = "https://git.disroot.org/eudaimon/buuf-nestort/archive/master.tar.gz";
      hash = "sha256-VDbY+RBhwYX3Xi1mwPrMu19ilZVRSRzIuMG304Ds+j8=";
    };

    dontPatch = true;
    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      rm -rf *.{sh,md}
      mkdir -p $out/share/icons/buuf-nestort
      mv * $out/share/icons/buuf-nestort/
    '';
  };

  buuf-cursor-heart = pkgs.stdenvNoCC.mkDerivation {
    pname = "buuf-cursor-heart";
    version = "master";

    src = pkgs.fetchurl {
      url = "https://github.com/Erothas/NixDotfiles/raw/master/home/themes/buuf-cursor-heart-24-a.tar.gz";
      sha256 = "sha256-ZKqWw0Itro9CQIJyouLxel76C80kie8EYkmm2Kc0iJs=";
    };

    dontPatch = true;
    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      mkdir -p $out/share/icons/buuf-cursor-heart
      mv * $out/share/icons/buuf-cursor-heart/
    '';
    };
   in
 {

  home.packages = (with pkgs; [
    buuf-nestort
    buuf-cursor-heart
  ]);

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
   };
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };  
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    iconTheme = {
      name = "Buuf For Many Desktops";
      package = buuf-nestort;
    };  
    font = {
      name = "Ubuntu";
      size = 12;
    };  
    cursorTheme = {
      name = "buuf-cursor-heart";
      package = buuf-cursor-heart;
      size = 24;
    };
  };

   home.pointerCursor = {
     name = "buuf-cursor-heart";
     package = buuf-cursor-heart;
     size = 24;
     gtk.enable = true;
     x11.enable = true;
   };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvCurves3d
 '';

 }

