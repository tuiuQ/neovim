local M = {}

M.options = {
  -- 行号
  number = true,
  numberwidth = 4,
  relativenumber = true,
  cursorline = true,
  -- tab
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  -- color
  termguicolors = true,
  -- mouse
  mouse = "a",
  -- encoding
  encoding = "utf-8"
}

M.gloabl = {
  material_style = "darker"
}

M.ui = {
  -- colorscheme = "nord"
  colorscheme = "doom-one"
}

M.plugins = {
  status = {
    comment = true,
    nvimtree = true
  },
  options = {
    nvimtree = {
      enable_git = 1,
      ui = {
        allow_resize = true,
        side = "left",
        width = 25,
        hide_root_folder = true,
      }
    }
  },
  default_plugin_config_replace = {}
}

M.mappings = {
  misc = {
    close_buffer = "<leader>x",
    new_buffer = "<leader>bn",
    new_tab = "T",
    line_number_toggle = "<leader>n"
  },
  split = {
    left = "sh",
    right = "sl",
    top = "sk",
    bottom = "sj"
  },
  window_nav = {
    move_left = "<leader>wh",
    move_right = "<leader>wl",
    move_top = "<leader>wk",
    move_bottom = "<leader>wj"
  },
  terminal = {
    new_horizontal = "<leader>h",
    new_vertical = "<leader>v",
    new_window = "<leader>w"
  }
}

M.mappings.plugins = {
  comment = {
    toggle = "<leader>/"
  },
  nvimtree = {
    toggle = "ff"
  },
  lazygit = {
    open = "<leader>gg",
    config = "<leader>gf"
  },
  bufferline = {
    move_next = "<tab>",
    move_prev = "<s-tab>"
  },
  telescope = {
    buffers = "<leader>fb",
    find_files = "<leader>ff",
    find_hiddenfiles = "<leader>fa",
    git_commits = "<leader>cm",
    git_status = "<leader>gt",
    help_tags = "<leader>fh",
    live_grep = "<leader>fw",
    oldfiles = "<leader>fo",
    themes = "<leader>th",
    telescope_media = {
      media_files = "<leader>fp"
    }
  }
}

return M
