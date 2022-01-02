local config = require("core.utils").load_config()
local M = {}

M.comment = function()
  local present, nvim_comment = pcall(require, "Comment")
  if present then
    require("Comment").setup()
  end
end

M.lightbulb = function()
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
end

M.luasnip = function()
  require("luasnip").config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI"
  }
  require("luasnip/loaders/from_vscode").load()
end

M.autopairs = function()
  require("nvim-autopairs").setup {}

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))
  cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
end

M.gps = function()
  require("nvim-gps").setup({
    icons = {
        ["class-name"] = " ", -- Classes and class-like objects
        ["function-name"] = " ", -- Functions
        ["method-name"] = " " -- Methods (functions inside class-like objects)
    },
    languages = {
        -- You can disable any language individually here
        ["c"] = true,
        ["cpp"] = true,
        ["go"] = true,
        ["java"] = true,
        ["javascript"] = true,
        ["lua"] = true,
        ["python"] = true,
        ["rust"] = true
    },
    separator = " > "
  })
end

M.blankline = function()
  vim.opt.list = true
  vim.opt.listchars:append("space:⋅")
  vim.opt.listchars:append("eol:↴")
  
  require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  }
end

M.codeRunner = function()
  require("CodeRunner").setup {
    -- 你可以在此处自定义不同语言的执行方式
    tasks = {
      c = "make", -- 可以是字符串，会发送到浮动终端执行
      python = "python <file>", -- 尖括号标记预定义变量。见下方变量。
      php = "php -S localhost:8080 -t ./",
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
end

return M
