return {
    "rebelot/heirline.nvim",
    event = "UIEnter",
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'mfussenegger/nvim-dap',
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        local conditions = require("heirline.conditions")
        local statusline = require("heirline.statusline.statusline")
        local winbar = require("heirline.winbar.winbar")
        local bufferline = require("heirline.tabline.tabline")

        local win_amount = #vim.api.nvim_tabpage_list_wins(0)

        require("heirline").setup({
            statusline = statusline,
            winbar = winbar,
            tabline = bufferline,
            opts = {
                -- if the callback returns true, the winbar will be disabled for that window
                -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
                disable_winbar_cb = function(args)
                    return conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "help", "quickfix" },
                        filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
                    }, args.buf)
                end,
            },
        })
    end
}
