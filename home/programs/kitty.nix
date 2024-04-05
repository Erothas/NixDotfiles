{ config, pkgs, ... }:

{

    programs.kitty = {
      enable = true;
      font = {
        name = "ComicShannsMono Nerd Font Mono";
        size = 14;
      };
      settings = {
        confirm_os_window_close = "0";
        disable_ligatures = "always";
        cursor_text_color = "background";
        cursor_shape = "beam";
        scrollback_lines = 2000;
        url_color = "#0087bd";
        url_style = "curly";
        detect_urls = "yes";
        active_tab_foreground = "#191631";
        active_tab_background = "#E6E6E6";
        inactive_tab_foreground = "#44476F";
        inactive_tab_background = "#6272A4";
        tab_bar_background = "none";
        foreground = "#E1E1E7";
        background = "#191622";
        background_opacity = "0.85";
        selection_foreground = "#ffffff";
        selection_background = "#41414D";
        color0 = "#000000";
        color1 = "#FF5555"; 
        color2 = "#50FA7B";
        color3 = "#EFFA78";
        color4 = "#BD93F9";
        color5 = "#FF79C6";
        color6 = "#8D79BA";
        color7 = "#ffffff";
        color8 = "#4D4D4D";
        color9 = "#FF6E67";
        color10 = "#5AF78E";
        color11 = "#EAF08D";
        color12 = "#CAA9FA";
        color13 = "#FF92D0";
        color14 = "#AA91E3";
        color15 = "#ffffff";
     };
  };
}

