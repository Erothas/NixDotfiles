{ config, pkgs, lib, vars, ... }: 

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 999999;
      histFile = "$home/nixos/home/modules/shell/.histfile";
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      shellAliases = {
        cat = "bat";
        ls = "eza -al --group-directories-first --color=always --icons"; #list all files & directories
        la = "eza -a --group-directories-first --color=always --icons"; #list only names horizontally
        lt = "eza -aT --group-directories-first --color=always --icons"; #list in tree format
        tarnow = "tar -acf";
        untar = "tar -zxvf";
        wget = "wget2 -c";
        findpkg = "nix-store -q --references /run/current-system/sw | cut -d'-' -f2- | ug";
        findanypkg = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort -u | ug";
        df = "duf";
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "rm -vI";
        grep = "ugrep";
        dust = "dust -r";
        git-bare = "git --git-dir=$HOME/NixDotfiles --work-tree=$HOME";
      };
    };
  };

# programs = {
#   zsh = {
#     enableAutosuggestions = true;
#     syntaxHighlighting.enable = true;
#     enableCompletion = true;
#     history =  {
#       enable = true;  
#       size = 999999;
#       path = "$HOME/.histfile";
#       share = false;
#       expireDuplicatesFirst = true;
#       ignoreSpace = true;
#     };
#     plugins = [
#       {name = "powerlevel10k";src = pkgs.zsh-powerlevel10k;file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";}
#     ];
#     initExtra = ''
#      fastfetch
#      source ~/.p10k.zsh
#     '';
#     shellAliases = {
#       cat = "bat";
#       ls = "eza -al --group-directories-first --color=always --icons"; #list all files & directories
#       la = "eza -a --group-directories-first --color=always --icons"; #list only names horizontally
#       lt = "eza -aT --group-directories-first --color=always --icons"; #list in tree format
#       tarnow = "tar -acf";
#       untar = "tar -zxvf";
#       wget = "wget2 -c";
#       findpkg = "nix-store -q --references /run/current-system/sw | cut -d'-' -f2- | ug";
#       findanypkg = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort -u | ug";
#       df = "duf";
#       cp = "cp -iv";
#       mv = "mv -iv";
#       rm = "rm -vI";
#       grep = "ugrep";
#       dust = "dust -r";
#     };
#   };
# };

}

