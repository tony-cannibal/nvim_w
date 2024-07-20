local conditions = require("heirline.conditions")
local colors = require("heirline.colors." .. vim.g.colorscheme)

local LSPActive = {
    condition = conditions.lsp_attached,
    update    = { 'LspAttach', 'LspDetach' },
    provider  = " ",
    {
        condition = conditions.lsp_attached,
        update    = { 'LspAttach', 'LspDetach' },

        -- You can keep it simple,
        -- provider = " [LSP]",

        -- Or complicate things a bit and get the servers names
        provider  = function()
            local names = {}
            for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                table.insert(names, server.name)
            end
            -- return " [" .. table.concat(names, " ") .. "]"
            return "[" .. table.concat(names, " ") .. "]"
        end,
        hl        = { fg = colors.fg, bold = false },
    },
    hl = { fg = colors.orange }
}
return LSPActive
