function dirLookup(dir)
   local p = io.popen('find "'..dir..'" -type f')  --Open directory look for files, save data in p. By giving '-type f' as parameter, it returns all files.     
   for file in p:lines() do                         --Loop through all files
       print(file)       
   end
end

--require "config.compe"
--require "config.lspconfig"
--require "config.nvimtree"
--require "config.treesitter"
--require "config.telescope"
--require "config.lualine"

