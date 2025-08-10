{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    tree-sitter
    nixd
    nixfmt
    luarocks
    lua5_1
  ];
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };
  home.file.".config/nvim".source = ./.;
  home.file.".config/nvim".recursive = true;
}
