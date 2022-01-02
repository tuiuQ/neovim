local config = require("core.utils").load_config()

local function origin_options()
  local options_local = config.options
  for key, value in pairs(options_local) do
    vim.o[key] = value
  end
end

local function origin_global()
  local global_local = config.global
  for key, value in pairs(global_local) do
    vim.g[key] = value
  end
end

origin_options()
