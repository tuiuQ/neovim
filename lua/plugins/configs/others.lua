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

return M
