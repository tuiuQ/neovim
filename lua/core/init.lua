local config = require("core.utils").load_config()

local leader_map = function()
  vim.g.mapleader = " "
  vim.api.nvim_set_keymap("n", " ", "", {noremap = true})
  vim.api.nvim_set_keymap("x", " ", "", {noremap = true})
end

local main = function()
  leader_map()
  pcall(require, "custom")
  require("core.options")
  require("core.mappings").misc()
  require("plugins")

  vim.cmd("colorscheme " .. config.ui.colorscheme)
  vim.cmd('set guifont="SauceCodePro Nerd Font:18"')
end

main()
