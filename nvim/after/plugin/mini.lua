vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
})

require('mini.notify').setup()
require('mini.icons').setup()
require('mini.surround').setup()
require('mini.statusline').setup()
require('mini.diff').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()
require('mini.git').setup()

local indentscope = require('mini.indentscope')

indentscope.setup({
  symbol = '│',
  draw = {
    animation = indentscope.gen_animation.none(),
  },
  options = { try_as_border = true },
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Disable mini.indentscope for specific filetypes',
  pattern = {
    'help',
    'oil',
    'neogitstatus',
    'diffview',
    'lazydev',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

