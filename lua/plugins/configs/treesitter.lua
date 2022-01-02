local api = vim.api
local present, treesitter = pcall(require, "nvim_treesitter.configs")

if not present then
  return false
end

api.nvim_command("set foldmethod=expr")
api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

treesitter_config.setup {
  ensure_installed = "maintained",
  highlight = {enable = true, disable = {"vim"}},
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    },
    move  = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]["] = "@function.outer",
        ["]m"] = "@class.outer"
      },
      goto_next_end = {
        ["]]"] = "@function.outer",
        ["]M"] = "@class.outer"
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[m"] = "@class.outer"
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
        ["[M"] = "@class.outer"
      }
    }
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000
  },
  context_commentstring = {enable = true, enable_autocmd = false},
  matchup = {enable = true},
  context = {enable = true, throttle = true}
}

