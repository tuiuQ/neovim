local hooks, M = {}, {}

local allowed_hooks = {
  ["install_plugins"] = true,
  ["setup_mappings"] = true
}

M.add = function (name, fn)
  if not allowed_hooks[name] then
    print("不支持自定义方式 " .. name)
  end
  if not hooks[name] then
    hooks[name] = {}
  end

  table.insert(hooks[name], fn)
end

M.run = function(name, args)
  if hooks[name] then
    for _, hook in pairs(hooks[name]) do
      hook(args)
    end
  end
end

return M