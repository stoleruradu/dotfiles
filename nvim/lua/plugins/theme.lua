-- https://github.com/jascha030/macos-nvim-dark-mode
local os_is_dark = function()
  return (vim.call(
    'system',
    [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]
  )):find('dark') ~= nil
end

return {
  -- add gruvbox
  { 'ellisonleao/gruvbox.nvim', priority = 1000, config = function()
    if os_is_dark() then
      vim.o.background = 'dark';
    else
      vim.o.background = 'light';
    end

    vim.cmd 'colorscheme gruvbox';
  end },
}
