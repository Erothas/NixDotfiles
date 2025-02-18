 {config, pkgs, ...}: 
 let
  browser = ["librewolf.desktop"];
  email = ["thunderbird.desktop"];

  # XDG MIME types
  associations = {
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    "text/plain" = ["Helix.desktop"];
    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["com.interversehq.qView.desktop"];
    "application/json" = browser;
    "application/pdf" = ["org.kde.okular.desktop"];

    "x-scheme-handler/mailto" = email;
    "x-scheme-handler/mid" = email;
    "x-scheme-handler/webcal" = email;
    "x-scheme-handler/webcals" = email;

  };
in {
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}
