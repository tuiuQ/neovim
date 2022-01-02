local hooks = require("core.hooks")

hooks.add("setup_mappings", function(map)
  map.n("S", ":w<CR>", opt)
  map.n("Q", ":q<CR>", opt)
  map.n("<leader>s", ":w!<CR>", opt)
  map.n("<leader>q", ":q!<CR>", opt)
  map.n("J", "5j", opt)
  map.n("K", "5k", opt)
  map.n("H", "7h", opt)
  map.n("L", "7l", opt)
  map.v("J", "5j", opt)
  map.v("K", "5k", opt)
  map.v("H", "7h", opt)
  map.v("L", "7l", opt)
  map.v("<C-c>", "y", opt)
  -- map.n("<C-v>", "p", opt)
  map.v("<C-x>", "d", opt)
  map.n("<C-a>", "gg0yG$", opt)
  map.n("<C-s>", ":w<CR>", opt)
  map.n("<C-q>", ":q<CR>", opt)
  map.n("<esc><esc>", ":nohlsearch<CR>", opt)
  map.n("<F1>", "", opt)

end)

