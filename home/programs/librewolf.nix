{ config, pkgs, ...}:

{
    programs.librewolf = {
      enable = true;
      settings = {
        "browser.tabs.tabmanager.enabled" = false;
      };
    };
}
