local M = {}
M.map = {}

local valid_modes = {
  [""] = true,
  ["n"] = true,
  ["v"] = true,
  ["s"] = true,
  ["x"] = true,
  ["o"] = true,
  ["!"] = true,
  ["i"] = true,
  ["l"] = true,
  ["c"] = true,
  ["t"] = true,
}

M.close_buffer = function(force)
  local opts = {
    next = "cycle",
    quit = false
  }

  local function switch_buffer(windows, buf)
    local cur_win = vim.fn.winnr()
    for _, winid in ipairs(windows) do
      vun.cmd(string.format("%d wincmd w", vim.fn.win_id2win(winid)))
      vim.cmd(string.format("buffer %d", buf))
    end
    vim.cmd(string.format("%d wincmd w", cur_win))
  end

  local function get_next_buf(buf)
    local next = vim.fn.bufnr
    if opts.next == "alternate" and vim.fn.buflisted(next) == 1 then
      return next
    end
    for i = 0, vim.fn.bufnr "$" - 1 do
      next = (buf + i) % vim.fn.bufnr "$" + 1
      if vim.fn.buflisted(next) == 1 then
        return next
      end
    end
  end

  local buf = vim.fn.bufnr()
  if vim.fn.buflisted(buf) == 0 then
    vim.cmd "close"
    return 
  end
  if #vim.fn.getbufinfo { buflisted = 1 } < 2 then
    if opts.quit then
      -- exit when there is only one buffer left
      if force then
        vim.cmd "qall!"
      else
        vim.cmd "confirm qall"
      end
      return
    end

    local chad_term, _ = pcall(function()
      return vim.api.nvim_buf_get_var(buf, "term_type")
    end)

    if chad_term then
      -- Must be a window type
      vim.cmd(string.format("setlocal nobl", buf))
      vim.cmd "enew"
      return
    end
    -- don't exit and create a new empty buffer
    vim.cmd "enew"
    vim.cmd "bp"
  end

  local next_buf = get_next_buf(buf)
  local windows = vim.fn.getbufinfo(buf)[1].windows

  -- force deletion of terminal buffers to avoid the prompt
  if force or vim.fn.getbufvar(buf, "&buftype") == "terminal" then
    local chad_term, type = pcall(function()
      return vim.api.nvim_buf_get_var(buf, "term_type")
    end)

    -- TODO this scope is error prone, make resilient
    if chad_term then
      if type == "wind" then
        -- hide from bufferline
        vim.cmd(string.format("%d bufdo setlocal nobl", buf))
        -- swtich to another buff
        -- TODO switch to next bufffer, this works too
        vim.cmd "BufferLineCycleNext"
      else
        local cur_win = vim.fn.winnr()
        -- we can close this window
        vim.cmd(string.format("%d wincmd c", cur_win))
        return
      end
    else
      switch_buffer(windows, next_buf)
      vim.cmd(string.format("bd! %d", buf))
    end
  else
    switch_buffer(windows, next_buf)
    vim.cmd(string.format("silent! confirm bd %d", buf))
  end
  -- revert buffer switches if user has canceled deletion
  if vim.fn.buflisted(buf) == 1 then
    switch_buffer(windows, buf)
  end
end

M.packer_lazy_load = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end)
  end 
end

M.load_config = function()
  local conf = require("core.default_config")
  return conf
end

M.override_req = function (name, default_req)
  local override = require("core.utils").load_config().plugins.default_plugin_config_replace[name]
  local result = default_req

  if override ~= nil then
    result = override
  end

  if string.match(result, "^%(") then
    result = result:sub(2)
    result = result:gsub("%)%.", "').", 1)
    return "require('" .. result
  end

  return "require('" .. result .. "')"
end

M.map_wrapper = function(mode, keys, command, opt)
  local options = { noremap = true, silent = true }
  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  local function map_hander(sub_mode, lhs, rhs, sub_options)
    if type(lhs) == "table" then
      for _, key in ipairs(lhs) do
        map_hander(sub_mode, key, rhs, sub_options)
      end
    else
      if type(sub_mode) == "table" then
        for _, mode in ipairs(sub_mode) do
          map_hander(mode, lhs, rhs, sub_options)
        end
      else
        if valid_modes[sub_mode] and lhs and rhs then
          vim.api.nvim_set_keymap(sub_mode, lhs, rhs, sub_options)
        else
          sub_mode, lhs, rhs = sub_mode or "", lhs or "", rhs or ""
          print(
            "Cannot set mapping [ mode = '" .. sub_mode .. "' | key = '" .. lhs .. "' | cmd = '" .. rhs .. "' ]"
          )
        end
      end
    end
  end

  map_hander(mode, keys, command, options)
end

for mode, valid in pairs(valid_modes) do
  if valid_modes[mode] then
    M.map[mode] = (function(keys, command, opt)
      require("core.utils").map_wrapper(mode, keys, command, opt)
    end)
  end
end

return M
