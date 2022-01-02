local utils = require("core.utils")
local hooks = require("core.hooks")
local config = utils.load_config()
local maps = config.mappings
local plugins_maps = maps.plugins

local map = utils.map

local M = {}

M.misc = function()
  local function split()
    local split = maps.split
    map.n(split.left, ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>")
    map.n(split.right, ":set splitright<CR>:vsplit<CR>")
    map.n(split.top, ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>")
    map.n(split.bottom, ":set splitbelow<CR>:split<CR>")
  end
  local function options_mappings()
    local wnav = maps.window_nav
    map.n(wnav.move_left, "<C-w>h")
    map.n(wnav.move_right, "<C-w>l")
    map.n(wnav.move_top, "<C-w>k")
    map.n(wnav.move_bottom, "<C-w>j")
  end

  local function plugins_mappings()
    local misc = maps.misc
    map.n(misc.close_bufferm, ":lua require('core.utils').close_buffer()<CR>")
    map.n(misc.new_buffer, ":enew<CR>")
    map.n(misc.new_tab, ":tabnew<CR>")
    map.n(misc.line_number_toggle, ":set nu!<CR>")

    local terminal = maps.terminal
    map.n(terminal.new_horizontal, ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
    map.n(terminal.new_vertical, ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
    map.n(terminal.new_window, ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")
  end

  split()
  options_mappings()
  plugins_mappings()
  hooks.run("setup_mappings", map)
end

M.comment = function()
  local m = plugins_maps.comment.toggle
  map.n(m, ":lua require('Comment.api').toggle_current_linewise()<CR>")
  map.v(m, ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
end

M.nvimtree = function()
  local toggle = plugins_maps.nvimtree.toggle
  map.n(toggle, ":NvimTreeToggle<CR>")
end

M.bufferline = function()
  local move_next = plugins_maps.bufferline.move_next
  local move_prev = plugins_maps.bufferline.move_prev
  map.n(move_next, ":BufferLineCycleNext<CR>")
  map.n(move_prev, ":BufferLineCyclePrev<CR>")
end

M.lazygit = function()
  local m = plugins_maps.lazygit

  map.n(m.open, ":LazyGit<CR>")
  map.n(m.config, ":LazyGitConfig<CR>")
end

M.telescope = function()
  local m = plugins_maps.telescope

  map.n(m.buffers, ":Telescope buffers<CR>")
  map.n(m.find_files, ":Telescope find_files no_ignore=true<CR>")
  map.n(m.find_hiddenfiles, ":Telescope find_files hidden=true<CR>")
  map.n(m.git_commits, ":Telescope git_commits<CR>")
  map.n(m.git_status, ":Telescope git_status<CR>")
  map.n(m.help_tags, ":Telescope help_tags<CR>")
  map.n(m.live_grep, ":Telescope live_grep<CR>")
  map.n(m.oldfiles, ":Telescope oldfiles<CR>")
  map.n(m.themes, ":Telescope themes<CR>")

end

M.telescope_media = function()
  local m = plugins_maps.telescope.telescope_media

  map.n(m.media_files, ":Telescope media_files<CR>")
end

M.codeRunner = function()
  map.n("<F5>", ":lua require('CodeRunner').run()<CR>")
  map.n("<C-space>", ":lua require'CodeRunner'.show()<CR>")
  map.n("<C-space>", "<C-\\><C-n>:lua require'CodeRunner'.hide()<CR>")
end

return M
