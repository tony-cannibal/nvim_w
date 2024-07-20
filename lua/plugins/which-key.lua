return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({
            preset = "modern",
            win = {
                -- don't allow the popup to overlap with the cursor
                no_overlap = true,
                -- width = 1,
                height = { min = 4, max = 25 },
                -- col = 0,
                -- row = math.huge,
                border = "rounded",
                padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
                title = false,
                title_pos = "center",
                zindex = 1000,
                -- Additional vim.wo and vim.bo options
                bo = {},
                wo = {
                    winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                },
            },
        })
        -- local mappings
        wk.add({
            { "<leader>q", "<cmd>q<cr>",              desc = "Quit",           mode = "n" },
            { "<leader>w", "<cmd>w<cr>",              desc = "Save",           mode = "n" },
            { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "NvimTreeToggle", mode = "n" },
        })

        -- groups
        -- Split
        wk.add({
            mode = "n",
            { "<leader>s",  group = "Split" },
            { "<leader>sh", "<cmd>split<cr>",  desc = "Horizontal" },
            { "<leader>sv", "<cmd>vsplit<cr>", desc = "Vertical" },
        })
        wk.add({
            mode = "n",
            { "<leader>l",  group = "Lsp" },
            { "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>",   desc = "Format" },
            { "<leader>li", "<cmd>LspInfo<cr>",                                  desc = "LspInfo" },
            { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",            desc = "Code Action" },
            { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", desc = "Next Diagnostic" },
            { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc = "Prev Diagnostic" },
            { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                 desc = "Rename" },
            { "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>",         desc = "signature Help" },
            { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>",          desc = "Set Loc List" },
        })
    end
}
