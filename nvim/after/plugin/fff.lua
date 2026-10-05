-- Package name changed from `fff.nvim` to `fff`. If you installed fff.nvim before, clean with `:packdel fff.nvim`
vim.pack.add({ 'https://github.com/dmtrKovalenko/fff' })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('fff') end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = true, show_scores = true },
}
local fff = function() return require('fff') end

local function ask_dir(prompt, fn)
  vim.ui.input({ prompt = prompt, default = vim.fn.getcwd() .. '/', completion = 'dir' }, function(path)
    if path and path ~= '' then fn(vim.fn.expand(path)) end
  end)
end

local map = vim.keymap.set

map('n', '<leader>ff', function() fff().find_files() end,             { desc = 'FFF: Find files' })
map('n', '<leader>fg', function() fff().live_grep() end,              { desc = 'FFF: Live grep' })
map({ 'n', 'x' }, '<leader>fw', function() fff().live_grep_under_cursor() end, { desc = 'FFF: Grep word/selection' })
map('n', '<leader>fr', function() fff().scan_files() end,             { desc = 'FFF: Rescan files' })
map('n', '<leader>fs', function() fff().refresh_git_status() end,     { desc = 'FFF: Refresh git status' })

map('n', '<leader>fd', function()
  ask_dir('Find in dir: ', function(path) fff().find_files_in_dir(path) end)
end, { desc = 'FFF: Find files in dir' })

map('n', '<leader>fc', function()
  ask_dir('New root: ', function(path) fff().change_indexing_directory(path) end)
end, { desc = 'FFF: Change root dir' })
