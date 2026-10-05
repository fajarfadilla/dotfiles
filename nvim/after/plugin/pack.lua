local function installed_names()
  return vim.tbl_map(function(p) return p.spec.name end, vim.pack.get())
end

local function delete_plugins(names)
  vim.pack.del(names)
  vim.notify('Deleted: ' .. table.concat(names, ', '))
end

vim.api.nvim_create_user_command('PackDel', function(opts)
  if #opts.fargs > 0 then
    delete_plugins(opts.fargs)
    return
  end
  vim.ui.select(installed_names(), { prompt = 'Delete plugin:' }, function(choice)
    if choice then delete_plugins({ choice }) end
  end)
end, {
  nargs = '*',
  complete = function() return installed_names() end,
  desc = 'Delete installed vim.pack plugins',
})
