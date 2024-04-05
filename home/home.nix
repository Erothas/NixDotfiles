{ config, pkgs, inputs, vars, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./programs
    ./themes
  ];

# colorScheme = inputs.nix-colors.colorSchemes.dracula;
# colorScheme = {
# slug = "Omni";
#   name = "Omni";
#   author = "ero?";
#   colors = {
#     base00 = "#191622"; # background
#     base01 = "#41414D"; # selection_background
#     base02 = "#000000"; # color0
#     base03 = "#4D4D4D"; # color8
#     base04 = "#ffffff"; # selection_foreground
#     base05 = "#E1E1E6"; # foreground
#     base06 = "#ffffff"; # color7
#     base07 = "#ffffff"; # color15
#     base08 = "#FF5555"; # color1
#     base09 = "#FF6E67"; # color9
#     base0A = "#EFFA78"; # color3
#     base0B = "#50FA7B"; # color2
#     base0C = "#8D78BA"; # color6
#     base0D = "#BD93F9"; # color4
#     base0E = "#FF79C6"; # color5
#     base0F = "#FF92D0"; # color13
#   };
# };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${vars.user}";
  home.homeDirectory = "/home/${vars.user}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    android-file-transfer
    brave
    fastfetch
    freetube
    #hakuneko
    lf
    libsForQt5.dolphin
    libsForQt5.okular
    libsForQt5.ark
    monero-gui
    mpv
    mullvad-vpn
    mullvad-browser
    #peazip
    #piper
    thunderbird
    qbittorrent
    qview
    ventoy
    wdisplays

    #Utilities
    ctpv        #LF file previewer
    du-dust     #sort files/folders by size
    hunspell
    hunspellDicts.en_GB-ise
    ugrep
    yt-dlp

    #Communication
    discord
    signal-desktop


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ]);


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sero/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
