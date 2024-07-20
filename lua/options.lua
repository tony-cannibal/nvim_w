vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
    number = true,
    relativenumber = true,
    clipboard = "unnamedplus",
    mouse = "a",
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    hidden = true,
    fileencoding = "utf-8",
    hlsearch = false,
    ignorecase = true,
    showtabline = 2,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    timeout = true,
    -- timeoutlen = 300,
    timeoutlen = 100,
    undofile = true,
    updatetime = 300,
    writebackup = false,
    cursorline = true,
    numberwidth = 4,
    signcolumn = "yes",
    wrap = false,
    scrolloff = 8,
    sidescrolloff = 8,
    syntax = "on",
    termguicolors = true,
    showmode = false,
    list = true,
    colorcolumn = "80",
    laststatus = 3,
    winblend = 0,
    wildoptions = "pum",
    pumblend = 5,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd [[ set fcs=eob:\ ]] -- remove the tilde char in the end of buffer


-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
