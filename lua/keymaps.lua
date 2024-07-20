local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Do not yank with x

keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", "<cmd>q<CR>", {})

keymap("n", "x", '"_x', opts)
keymap("n", ";", ":", {})

-- Icrease/Decrease
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)

-- Delete Word Backwards
keymap("n", "dw", 'vb"_d', { noremap = true, silent = true })

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- keymap("n", "<leader>w", ":w<CR>", opts)
-- keymap("n", "<leader>q", ":q<CR>", opts)
-- keymap("n", "<leader>c", ":bd<CR>", opts)
-- keymap("n", "<leader>v", ":vsplit<CR>", opts)
-- keymap("n", "<leader>V", ":vsplit<CR>", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<S-h>", "<C-w>h", opts)
keymap("n", "<S-j>", "<C-w>j", opts)
keymap("n", "<S-k>", "<C-w>k", opts)
keymap("n", "<S-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<C-l>", ":bnext<CR>", opts)
keymap("n", "<C-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

keymap("n", "<F7>", "<cmd>ToggleTerm<CR>", opts)
keymap("t", "<F7>", "<cmd>ToggleTerm<CR>", opts)


local function run_curr_python_file()
    -- Get file name in the current buffer
    local file_name = vim.api.nvim_buf_get_name(0)
    -- Get terminal codes for running python file
    local py_cmd = vim.api.nvim_replace_termcodes("python \"" .. file_name .. "\"<cr>", true, false, true)
    -- Get terminal codes for key-press sequence to launch toggleterm in LunarVim
    -- (one may have to use <C-\\> for Ctrl + backslash)
    local lnrvim_togterm_cmd = vim.api.nvim_replace_termcodes("<F7>", true, false, true)
    -- Press keys to launch toggleterm in LunarVim
    -- if check_terminal() == false then
    vim.api.nvim_feedkeys(lnrvim_togterm_cmd, "m", true)
    -- end
    -- Press keys to run python command on current file
    vim.api.nvim_feedkeys(py_cmd, "t", false)
end


local function run_curr_js_file()
    local file_name = vim.api.nvim_buf_get_name(0)
    local py_cmd = vim.api.nvim_replace_termcodes("node \"" .. file_name .. "\"<cr>", true, false, true)
    local lnrvim_togterm_cmd = vim.api.nvim_replace_termcodes("<F7>", true, false, true)

    vim.api.nvim_feedkeys(lnrvim_togterm_cmd, "m", true)
    vim.api.nvim_feedkeys(py_cmd, "t", false)
end

local function run_script()
    local file_type = vim.bo.filetype
    if file_type == "python" then
        run_curr_python_file()
    elseif file_type == "javascript" then
        run_curr_js_file()
    end
end


-- keymap("t", "<F8>", "Lua run_curr_python_file <CR>", opts)

vim.keymap.set({ 'n' }, '<F8>', '', {
    desc = "Run .py file via toggle term",
    -- callback = run_curr_python_file
    callback = run_script
})

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
