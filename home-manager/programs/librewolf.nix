{ config, pkgs, lib, vars, ...}:

let
  profile_dir = lib.strings.concatStringsSep "\n" (lib.splitString "/" 
    (builtins.readFile (
      builtins.toFile "profile_dir" ''
        find /home/${vars.user}/.librewolf -type d -name "*.default" | head -n 1
      ''
    ))
  );
in

{
    programs.librewolf = {
      enable = true;
      settings = {
        "browser.tabs.tabmanager.enabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.hoverPreview.enabled" = false;
      };
    };

  home.activation.librewolfConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    profile_dir=$(find /home/${vars.user}/.librewolf -type d -name "*.default" | head -n 1)
    mkdir -p "$profile_dir/chrome"
    echo '#alltabs-button { display: none !important; }' > "$profile_dir/chrome/userChrome.css"
  '';

  home.file.".librewolf/${profile_dir}/chrome/userChrome.css".text = ''
    #alltabs-button { display: none !important; }
  '';

}
