{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    plugins = [
      pkgs.tmuxPlugins.catppuccin
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
