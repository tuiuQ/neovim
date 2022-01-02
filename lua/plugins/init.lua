local present, packer = pcall(require, "plugins.packerInit")

if not present then
  print "Packer is not installed, Please install"
  return false
end

local use = packer.use

return packer.startup(function () 
  local utils = require("core.utils")
  local config = utils.load_config()
  local plugins_settings = config.plugins
  local override_req = require("core.utils").override_req

  use {
    "wbthomason/packer.nvim",
    event = "VimEnter"
  }

  -- base16
  use {
    "NvChad/nvim-base16.lua",
    after = "packer.nvim"
  }

  -- icons
  use {
    "kyazdani42/nvim-web-devicons",
    after = "nvim-base16.lua",
    config = override_req("new_web_devicons", "plugins.configs.icons")
  }

  -- colorscheme
  -- use 'marko-cerovac/material.nvim'
  use 'NTBBloodbath/doom-one.nvim'

  -- nvim tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = override_req("nvimtree", "plugins.configs.nvimtree"),
    setup = function()
      require("core.mappings").nvimtree()
    end
  }

  -- code ruuner
  use {
    "Pu-gayhub/CodeRunner.nvim",
    config = function()
      require("CodeRunner").setup {
        -- 你可以在此处自定义不同语言的执行方式
        tasks = {
          c = "make", -- 可以是字符串，会发送到浮动终端执行
          python = "python <file>", -- 尖括号标记预定义变量。见下方变量。
          lua = function() -- 也可以执行一个函数
            vim.cmd("luafile %") -- 使用 VIM API
          end,
        },
        -- 此处可自定义浮动终端样式
        style = {
          -- 边框，见 `:help nvim_open_win`
          border = "rounded", -- 圆角边框
          -- 终端背景色
          bgcolor = "NONE", -- NONE 为透明
          -- 终端大小和位置，为百分数相对位置
          layout = {
            width = .8, -- 80% 编辑器大小
            height = .8,
            x = .5, -- 在编辑器中间
            y = .5
          }
        }
      }
    end,
    setup = function()
      require("core.mappings").codeRunner()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = (function()
      require('Comment').setup()
    end),
    setup = function()
      require("core.mappings").comment()
    end
  }

  -- 多光标
  use {
    'mg979/vim-visual-multi'
  }

  -- indent
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = override_req("indent-blankline", "(plugins.configs.others).blankline()")
  }

  -- lazygit
  use {
    'kdheepak/lazygit.nvim',
    setup = function()
      require("core.mappings").lazygit()
    end
  }

  -- tab line
  use {
    'akinsho/bufferline.nvim',
    config = override_req("bufferline", "plugins.configs.bufferline"),
    setup = function()
      require("core.mappings").bufferline()
    end
  }

  -- status line
  -- use {
  --   'feline-nvim/feline.nvim',
  --   config = override_req("feline", "plugins.configs.feline")
  -- }
  use {
    'windwp/windline.nvim',
    config = override_req("statusline", "plugins.configs.statusline")
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 
      {'nvim-lua/plenary.nvim'},
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
      },
      {
        "nvim-telescope/telescope-media-files.nvim",
        setup = function()
          require("core.mappings").telescope_media()
        end
      }
    },
    setup = function()
      require("core.mappings").telescope()
    end
  }

  -- lspconfig
  use {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = override_req("lspconfig", "plugins.configs.lspconfig")
  }

  use {
    "williamboman/nvim-lsp-installer",
    after = "nvim-lspconfig"
  }

  use {
    "tami5/lspsaga.nvim",
    after = "nvim-lspconfig"
  }

  use {
    "kosayoda/nvim-lightbulb",
    after = "nvim-lspconfig",
    config = override_req("lightbulb", "(plugins.configs.others).lightbulb()")
  }

  use {
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig"
  }

  use {
    "hrsh7th/nvim-cmp",
    config = override_req("cmp", "plugins.configs.cmp"),
    event = "InsertEnter",
    requires = {
      {"lukas-reineke/cmp-under-comparator"},
      {"saadparwaiz1/cmp_luasnip", after = "LuaSnip"},
      {"hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip"},
      {"hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp"},
      {"andersevenrud/compe-tmux", branch = "compe", after = "cmp-nvim-lua"},
      {"hrsh7th/cmp-path", after = "compe-tmux"},
      {"f3fora/cmp-spell", after = "cmp-path"},
      {"hrsh7th/cmp-buffer", after = "cmp-spell"},
      {"kdheepak/cmp-latex-symbols", after = "cmp-buffer"}
    }
  }

  use {
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = override_req("luasnip", "(plugins.configs.others).luasnip()"),
    requires = "rafamadriz/friendly-snippets" 
  }

  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = override_req("autopairs", "(plugins.configs.others).autopairs()")
  }

  use {
    "github/copilot.vim",
    cmd = "Copilot"
  }


  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = override_req("treesitter", "plugins.configs.treesitter")
  }

  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter"
  }
  use {
    "romgrk/nvim-treesitter-context",
    after = "nvim-treesitter"
  }
  use {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
    event = "BufRead"
  }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter"
  }
  use {
    "mfussenegger/nvim-ts-hint-textobject",
    after = "nvim-treesitter"
  }
  use {
    "SmiteshP/nvim-gps",
    after = "nvim-treesitter",
    config = override_req("gps", "(plugins.configs.others).gps()")
  }

  require("core.hooks").run("install_plugins", use)
end)

