return {
  -- 'dasupradyumna/midnight.nvim',
  -- priority = 1000,
  -- init = function()
  --   vim.cmd.colorscheme 'midnight'
  --
  --   -- You can configure highlights by doing something like:
  --   vim.cmd.hi 'Comment gui=none'
  -- end,

  'metalelf0/base16-black-metal-scheme',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'base16-black-metal'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
