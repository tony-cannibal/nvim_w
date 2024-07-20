return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "lukas-reineke/lsp-format.nvim",
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
    },
    event = "BufEnter",
    lazy = false,
    config = function()
        require("mason").setup({
            ui = {
                border = "single",
            }
        })

        local lspconfig = require("lspconfig")

        require('lspconfig.ui.windows').default_options = {
            border = "single",
        }

        require('mason-lspconfig').setup({
            ensure_installed = { "lua_ls", "pylsp", "bashls", "tsserver" },
        })

        require("lsp-format").setup {}

        local signs = {
            Error = vim.g.error_icon,
            Warn = vim.g.warn_icon,
            Hint = vim.g.hint_icon,
            Info = vim.g.info_icon
        }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true }
            local keymap = vim.api.nvim_buf_set_keymap

            require("lsp-format").on_attach(client)

            keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
            keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
            keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
            keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
            keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
            keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
            keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        end


        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
        }

        vim.diagnostic.config {
            float = {
                border = 'single',
            }
        }

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("neodev").setup({
            -- add any options here, or leave empty to use the default settings
        })

        require("neoconf").setup({
            -- override any of the default settings here
        })

        require('mason-lspconfig').setup_handlers({
            function(server_name) -- default handler (optional)
                lspconfig[server_name].setup {
                    on_attach = on_attach,
                    handlers = handlers,
                    capabilities = capabilities,
                }
            end,
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup {
                    on_attach = on_attach,
                    handlers = handlers,
                    settings = {
                        Lua = {
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { 'vim' },
                            },
                            workspace = {
                                checkThirdParty = false,
                            }
                        },
                    },
                }
            end,
            ['tsserver'] = function()
                lspconfig.tsserver.setup {
                    on_attach = on_attach,
                    handlers = handlers,
                    settings = {
                        diagnostics = { ignoredCodes = { 80001 } }
                    }
                }
            end
        })
    end
}
