P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(name)
  RELOAD = require('plenary.reload').reload_module

  RELOAD(name)

  return require(name)
end
