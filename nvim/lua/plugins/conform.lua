vim.pack.add({
    {src = "https://github.com/stevearc/conform.nvim"}
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt", stop_after_first = true },
        python = { "ruff_format", "isort", "black", stop_after_first = true },
        json = { "oxfmt", "prettier", stop_after_first = true },
        jsonc = { "oxfmt", "prettier", stop_after_first = true },
        javascript = { "oxfmt", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "prettier", stop_after_first = true },
        javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
        typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
        css = { "oxfmt", "prettier", stop_after_first = true },
        scss = { "oxfmt", "prettier", stop_after_first = true },
        html = { "oxfmt", "prettier", stop_after_first = true },
        vue = { "oxfmt", "prettier", stop_after_first = true },
        svelte = { "oxfmt", "prettier", stop_after_first = true },
        astro = { "oxfmt", "prettier", stop_after_first = true },
        yaml = { "oxfmt", "prettier", stop_after_first = true },
        markdown = { "oxfmt", "prettier", stop_after_first = true },
        ["markdown.mdx"] = { "oxfmt", "prettier", stop_after_first = true },
        graphql = { "oxfmt", "prettier", stop_after_first = true },
        xml = { "prettier", stop_after_first = true }, -- oxfmt doesn't support xml
        toml = { "taplo" },
        nix = { "nixfmt" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

