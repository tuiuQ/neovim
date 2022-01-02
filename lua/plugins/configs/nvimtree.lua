local present, nvimtree = pcall(require, "nvim-tree")

local config = require("core.utils").load_config().plugins.options.nvimtree

local git_status = config.enable_git
local ui = config.ui

local g = vim.g

g.nvim_tree_git_hl = git_status
g.nvim_tree_indent_markers = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

g.nvim_tree_window_picker_exclude = {
  filetype = { "notify", "packer", "qf" },
  buftype = { "terminal" },
}

g.nvim_tree_show_icons = {
  folders = 1,
  files = 1,
  git = git_status,
}

g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
     deleted = "",
     ignored = "◌",
     renamed = "➜",
     staged = "✓",
     unmerged = "",
     unstaged = "✗",
     untracked = "★",
  },
  folder = {
     default = "",
     empty = "",
     empty_open = "",
     open = "",
     symlink = "",
     symlink_open = "",
  },
}

nvimtree.setup {
  filters = {
    dotfiles = false,
  },
  disable_netrw = true,
  hijack_netrw = true,
  auto_close = true,
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = ui,
  git = {
    ignore = false,
  },
}