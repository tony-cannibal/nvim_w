local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local FileNameBlock = require("heirline.winbar.filename")
local Space = { provider = " " }
local colors = require("heirline.colors." .. vim.g.colorscheme)


local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = { fg = colors.bg_darker, bold = true },
}

local TerminalName = {
    -- we could add a condition to check that buftype == 'terminal'
    -- or we could do that later (see #conditional-statuslines below)
    provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
        return " " .. tname
    end,
    hl = { fg = colors.bg_darker, bold = true },
}

local WinBars = {
    fallthrough = false,
    { -- A special winbar for terminals
        condition = function()
            return conditions.buffer_matches({ buftype = { "terminal" } })
        end,
        utils.surround({ "", "" }, colors.grey, {
            FileType,
            Space,
            TerminalName,
        }),
    },
    { -- An inactive winbar for regular files
        condition = function()
            return not conditions.is_active()
        end,
        utils.surround({ "", "" }, colors.bg, { hl = { fg = "gray", force = true }, FileNameBlock }),
        hl = { bg = colors.bg },
    },
    -- A winbar for regular files
    -- condition = function()
    --     local win_amount = #vim.api.nvim_tabpage_list_wins(0)
    --     return win_amount > 1
    -- end,
    -- utils.surround({ "  ", "" }, colors.bg, { hl = { fg = colors.bg_darker }, FileNameBlock }),
    utils.surround({ "", "" }, colors.bg, { hl = { fg = colors.bg_darker }, FileNameBlock }),
    hl = { bg = colors.bg_darker }
}

return WinBars
