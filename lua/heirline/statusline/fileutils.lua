local utils = require("heirline.utils")
local colors = require("heirline.colors." .. vim.g.colorscheme)

local M = {}

M.FileType = {
    provider = function()
        local type = vim.bo.filetype
        -- return " " .. string.upper(vim.bo.filetype) .. " "
        -- return " " .. vim.bo.filetype .. " "
        return type:gsub("^%l", string.upper)
    end,
    hl = { fg = colors.fg, bold = true },
}

M.FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        return enc ~= 'utf-8' and enc:upper()
    end
}

M.FileFormat = {
    provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= 'unix' and " " .. fmt:upper() .. " "
    end
}

return M
