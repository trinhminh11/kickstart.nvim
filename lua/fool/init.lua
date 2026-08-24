local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'fool')

local files = {}

for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    table.insert(files, file_name)
  end
end

table.sort(files)

for _, file_name in ipairs(files) do
  local module = file_name:gsub('%.lua$', '')
  require('fool.' .. module)
end
