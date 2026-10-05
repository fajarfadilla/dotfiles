vim.pack.add({
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/m00qek/baleia.nvim",
  "https://github.com/nvim-mini/mini.pick",
}, { load = function() end }) -- install only, don't load

vim.api.nvim_create_user_command("Neogit", function(opts)
  vim.api.nvim_del_user_command("Neogit") -- remove this stub
  vim.cmd.packadd("diffview.nvim")
  vim.cmd.packadd("neogit")               -- defines the real :Neogit
  vim.cmd("Neogit " .. opts.args)
end, { nargs = "*" })

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Show Neogit UI" })
