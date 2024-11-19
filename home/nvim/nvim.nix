{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
  ];
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };
  home.file.".config/nvim".source = ./.;
  home.file.".config/nvim".recursive = true;
}
