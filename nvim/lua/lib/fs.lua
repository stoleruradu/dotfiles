local M = {};

M.ls = function(path)
  local handle = vim.loop.fs_scandir(path)
  local files = {};

  while handle do
    local name, type = vim.loop.fs_scandir_next(handle)

    if not name then
      break
    end

    local fname = path .. '/' .. name;

    table.insert(files, {
      fname = fname,
      name = name,
      type = type,
    })
  end

  return files;
end

return M;
