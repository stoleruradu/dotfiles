{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];
  home.file.".config/alacritty".source = ./.;
  home.file.".config/alacritty".recursive = true;
}
