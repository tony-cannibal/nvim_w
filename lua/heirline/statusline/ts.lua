local colors = require("heirline.colors." .. vim.g.colorscheme)

Treesitter = {
    condition = function()
        return require "nvim-treesitter.parsers".has_parser()
    end,
    provider = " ",
    {
        provider = function()
            -- local icon = " "
            local status = require "nvim-treesitter.parsers".has_parser()
            if status == true then
                return "TS"
            else
                return ""
            end
        end,
        hl = { fg = colors.fg }
    },
    hl = { fg = colors.blue }
}

return Treesitter
