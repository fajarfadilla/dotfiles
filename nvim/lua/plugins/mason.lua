vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" }
})

local mason = require("mason")

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
